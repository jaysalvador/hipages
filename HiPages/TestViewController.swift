//
//  TestViewController.swift
//  HiPages
//
//  Created by Jay Salvador on 22/2/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let jobs: JobClientProtocol? = JobClient()
        
        jobs?.getJobs { (response) in
            
            switch response {
                
            case .success(let response):
                
                print(response.jobs?.count ?? 0)
                
            case .failure(let error):
             
                print(error.errorDescription ?? "")
            }
        }
    }
}
