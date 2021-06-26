//
//  Service.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import Resolver
import Foundation
import FirebaseAuth
import CodableFirebase
import FirebaseFirestore

enum Datasets {
    static let user = "users"
    static let store = "stores"
}
/// Base network class to listen for logged in user updates
class Service {
        
    public private(set) var user: UserModel?
    fileprivate var listener: ListenerRegistration?

    var didChangeData: ((UserModel?) -> Void)?

    init() {
    }
    
    /// This should be called once you are logged in via Firebase authentication
    /// Optional are escaping by default
    func observeUser(completionHandler: @escaping (UserModel?, Error?) -> Void) {
     
        if listener != nil {
            listener?.remove()
        }
        
        let mainDB = Firestore.firestore()
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        self.listener = mainDB.collection(Datasets.user).document(currentUser.uid).addSnapshotListener { [self] (snapshot, error) in
            
            if error != nil {
                return
            }
            
            guard let snapshot = snapshot, let data = snapshot.data() else {
                
                self.user = UserModel.init()
                self.user!.phone = currentUser.phoneNumber
                self.user!.name = currentUser.displayName
                self.user!.key = currentUser.uid
             
                didChangeData?(self.user)
                completionHandler(user, nil)
                
                return
            }
            
            do {
                self.user = try FirebaseDecoder().decode(UserModel.self, from: data as Any)
                self.user!.key = currentUser.uid
                didChangeData?(self.user)
                
                completionHandler(user, nil)
            } catch let error {
                completionHandler(nil, error)
            }
        }
    }
}
