//
//  StoryboardInitializable.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import Foundation
import UIKit

/// Protocol to assign Storyboard ViewControllers resueable identifiers as Class Names
protocol StoryboardInitializable {
    static var storyboardIdentifier: String { get }
    static func storyboardName() -> String
}

extension StoryboardInitializable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
    
    static func initFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: storyboardName(), bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self ?? Self.init()
    }
}
