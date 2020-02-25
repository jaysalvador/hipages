//
//  JobClient.swift
//  HiPages
//
//  Created by Jay Salvador on 25/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

protocol JobClientProtocol {
    
    func getJobs(onCompletion: HttpCompletionClosure<JobClient.JobsResponse>?)
}

class JobClient: HttpClient, JobClientProtocol {
    
    func getJobs(onCompletion: HttpCompletionClosure<JobClient.JobsResponse>?) {
        
        let endpoint = "/hipgrp-assets/tech-test/jobs.json"
        
        self.request(JobClient.JobsResponse.self, endpoint: endpoint, httpMethod: .get, headers: nil, onCompletion: onCompletion)
    }
}

extension JobClient {
    
    struct JobsResponse: Decodable {
        
        var jobs: [Job]?
    }
}
