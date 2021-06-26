//
//  Coordinator.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import UIKit
import Foundation

/// The coordinator pattern is a structural design pattern for organizing flow logic between view controllers
/// Use this pattern to decouple view controllers from one another. The only component that knows about view controllers directly is the coordinator.
protocol Coordinator : AnyObject {
    
    var parentCoordinator : Coordinator? {get set}
    var childCoordinators : [Coordinator] {get set}
    var navigationController: UINavigationController {get set}

    func start(model : Any?)
    func childDidFinish(child : Coordinator?)
}

extension Coordinator {
    func popViewController(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
        if let parent = parentCoordinator {
            parent.childDidFinish(child: self)
        }
    }
}
