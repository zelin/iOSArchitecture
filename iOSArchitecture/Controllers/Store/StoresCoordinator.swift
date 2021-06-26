//
//  StoreCoordinator.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import UIKit
import Foundation

class StoresCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(nav: UINavigationController) {
        self.navigationController = nav
    }
    
    /// Protocol function to start corresponding ViewController
    func start(model: Any?) {
        
        guard let viewModel = model as? StoresViewModel else {
            return
        }
        
        let ctrl = StoresController.initFromStoryboard()
        ctrl.coordinator = self
        ctrl.viewModel = viewModel
        self.navigationController.pushViewController(ctrl, animated: true)
    }

    func openStore(store: StoreModel) {
        /// We are starting our coordinator pattern from StoresController, making its coordinator as parent coordinator
        let coordinator = DetailsCoordinator.init(nav: self.navigationController)
        coordinator.parentCoordinator = self
        self.childCoordinators.append(coordinator)
        coordinator.start(model: DetailsViewModel.init(store: store))
    }
    
    /// Protocol function to remove children coordinators
    func childDidFinish(child: Coordinator?) {
        
        guard let child = child else {
            return
        }
        
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
            break            
        }
    }
}
