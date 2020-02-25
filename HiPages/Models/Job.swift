//
//  Job.swift
//  HiPages
//
//  Created by Jay Salvador on 25/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

enum JobStatus: String, Codable {
    
    case inProgress = "In Progress"
    case closed = "Closed"
}

struct Job: Codable {
    
    var id: Int?
    var category: String?
    var postedDate: Date?
    var status: JobStatus?
    var connectedBusinesses: [Business]?
    var detailsLink: String?
}
