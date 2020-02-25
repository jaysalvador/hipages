//
//  Business.swift
//  HiPages
//
//  Created by Jay Salvador on 25/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

struct Business: Codable {
    
    var id: Int?
    var thumbnail: String?
    var hired: Bool?

    enum CodingKeys: String, CodingKey {

        case id = "businessId"
        case thumbnail
        case hired = "isHired"
    }
}

extension Business: Equatable {
    
    static func == (lhs: Business, rhs: Business) -> Bool {
        
        guard let lhsId = lhs.id, let rhsId = rhs.id else {
            
            return false
        }
        
        return lhsId == rhsId
    }
}
