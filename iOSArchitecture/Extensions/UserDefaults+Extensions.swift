//
//  UserDefaults+Extensions.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import Foundation
import FirebaseFirestore
import CodableFirebase
import FirebaseAuth

extension UserDefaults {

    enum Keys {
        static let userData     = "userData"
        static let isLoggedIn   = "isLoggedIn"
    }

    /// Static will act as final class var
    class var isUserLoggedIn: Bool {
        return UserDefaults.standard.bool(forKey: Keys.isLoggedIn)
    }

    class func saveBoolForKey(value: Bool, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func saveStringForKey(value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
}
