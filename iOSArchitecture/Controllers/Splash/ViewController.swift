//
//  ViewController.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import UIKit
import Resolver

/// Initial view controller class
class ViewController: UIViewController {

    @Injected
    fileprivate var service   : Service

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Incase any changes happen to Logged In User Model. This should be called once ideally once a user is logged in
        self.service.observeUser { (user, error) -> Void in
        }
        
        /// Lets put some more delay on splash
        /// Async will start it asap, sync will wait for all deadlocks to finish
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

            /// We are using coordinator pattern + MVVM pattern
            /// ViewModel can be initialized by domain specific arguments
            let coordinator = StoresCoordinator.init(nav: self.navigationController!)
            coordinator.start(model: StoresViewModel.init())
        }
    }
}

