//
//  JobBusinessesCell.swift
//  HiPages
//
//  Created by Jay Salvador on 26/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

class JobBusinessesCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet
    private var jobTitleLabel: UILabel?
    
    @IBOutlet
    private var collectionView: UICollectionView?
    
    private var businesses: [[Business?]]?
    
    // MARK: - View life cycle
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.setupCollectionView()
    }
    
    func prepare(job: Job?) -> UICollectionViewCell {
        
        self.businesses = [[Business]]()
        
        self.collectionView?.reloadData()
        
        self.collectionView?.flowLayout?.itemSize.width = AvatarCell.size
        
        self.collectionView?.flowLayout?.itemSize.height = AvatarCell.size
        
        if let businesses = job?.connectedBusinesses, businesses.count > 0 {
            
            let maxAvatarsInLine = min(CGFloat(businesses.count), floor(self.frame.width / AvatarCell.size))
            
            self.businesses = businesses.group(into: Int(maxAvatarsInLine))
            
            self.jobTitleLabel?.text = "You have hired \(businesses.count) business\(businesses.count == 1 ? "" : "es")"
        }
        else {

            self.jobTitleLabel?.text = "Connecting you with businesses"
        }
        
        return self
    }
    
    // MARK: - Setup
    
    private func setupCollectionView() {
        
        // MARK: Register cells
        
        self.collectionView?.register(cell: AvatarCell.self)
    }
    
    // MARK: - UICollectionViewDelegate & UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return self.businesses?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let businessGroup = self.businesses?[section] {

            return businessGroup.count
        }
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let businessGroup = self.businesses?[indexPath.section],
            let business = businessGroup[indexPath.item],
            let cell = self.collectionView?.dequeueReusable(cell: AvatarCell.self, for: indexPath) {

            return cell.prepare(business: business)
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let items = collectionView.numberOfItems(inSection: section)
        
        let padding = (collectionView.frame.width - (CGFloat(items) * AvatarCell.size)) / 2
        
        return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    }
    
    // MARK: class functions
    
    class func size(givenWidth width: CGFloat, job: Job?) -> CGSize {
        
        let labelHeight: CGFloat = 60.0
        
        let height = labelHeight + JobBusinessesCell.getStackViewHeight(givenWidth: width, job: job)
        
        return CGSize(width: width, height: height)
    }
    
    class func getStackViewHeight(givenWidth width: CGFloat, job: Job?) -> CGFloat {
        
        let avatars: Int = job?.connectedBusinesses?.count ?? 0
        
        if avatars > 0 {
            
            let availableWidth = width - 20.0
            
            let maxAvatarsInLine: CGFloat = floor(availableWidth / AvatarCell.size)
            
            let maxLinesOfAvatars = Int(ceil(CGFloat(avatars) / maxAvatarsInLine))
            
            return CGFloat(maxLinesOfAvatars) * AvatarCell.size
        }
        
        return .zero
    }

}
