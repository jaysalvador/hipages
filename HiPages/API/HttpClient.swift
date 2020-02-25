//
//  HttpClient.swift
//  HiPages
//
//  Created by Jay Salvador on 25/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

typealias HttpCompletionClosure<T> = ((Result<T, HttpError>) -> Void)

enum HttpMethod: String {
    
    case get = "GET"
    case delete = "DELETE"
    case post = "POST"
    case put = "PUT"
}

protocol HttpClientProtocol {
    
    func request<T>(_ type: T.Type, endpoint: String, httpMethod: HttpMethod, headers: Dictionary<String, String>?, onCompletion: HttpCompletionClosure<T>?) where T: Decodable
}

class HttpClient: HttpClientProtocol {
    
    private let baseUrl: String
    
    private let urlSession: URLSessionProtocol
    
    convenience init?() {
        
        self.init(
            baseUrl: "https://s3-ap-southeast-2.amazonaws.com",
            urlSession: URLSession.shared)
    }
    
    init(baseUrl _baseUrl: String, urlSession _urlSession: URLSessionProtocol) {
        
        self.baseUrl = _baseUrl
        self.urlSession = _urlSession
    }
    
    func request<T>(_ type: T.Type, endpoint: String, httpMethod: HttpMethod, headers: Dictionary<String, String>?, onCompletion: HttpCompletionClosure<T>?) where T: Decodable {
        
        DispatchQueue.background.async {
            
            if let url = URL(string: self.baseUrl + endpoint) {
                
                var request = URLRequest(url: url)
                
                request.httpMethod = httpMethod.rawValue
                
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                if let headers = headers {
                    
                    for (key, value) in headers {
                        
                        request.addValue(value, forHTTPHeaderField: key)
                    }
                }
                
                self.send(request, returnType: type, onCompletion: onCompletion)
            }
        }
    }
    
    private func send<T>(_ request: URLRequest?, returnType: T.Type, onCompletion: HttpCompletionClosure<T>?) where T: Decodable {
        
        guard let request = request else {
            
            onCompletion?(.failure(HttpError.nilRequest))
            
            return
        }
        
        let task = urlSession.dataTask(with: request) { (data, urlResponse, error) -> Void in
                        
            if let httpUrlResponse = urlResponse as? HTTPURLResponse, httpUrlResponse.statusCode < 400 {
                
                if let data = data {
                    
                    do {
                        
                        let decoder = JSONDecoder()
                        
                        decoder.dateDecodingStrategy = .formatted(.yearMonthDay)
                        
                        let decoded = try decoder.decode(returnType, from: data)
                        
                        DispatchQueue.main.async {
                                                        
                            onCompletion?(.success(decoded))
                        }
                    }
                    catch {
                        
                        DispatchQueue.main.async {
                            
                            let rawString = String(data: data, encoding: .utf8)
                                                        
                            onCompletion?(.failure(HttpError.decoding(error)))
                        }
                    }
                    
                    return
                }
            }
            
            var statusCode: Int?
            
            if let httpUrlResponse = urlResponse as? HTTPURLResponse {
                
                statusCode = httpUrlResponse.statusCode
            }
            
            DispatchQueue.main.async {
                
                onCompletion?(.failure(HttpError.unknown(statusCode: statusCode, data: data)))
            }
        }
        
        task.resume()
    }
}
