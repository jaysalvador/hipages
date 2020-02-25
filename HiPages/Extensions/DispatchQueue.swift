//
//  DispatchQueue.swift
//  HiPages
//
//  Created by Jay Salvador on 25/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    class var background: DispatchQueue {
        
        return DispatchQueue.global(qos: .background)
    }
}
