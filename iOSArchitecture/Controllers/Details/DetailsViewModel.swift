//
//  DetailsViewModel.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import Resolver
import Foundation
import FirebaseFirestore

class DetailsViewModel: BaseViewModel {
    
    @Injected
    fileprivate var storeRepo   : StoreRepository
    
    var store : StoreModel = StoreModel.init()
    var didChangeData: ((StoreModel?) -> Void)?
    
    fileprivate var storeRef: DocumentReference?
    fileprivate var storeListener : ListenerRegistration?
        
    required init(store : StoreModel) {
        self.store = store
    }

    func observeQuery() {
       
        guard let key = self.store.key else {
            return
        }
        
        self.storeRef = self.mainDB.collection(Datasets.store).document(key)
        guard let query = storeRef else { return }
        
        self.storeListener?.remove()
        self.storeListener = storeRepo.get(ref: query, completionHandler: { (store, _) in
            if let storeData = store {
                self.store = storeData
                self.didChangeData?(self.store)
            }
        })
        
        self.didChangeData?(self.store)
    }

    func stopObserving() {
        storeListener?.remove()
    }
    
    deinit {
        stopObserving()
    }
}
