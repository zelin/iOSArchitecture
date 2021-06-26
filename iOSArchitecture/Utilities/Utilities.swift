//
//  Utilities.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import UIKit
import CommonCrypto
import CoreLocation
import AVFoundation

class Utilities: NSObject {

    public static func showErrorAlert(errorMessage: String, coordinator: Coordinator, shouldFinish: Bool) {
        
        let alert = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            
            if shouldFinish {
                coordinator.popViewController(animated: true)
            }
            
        }))
        coordinator.navigationController.present(alert, animated: true, completion: nil)
    }
    
    public static func showAlert(title: String, errorMessage: String, withView viewCtrl:UIViewController) {
        
        let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            
        }))
        viewCtrl.present(alert, animated: true, completion: nil)
    }    
}
