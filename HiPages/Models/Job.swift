//
//  Job.swift
//  HiPages
//
//  Created by Jay Salvador on 25/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

enum JobStatus: String, Codable {
    
    case inProgress = "in progress"
    case closed = "closed"
    
    init?(rawString: String?) {
        
        guard let rawString = rawString?.lowercased() else {
            
            return nil
        }
        
        self.init(rawValue: rawString)
    }
}

struct Job: Codable {
    
    var id: Int?
    var category: String?
    var postedDate: Date?
    var status: JobStatus?
    var connectedBusinesses: [Business]?
    var detailsLink: String?

    enum CodingKeys: String, CodingKey {

        case id = "jobId"
        case category
        case postedDate
        case status
        case connectedBusinesses
        case detailsLink
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.category = try container.decodeIfPresent(String.self, forKey: .category)
        self.detailsLink = try container.decodeIfPresent(String.self, forKey: .detailsLink)
        self.connectedBusinesses = try container.decodeIfPresent([Business].self, forKey: .connectedBusinesses)
        
        if let status = try container.decodeIfPresent(String.self, forKey: .status) {

            self.status = JobStatus(rawString: status)
        }
        
        if let dateString = try container.decodeIfPresent(String.self, forKey: .postedDate) {
            
            if let postedDate = DateFormatter.yearMonthDay.date(from: dateString) {
            
                self.postedDate = postedDate
            }
        }
    }
}
