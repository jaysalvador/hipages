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
    
    @IBOutlet
    private var openJobsView: UIView?
    
    @IBOutlet
    private var closedJobsView: UIView?
    
    @IBOutlet
    private var openJobsButton: UIButton?
    
    @IBOutlet
    private var closedJobsButton: UIButton?
    
    
    override var sectionsAndItems: Array<SectionAndItems> {
        
        var items = [TestItem]()
        
        let jobStatus = self.viewModel?.jobView
        
        self.viewModel?.jobs?.forEach { job in
            
            if jobStatus == job.status {
                            
                items.append(.title(job))
//                items.append(.avatars(job))
//                items.append(.details(job))
            }
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
        
        self.setupViewModel()
        
        self.setupNotifications()
    }
    
    // MARK: - Setup
    
    private func setupViewModel() {
        
        self.viewModel?.onUpdated = { [weak self] in
            
            DispatchQueue.main.async {

                self?.updateSectionsAndItems()
            }
        }
    }
    
    private func setupNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func setupCollectionView() {
        
        super.setupCollectionView()
        
        self.collectionView?.register(cell: JobTitleCell.self)
    }
    
    private func setupButtonBorders() {
        
        self.openJobsView?.setBottomBorder(color: .white, width: 2.0)
        
        self.closedJobsView?.setBottomBorder(color: .white, width: 2.0)
        
        if self.viewModel?.jobView == .inProgress {
            
            self.openJobsView?.setBottomBorder(color: .orange, width: 2.0)
        }
        else {
            
            self.closedJobsView?.setBottomBorder(color: .orange, width: 2.0)
        }
    }
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.toggleJobs(self.viewModel?.jobView == .inProgress ? self.openJobsButton : self.closedJobsButton)
        
        self.viewModel?.getJobs()
    }
    
    // MARK: - UICollectionViewDataSource & UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, cellForSection section: TestSection, item: TestItem, indexPath: IndexPath) -> UICollectionViewCell? {
        
        if case .title(let job) = item {
            
            if let cell = self.collectionView?.dequeueReusable(cell: JobTitleCell.self, for: indexPath) {
                
                return cell.prepare(job: job)
            }
        }
        
        return nil
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForSection section: TestSection, item: TestItem, indexPath: IndexPath) -> CGSize? {
        
        return CGSize(width: collectionView.frame.width, height: 112.0)
    }
    
    // MARK: - Actions
    
    @objc
    func orientationChanged() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(175)) { [weak self] in

            self?.setupButtonBorders()
            
            self?.updateSectionsAndItems(forced: true)
        }
    }
    
    @IBAction func toggleJobs(_ sender: UIButton?) {
        
        self.viewModel?.jobView = (sender == self.openJobsButton) ? .inProgress : .closed

        self.setupButtonBorders()
        
        // update jobs listing
        
        self.updateSectionsAndItems()
    }
}
