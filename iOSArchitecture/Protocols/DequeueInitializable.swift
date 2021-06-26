//
//  StoryboardInitializable.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import Foundation
import UIKit

/// Protocol to assign UICollectionViewCell + UITableViewCell resueable identifiers as Class Names
protocol DequeueInitializable {
    static var reuseableIdentifier: String { get }
    static var nib: UINib { get }
}

//MARK:- UITableViewCell
extension DequeueInitializable where Self: UITableViewCell {
    
    static var reuseableIdentifier: String {
        return String(describing: Self.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: reuseableIdentifier, bundle: nil)
    }
    
    static func dequeue(tableView: UITableView) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseableIdentifier) else {
            return UITableViewCell() as! Self
        }
        return cell as! Self
    }
    
    static func register(tableView: UITableView){
        tableView.register(self.nib, forCellReuseIdentifier: self.reuseableIdentifier)
    }
}

//MARK:- UICollectionViewCell
extension DequeueInitializable where Self: UICollectionViewCell {
    
    static var reuseableIdentifier: String {
        return String(describing: Self.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: reuseableIdentifier, bundle: nil)
    }
    
    static func dequeue(collectionView: UICollectionView,indexPath: IndexPath) -> Self {
        
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseableIdentifier, for: indexPath)
        
        return cell as! Self
    }
    
    static func register(collectionView: UICollectionView) {
        collectionView.register(self.nib, forCellWithReuseIdentifier: self.reuseableIdentifier)
     }
}
