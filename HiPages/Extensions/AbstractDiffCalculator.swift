//
//  AbstractDiffCalculator.swift
//  HiPages
//
//  Created by Jay Salvador on 26/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import Dwifft

extension AbstractDiffCalculator where Section: Equatable, Value: Equatable {
    
    func indexPath(forSection section: Section, value: Value) -> IndexPath? {
        
        let numberOfSections = self.numberOfSections()

        for sectionIndex in 0..<numberOfSections {

            if self.value(forSection: sectionIndex) == section {
             
                let numberOfObjects = self.numberOfObjects(inSection: sectionIndex)
                
                for itemIndex in 0..<numberOfObjects {
                    
                    let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
                    
                    if self.value(atIndexPath: indexPath) == value {
                        
                        return indexPath
                    }
                }
            }
        }

        return nil
    }

}
