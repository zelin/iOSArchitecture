//
//  StoreModel.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import Foundation
import CodableFirebase

/// Codable responds to both Encodable & Decodable
struct StoreModel: Codable {
    
    var key         : String?
    var name        : String?
    var email       : String?
    var webUrl      : String?
    var phone       : String?
    var details     : String?
    var logoUrl     : String?
    var bgImageUrl  : String?
    
    var imagesList  : [String]?

    var deal : Int?
    var status : Bool?
    var rating : Float?
}
