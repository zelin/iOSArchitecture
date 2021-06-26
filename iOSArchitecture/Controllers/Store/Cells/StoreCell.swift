//
//  StoreCell.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import UIKit
import SDWebImage
import Foundation

/// DequeueInitializable is being used to assign resulable Identifier same as Class Name
class StoreCell : UITableViewCell, DequeueInitializable {
    
    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var percentLbl: WGLabel!

    @IBOutlet private weak var storeImg: UIImageView!
    @IBOutlet private weak var logoImg : UIImageView!
    
    private var store : StoreModel!

    func update() {
        self.isSkeletonable = true
        self.showAnimatedGradientSkeleton()
    }
    
    func update(store: StoreModel){
                
        self.store = store
        self.selectionStyle = .none
        
        self.update()

        nameLbl.textColor = .white
        nameLbl.text = store.name
        
        if let imgUrl = store.logoUrl {
            logoImg.sd_setImage(with: URL.init(string: imgUrl), completed: nil)
        } else {
            logoImg.image = nil
        }
        
        if let bgImageUrl = store.bgImageUrl {
            storeImg.sd_setImage(with: URL.init(string: bgImageUrl)) { image, error, cache, url in
                self.hideSkeleton()
            }
        } else {
            self.hideSkeleton()
            storeImg.image = nil
        }
        
        storeImg.contentMode = .scaleAspectFill
        storeImg.layer.cornerRadius = 10
        storeImg.clipsToBounds = true
                
        logoImg.contentMode = .scaleAspectFill
        logoImg.layer.cornerRadius = logoImg.frame.size.width/2
        logoImg.layer.borderWidth = 1
        logoImg.layer.borderColor = UIColor.white.cgColor
        logoImg.clipsToBounds = true
        logoImg.isUserInteractionEnabled = true
        
        percentLbl.isHidden = true
        percentLbl.text = String.init(format: "%%%d OFF", store.deal ?? 0)
    }
}
