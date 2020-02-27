//
//  UIView.swift
//  HiPages
//
//  Created by Jay Salvador on 25/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: Float {
        
        set {
            
            self.layer.cornerRadius = CGFloat(newValue)
        }
        get {
            
            return Float(self.layer.cornerRadius)
        }
    }
    
    @IBInspectable
    var borderWidth: Float {
        
        set {
            
            self.layer.borderWidth = CGFloat(newValue)
        }
        get {
            
            return Float(self.layer.borderWidth)
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        
        set {
            
            self.layer.borderColor = newValue?.cgColor
        }
        get {
            
            if let cgColor = self.layer.borderColor {
                
                return UIColor(cgColor: cgColor)
            }
            
            return nil
        }
    }
    
    func setBottomBorder(color: UIColor, width: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)

        self.layer.addSublayer(border)
    }
}
