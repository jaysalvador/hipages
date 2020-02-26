//
//  UIImageView.swift
//  HiPages
//
//  Created by Jay Salvador on 26/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(_ stringUrl: String?, clearCache: Bool? = false) {
        
        self.image = nil
        
        guard let stringUrl = stringUrl else {
            
            return
        }
        
        guard let url = URL(string: stringUrl) else {
            
            return
        }
        
        self.setImage(url, clearCache: clearCache)
    }
    
    func setImage(_ url: URL?, clearCache: Bool? = false, indicatorType: IndicatorType? = .activity) {
        
        self.image = nil
        
        guard let url = url else {
            
            return
        }
        
        if clearCache == true {
        
            let cache = ImageCache.default
        
            cache.removeImage(forKey: url.absoluteString)
        }
        
        self.kf.indicatorType = indicatorType ?? .none
        
        self.kf.setImage(
            with: ImageResource(downloadURL: url, cacheKey: url.absoluteString),
            placeholder: nil,
            options: nil,
            progressBlock: nil) { [weak self] _ in
                
                self?.contentMode = .scaleAspectFill
                self?.setNeedsLayout()
        }
    }
    
    func tinted(_ color: UIColor) -> UIImageView {
        
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
        return self
    }

    // Work around to bug with tinting UIImageView PDFs.
    // https://stackoverflow.com/a/43923428/1004227
    // https://gist.github.com/buechner/3b97000a6570a2bfbc99c005cb010bac
    // http://openradar.appspot.com/18448072
    override open func awakeFromNib() {

        super.awakeFromNib()

        self.tintColorDidChange()
    }
}
