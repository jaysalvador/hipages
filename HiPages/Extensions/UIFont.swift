//
//  UIFont.swift
//  HiPages
//
//  Created by Jay Salvador on 26/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func sourceSansSemiBold(ofSize fontSize: CGFloat) -> UIFont {
        
        return UIFont(name: "SourceSansPro-SemiBold", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .regular)
    }
    
    class func sourceSansRegular(ofSize fontSize: CGFloat) -> UIFont {
        
        return UIFont(name: "SourceSansPro-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    class func sourceSansBold(ofSize fontSize: CGFloat) -> UIFont {
        
        return UIFont(name: "SourceSansPro-Bold", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .semibold)
    }
}
