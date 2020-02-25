//
//  UIColor.swift
//  HiPages
//
//  Created by Jay Salvador on 25/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var orange: UIColor {
        
        return rgb(255, 122, 18)
    }
    
    // MARK: Convenience
    
    private class func rgb(_ _red: CGFloat, _ _green: CGFloat, _ _blue: CGFloat) -> UIColor {
        
        return rgba(_red, _green, _blue, 1.0)
    }
    
    private class func rgba(_ _red: CGFloat, _ _green: CGFloat, _ _blue: CGFloat, _ _alpha: CGFloat) -> UIColor {
        
        return UIColor(red: _red / 255.0, green: _green / 255.0, blue: _blue / 255.0, alpha: _alpha)
    }
}
