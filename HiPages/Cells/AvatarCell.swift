//
//  AvatarCell.swift
//  HiPages
//
//  Created by Jay Salvador on 26/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    static let size: CGFloat = 90.0

    @IBOutlet
    private var imageView: UIImageView?
    
    @IBOutlet
    private var hiredView: UIView?
    
    func prepare(business: Business?) -> UICollectionViewCell {
        
        self.hiredView?.isHidden = business?.hired == false
        
        self.imageView?.setImage(business?.thumbnail)
        
        return self
    }

}
