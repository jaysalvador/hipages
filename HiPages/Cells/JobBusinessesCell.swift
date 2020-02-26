//
//  JobBusinessesCell.swift
//  HiPages
//
//  Created by Jay Salvador on 26/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

class JobBusinessesCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet
    private var jobTitleLabel: UILabel?
    
    @IBOutlet
    private var collectionView: UICollectionView?
    
    @IBOutlet
    private var collectionViewWidthConstraint: NSLayoutConstraint?
    
    private(set) var businesses: [Business]?
    
    // MARK: - View life cycle
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.setupCollectionView()
    }
    
    func prepare(job: Job?) -> UICollectionViewCell {
        
        self.businesses = job?.connectedBusinesses
        
        self.collectionView?.reloadData()
        
        self.collectionView?.flowLayout?.itemSize.width = AvatarCell.size
        
        self.collectionView?.flowLayout?.itemSize.height = AvatarCell.size
        
        if let businesses = job?.connectedBusinesses, businesses.count > 0 {
            
            let maxAvatarsInLine = floor(self.frame.width / AvatarCell.size)
            
            self.collectionViewWidthConstraint?.constant = min(maxAvatarsInLine * AvatarCell.size, CGFloat(businesses.count) * AvatarCell.size)

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
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.businesses?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let business = self.businesses?[indexPath.item],
            let cell = self.collectionView?.dequeueReusable(cell: AvatarCell.self, for: indexPath) {

            return cell.prepare(business: business)
        }
        
        return UICollectionViewCell()
    }
    
    class func size(givenWidth width: CGFloat, job: Job?) -> CGSize {
        
        let labelHeight: CGFloat = 60.0
        
        let height = labelHeight + JobBusinessesCell.getStackViewHeight(givenWidth: width, job: job)
        
        return CGSize(width: width, height: height)
    }
    
    class func getStackViewHeight(givenWidth width: CGFloat, job: Job?) -> CGFloat {
        
        let avatars: Int = job?.connectedBusinesses?.count ?? 0
        
        if avatars > 0 {
            
            let availableWidth = width - 20.0
            
            let maxAvatarsInLine = floor(availableWidth / AvatarCell.size)
            
            let maxLinesOfAvatars = Int(ceil(CGFloat(avatars) / maxAvatarsInLine))
            
            return CGFloat(maxLinesOfAvatars) * AvatarCell.size
        }
        
        return .zero
    }

}
