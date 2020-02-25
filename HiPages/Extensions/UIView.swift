//
//  UIView.swift
//  HiPages
//
//  Created by Jay Salvador on 25/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

extension UIView {
    
    func setBottomBorder(color: UIColor, width: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)

        self.layer.addSublayer(border)
    }
}
