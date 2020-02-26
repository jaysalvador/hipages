//
//  AvatarView.swift
//  HiPages
//
//  Created by Jay Salvador on 26/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

final class AvatarView: UIView {

    static let side: CGFloat = 80
    
    convenience init() {
        
        let rect = CGRect(x: 0, y: 0, width: AvatarView.side, height: AvatarView.side)
        
        self.init(frame: rect)
    }
    
    func update(business: Business?) {
        
        let margin: CGFloat = 8.0
        
        let labelWidth: CGFloat = 40.0
        
        let imageWidth = AvatarView.side - margin
        
        let imageRect = CGRect(x: margin, y: margin, width: imageWidth, height: imageWidth)
        
        let hideRect = CGRect(x: margin + ((imageWidth - labelWidth) / 2), y: imageRect.width - (margin / 2), width: labelWidth, height: margin * 2)
        
        // image
        
        let imageView = UIImageView(frame: imageRect)
        
        imageView.backgroundColor = .lightGray
        imageView.cornerRadius = Float(imageRect.width / 2)
        imageView.clipsToBounds = true
        imageView.setImage(business?.thumbnail)
        
        self.addSubview(imageView)
        
        if business?.hired == true {

            let label = UILabel(frame: hideRect)
            label.font = .sourceSansBold(ofSize: 12)
            label.text = "HIRED"
            label.backgroundColor = .orange
            label.textColor = .white
            label.cornerRadius = 4.0
            label.textAlignment = .center
            self.addSubview(label)
        }
    }
}
