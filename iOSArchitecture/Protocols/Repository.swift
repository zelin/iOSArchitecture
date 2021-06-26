//
//  UserRepository.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum RepositoryError: Error {
    case noRecord
    case failure
}

/// Repositories are beneficial because they are implementation-independent contracts for accessing your backend . a repository can be implemented with a local database or as a web service, but the protocol for the repository doesn’t change. so if you switch backends, Best use case is to have local access and backend access is required
protocol Repository {
    
    associatedtype T
    
    func delete(_ item: T, completionHandler: (Error?) -> Void)
    func add(_ item: T, completionHandler: @escaping (Error?) -> Void)
    func edit(key: String, dict: [String: Any], completionHandler: @escaping (Error?) -> Void)
    func list(ref: Query, completionHandler: @escaping ([T]?, Error?) -> Void) -> ListenerRegistration?
    func get(ref: DocumentReference, completionHandler: @escaping (T?, Error?) -> Void) -> ListenerRegistration?
}
