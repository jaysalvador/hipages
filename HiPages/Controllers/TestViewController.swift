//
//  TestViewController.swift
//  HiPages
//
//  Created by Jay Salvador on 22/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

enum TestSection: Equatable {
    
    case single
}

enum TestItem: Equatable {
    
    case title(Job)
    case avatars(Job)
    case details(Job)
    
    static func == (lhs: TestItem, rhs: TestItem) -> Bool {
        
        switch (lhs, rhs) {
            
        case (.title(let lhsJob), .title(let rhsJob)):
            
            return lhsJob == rhsJob
        
        case (.avatars(let lhsJob), .avatars(let rhsJob)):
        
            return lhsJob == rhsJob && lhsJob.connectedBusinesses == rhsJob.connectedBusinesses
        
        case (.details(let lhsJob), .details(let rhsJob)):
            
            return lhsJob == rhsJob && lhsJob.detailsLink == rhsJob.detailsLink
            
        default:
            
            return false
        }
    }
}

class TestViewController: JCollectionViewController<TestSection, TestItem> {
    
    // MARK: - View model
    
    private var viewModel: TestViewModelProtocol?
    
    // MARK: - Sections and items
    
    override var sectionsAndItems: Array<SectionAndItems> {
        
        var items = Array<TestItem>()
        
        self.viewModel?.jobs?.forEach { job in
            
            items.append(.title(job))
            items.append(.avatars(job))
            items.append(.details(job))
        }
        
        return [(.single, items)]
    }
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError()
    }
    
    convenience override init() {
        
        self.init(viewModel: TestViewModel())
    }
    
    init(viewModel _viewModel: TestViewModelProtocol?) {
        
        super.init()
        
        self.viewModel = _viewModel
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.viewModel?.getJobs()
    }
}
