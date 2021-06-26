//
//  StoreRepository.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import Resolver
import Foundation
import CodableFirebase
import FirebaseFirestore

// Store Repostitory struc to fetch and update store models
struct StoreRepository: Repository {
    
    typealias T = StoreModel

    /// Escaping will be used if we want handler to outlives the function life
    func get(ref: DocumentReference, completionHandler: @escaping (StoreModel?, Error?) -> Void) -> ListenerRegistration? {
        
        let listener = ref.addSnapshotListener { (snapshot, error) in
            
            if error != nil {
                completionHandler(nil, error)
            }
            
            guard let snapshot = snapshot else {
                completionHandler(nil, error)
                return
            }
            
            do {
                /// Codeable firebase is easier to use, make sure to add optional to variables in structure if a key is not present in firestore DB
                let item = try FirebaseDecoder().decode(StoreModel.self, from: snapshot.data() as Any)
                completionHandler(item, nil)
            } catch let error {
                print(error)
                completionHandler(nil, error)
            }
        }
        
        return listener
    }
    
    func add(_ item: StoreModel, completionHandler: @escaping (Error?) -> Void) {
    }
    
    func edit(key: String, dict: [String: Any], completionHandler: @escaping (Error?) -> Void) {
        
        let mainDB = Firestore.firestore()
        let batch = mainDB.batch()

        let ref = mainDB.collection(Datasets.store)

        batch.setData(dict, forDocument: ref.document(key),
        merge: true)

        batch.commit() { err in
            completionHandler(err)
        }
    }
    
    func delete(_ item: StoreModel, completionHandler: (Error?) -> Void) {
    }
    
    func list(ref: Query, completionHandler: @escaping ([StoreModel]?, Error?) -> Void) -> ListenerRegistration? {
        
        let listener = ref.addSnapshotListener { (snapshot, error) in
            
            if error != nil {
                completionHandler([], error)
            }
            
            guard let snapshot = snapshot else {
                completionHandler([], error)
                return
            }

            let models = snapshot.documents.compactMap { (document) -> StoreModel? in
                
                do {
                    let item = try FirebaseDecoder().decode(StoreModel.self, from: document.data())
                    return item
                } catch let error {
                    print(error)
                    return nil
                }
            }

            completionHandler(models, nil)
        }
            
        return listener
    }
}
