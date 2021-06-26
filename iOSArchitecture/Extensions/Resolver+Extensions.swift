//
//  Resolver+Extensions.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import Foundation
import Resolver

/// Injection Pattern
extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { Service() }.scope(.shared)
        register { StoreRepository() }.scope(.shared)
    }
}
