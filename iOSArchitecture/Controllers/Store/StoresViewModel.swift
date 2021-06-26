//
//  StoreViewModel.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import Resolver
import Foundation
import FirebaseFirestore

class StoresViewModel: BaseViewModel {
    
    @Injected
    fileprivate var storeRepo   : StoreRepository
    
    var didChangeData: (([StoreModel], Error?) -> Void)?
    
    /// The private is accessible only within the scope of the class -- fileprivate will make them accessible in extensions too but needs to be in same file
    /// We might need to update these values in possible extensions
    fileprivate var storeRef: Query?
    fileprivate var storeListener : ListenerRegistration?

    var storesList : [StoreModel] = [] {
        didSet {
            didChangeData?(storesList, nil)
        }
    }
    
    override init() {
        super.init()
    }
    
    func startObserving() {
        
        /// Incase any changes happen to Logged In User Model. Unlike observe, this should be placed wherever
        self.service.didChangeData = { [weak self] _ in
            guard let strongSelf = self else { return }
            /// Use-case to pass values to view controllers that display user properties e.g ProfileController
            strongSelf.didChangeData?(strongSelf.storesList, nil)
        }

        self.observeStoresQuery()
    }
    
    func observeStoresQuery() {
           
        self.setState(state: .loading)
        self.storeRef = self.mainDB.collection(Datasets.store).whereField("status", isEqualTo: true).limit(to: 20)

        guard let query = storeRef else { return }
        
        self.storeListener?.remove()
        
        /// We are using Repository Pattern to fetch data from API or any other Network calls
        self.storeListener = storeRepo.list(ref: query, completionHandler: { [self] (list, error) in
            
            guard let items = list else {
                return
            }
                        
            self.storesList = items
            self.setState(state: .idle)
            didChangeData?(self.storesList, error)
        })
    }

    func stopObserving() {
        storeListener?.remove()
    }
    
    deinit {
        stopObserving()
    }
}
