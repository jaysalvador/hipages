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
    
    var jobView: JobStatus { get set }
    
    var jobs: [Job]? { get }
    
    // MARK: - Callbacks
    
    var onUpdated: ViewModelCallback? { get set }
    
    var onError: ViewModelCallback? { get set }
    
    // MARK: - Functions
    
    func getJobs()
    
    func closeJob(job: Job)
}

class TestViewModel: TestViewModelProtocol {
    
    // MARK: - Dependencies
    
    private var jobClient: JobClientProtocol?
    
    // MARK: - Data
    
    var jobView: JobStatus = .inProgress
    
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
    
    func closeJob(job: Job) {
        
        guard let index = self.jobs?.firstIndex(of: job) else {
            
            return
        }
        
        var _job = job
        
        _job.status = .closed
        
        self.jobs?[index] = _job
    }
}
