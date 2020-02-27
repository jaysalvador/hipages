//
//  Array.swift
//  HiPages
//
//  Created by Jay Salvador on 27/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension Array {
    
    func group(into size: Int) -> [[Element]] {
        
        return stride(from: 0, to: count, by: size).map {
            
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
