//
//  CollectionViewController.swift
//  HiPages
//
//  Created by Jay Salvador on 22/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import Dwifft

class JCollectionViewController<Section: Equatable, Item: Equatable>: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Sections and items
    
    typealias SectionAndItems = (Section, [Item])
    
    var diffCalculator: CollectionViewDiffCalculator<Section, Item>?
    
    var sectionsAndItems: Array<SectionAndItems> {
        
        fatalError()
    }
    
    private var sectionedValues: SectionedValues<Section, Item> {
        
        return SectionedValues<Section, Item>(self.sectionsAndItems)
    }
    
    // MARK: - Outlets
    
    @IBOutlet
    var collectionView: UICollectionView?
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError()
    }
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupCollectionView()
        
    }
         
    // MARK: - Setup

    func setupCollectionView() {

        // MARK: Diff calculator

        self.diffCalculator = CollectionViewDiffCalculator(collectionView: self.collectionView, initialSectionedValues: self.sectionedValues)

        self.collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: UICollectionReusableView.self))

        self.collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: UICollectionReusableView.self))
    }
    
    // MARK: - Update
    
    func updateSectionsAndItems(forced: Bool = false) {
        
        if forced {
            
            self.diffCalculator?.sectionedValues = SectionedValues<Section, Item>([])
        }
        
        self.diffCalculator?.sectionedValues = self.sectionedValues
    }
    
    // MARK: - UICollectionViewDataSource & UICollectionViewDelegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if let numberOfSections = self.diffCalculator?.numberOfSections() {
            
            return numberOfSections
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let numberOfObjects = self.diffCalculator?.numberOfObjects(inSection: section) {
            
            return numberOfObjects
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let section = self.diffCalculator?.value(forSection: indexPath.section),
            let view = self.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: section, indexPath: indexPath) {
            
            return view
        }
        
        return self.collectionView?.dequeueReusable(supplementaryView: UICollectionReusableView.self, ofKind: kind, for: indexPath) ?? UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at section: Section, indexPath: IndexPath) -> UICollectionReusableView? {
        
        return nil
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let section = self.diffCalculator?.value(forSection: indexPath.section),
            let item = self.diffCalculator?.value(atIndexPath: indexPath),
            let cell = self.collectionView(collectionView, cellForSection: section, item: item, indexPath: indexPath) {
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForSection section: Section, item: Item, indexPath: IndexPath) -> UICollectionViewCell? {
        
        fatalError() // needs to be overriden
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let section = self.diffCalculator?.value(forSection: indexPath.section) {
            if let item = self.diffCalculator?.value(atIndexPath: indexPath) {
                
                self.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath, section: section, item: item)
                
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath, section: Section, item: Item) {
        
        // can be overriden
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let section = self.diffCalculator?.value(forSection: indexPath.section),
            let item = self.diffCalculator?.value(atIndexPath: indexPath) {
            
            self.collectionView(collectionView, didSelectItemAtSection: section, item: item)
            self.collectionView(collectionView, didSelectItemAtSection: section, item: item, indexPath: indexPath)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAtSection section: Section, item: Item) {
        
        // can be overriden
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAtSection section: Section, item: Item, indexPath: IndexPath) {
        
        // can be overriden
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if let _section = self.diffCalculator?.value(forSection: section),
            let size = self.collectionView(collectionView, layout: collectionViewLayout, sizeForHeaderIn: _section) {
            
            return size
        }
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForHeaderIn section: Section) -> CGSize? {
        
        return nil
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let section = self.diffCalculator?.value(forSection: indexPath.section),
            let item = self.diffCalculator?.value(atIndexPath: indexPath),
            let size = self.collectionView(collectionView, layout: collectionViewLayout, sizeForSection: section, item: item, indexPath: indexPath) {
            
            return size
        }
        
        return self.collectionView?.flowLayout?.itemSize ?? CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForSection section: Section, item: Item, indexPath: IndexPath) -> CGSize? {
        
        return nil
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if let _section = self.diffCalculator?.value(forSection: section),
            let spacing = self.collectionView(collectionView, layout: collectionViewLayout, minimumLineSpacingFor: _section) {
            
            return spacing
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingFor section: Section) -> CGFloat? {
        
        return nil
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if let _section = self.diffCalculator?.value(forSection: section),
            let spacing = self.collectionView(collectionView, layout: collectionViewLayout, minimumLineSpacingFor: _section) {
            
            return spacing
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingFor section: Section) -> CGFloat? {
        
        return nil
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if let _section = self.diffCalculator?.value(forSection: section),
            let inset = self.collectionView(collectionView, layout: collectionViewLayout, insetFor: _section) {
            
            return inset
        }
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetFor section: Section) -> UIEdgeInsets? {
        
        return nil
    }
    
    // MARK: - Dwifft convenience
    
    func cell(forSection section: Section, item: Item) -> UICollectionViewCell? {
        
        if let indexPath = self.diffCalculator?.indexPath(forSection: section, value: item) {
            
            return self.collectionView?.cellForItem(at: indexPath)
        }
        
        return nil
    }
    
}
