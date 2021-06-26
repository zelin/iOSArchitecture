//
//  UserModel.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import Foundation
import UIKit

/// Codable responds to both Encodable & Decodable
struct UserModel: Codable {
    
    var key         : String?
    var name        : String?
    var phone       : String?
    var details     : String?
    var imageUrl    : String?
    var deviceType  : String?
    var deviceToken : String?
    var deviceModel : String?

    var status : Bool?
    var rating : Float?

    /// Getter for bookmarks is public, but the setter is private
    public private(set) var bookmarks : [String]?

    ///classes are reference type whereas structures and enumerations are value types. The properties of value types cannot be modified within its instance methods by default. In order to modify the properties of a value type, you have to use the mutating keyword in the instance method
    mutating func updateValues() {
        self.deviceType  = "iOS"
        self.deviceModel = UIDevice.current.systemVersion + " " + UIDevice.current.systemName
    }
    
    mutating func addBookmark(key: String) {
        
        if (bookmarks == nil) {
            self.bookmarks = []
        }
        
        self.bookmarks!.append(key)
    }
    
    mutating func removeBookmark(index: Int) {
        self.bookmarks!.remove(at: index)
    }
}
