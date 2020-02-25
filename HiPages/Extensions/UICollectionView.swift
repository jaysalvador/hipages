//
//  UICollectionView.swift
//  HiPages
//
//  Created by Jay Salvador on 22/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    // MARK: Convenience - Registration
    
    func register(cell: UICollectionViewCell.Type) {
        
        let name = String(describing: cell)
        
        self.register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
    }
    
    func register(supplementaryView: UICollectionReusableView.Type, ofKind elementKind: String) {
        
        let name = String(describing: supplementaryView)
        
        self.register(UINib(nibName: name, bundle: nil), forSupplementaryViewOfKind: elementKind, withReuseIdentifier: name)
    }
    
    // MARK: Convenience - Dequeueing
    
    func dequeueReusable<T: UICollectionViewCell>(cell: T.Type, for indexPath: IndexPath) -> T? {
        
        let name = String(describing: cell)
        
        return self.dequeueReusableCell(withReuseIdentifier: name, for: indexPath) as? T
    }
    
    func dequeueReusable<T: UICollectionReusableView>(supplementaryView: T.Type, ofKind elementKind: String, for indexPath: IndexPath) -> T? {
        
        let name = String(describing: supplementaryView)
        
        return self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: name, for: indexPath) as? T
    }
    
    // MARK: Convenience - Layouts
    
    var flowLayout: UICollectionViewFlowLayout? {
        
        return self.collectionViewLayout as? UICollectionViewFlowLayout
    }
}
