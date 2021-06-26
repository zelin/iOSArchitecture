//
//  BaseViewModel.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import Foundation
import Resolver
import FirebaseFirestore

enum State {
    case idle
    case loading
}

class BaseViewModel {
    
    @Injected var service : Service
    var state : State = .idle
    
    var mainDB = Firestore.firestore()
    var updateState: ((State) -> Void)?
    
    func setState(state: State) {
        self.state = state
        self.updateState?(self.state)
    }
}
