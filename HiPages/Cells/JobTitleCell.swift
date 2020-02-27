//
//  JobTitleCell.swift
//  HiPages
//
//  Created by Jay Salvador on 25/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

typealias ButtonTouchUpInsideClosure = (() -> Void)

class JobTitleCell: UICollectionViewCell {

    @IBOutlet
    private var jobTitleLabel: UILabel?
    
    @IBOutlet
    private var jobDateLabel: UILabel?
    
    @IBOutlet
    private var jobStatusLabel: UILabel?
    
    @IBOutlet
    private var closeButton: UIButton?
    
    @IBOutlet
    private var moreButton: UIButton?
    
    private var onCloseButtonTapped: ButtonTouchUpInsideClosure?
    
    func prepare(job: Job?, onCloseButtonTapped: ButtonTouchUpInsideClosure? = nil) -> UICollectionViewCell {
        
        self.onCloseButtonTapped = onCloseButtonTapped
        
        self.jobDateLabel?.text = nil
        
        self.jobTitleLabel?.text = job?.category
        
        self.moreButton?.isHidden = (job?.status == .closed)
        
        if let date = job?.postedDate {
            
            let calendar = Calendar.current
            let dateComponents = calendar.component(.day, from: date)
            let numberFormatter = NumberFormatter()

            numberFormatter.numberStyle = .ordinal

            let day = numberFormatter.string(from: dateComponents as NSNumber) ?? ""
            
            self.jobDateLabel?.text = "Posted: \(day) \(DateFormatter.monthYear.string(from: date))"
        }
        
        self.jobStatusLabel?.text = job?.status?.rawValue.capitalized

        return self
    }
    
    @IBAction func moreButtonTouchUpInside(_ sender: Any) {
        
        self.closeButton?.isHidden = !(self.closeButton?.isHidden == true)
    }
    
    @IBAction func closeButtonTouchUpInside(_ sender: Any) {
        
        self.closeButton?.isHidden = true
        
        self.onCloseButtonTapped?()
    }
}
