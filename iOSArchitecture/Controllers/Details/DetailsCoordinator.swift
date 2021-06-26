//
//  DetailsCoordinator.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import UIKit
import Foundation

class DetailsCoordinator : Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?

    var navigationController: UINavigationController
    
    init(nav: UINavigationController) {
        self.navigationController = nav
        self.childCoordinators = []
    }
    
    func start(model: Any?) {
        
        guard let model = model as? DetailsViewModel else {
            return
        }
        
        let ctrl = DetailsController.initFromStoryboard()
        ctrl.viewModel = model
        ctrl.coordinator = self
        self.navigationController.pushViewController(ctrl, animated: true)
    }
    
    func childDidFinish(child: Coordinator?) {
    }
}
