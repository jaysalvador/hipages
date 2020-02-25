//
//  TestViewModel.swift
//  HiPages
//
//  Created by Jay Salvador on 25/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

typealias ViewModelCallback = (() -> Void)

protocol TestViewModelProtocol{
    
    // MARK: - Data
    
    var jobs: [Job]? { get }
    
    // MARK: - Callbacks
    
    var onUpdated: ViewModelCallback? { get set }
    
    var onError: ViewModelCallback? { get set }
    
    // MARK: - Functions
    
    func getJobs()
}

class TestViewModel: TestViewModelProtocol {
    
    // MARK: - Dependencies
    
    private var jobClient: JobClientProtocol?
    
    // MARK: - Data
    
    private(set) var jobs: [Job]?
    
    // MARK: - Callbacks
    
    var onUpdated: ViewModelCallback?
    
    var onError: ViewModelCallback?
    
    // MARK: - Init
    
    convenience init() {
        
        self.init(jobClient: JobClient())
    }
    
    init(jobClient _jobClient: JobClientProtocol?) {
        
        self.jobClient = _jobClient
    }
    
    // MARK: - Functions
    
    func getJobs() {
        
        self.jobClient?.getJobs { [weak self] (response) in
        
            switch response {
                
            case .success(let result):
                
                self?.jobs = result.jobs
                
                self?.onUpdated?()
                
            case .failure:
             
                self?.onError?()
            }
        }
    }
}
