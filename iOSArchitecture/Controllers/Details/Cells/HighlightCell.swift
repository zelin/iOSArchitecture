//
//  StoreCell.swift
//  Linko
//
//  Created by Muhammad Umar on 04/03/2021.
//

import Foundation
import UIKit
import SDWebImage
import SkeletonView

class HighlightCell: UICollectionViewCell, DequeueInitializable {
    
    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var mainView : WGView!
    
    func setup(url: String?) {

        guard let mainUrl = url else {
            return
        }
        
        imgView.isSkeletonable = true
        imgView.showSkeleton()
        
        mainView.clipsToBounds = true
        mainView.cornerRadius = 10
        imgView.contentMode = .scaleAspectFill
        
        imgView.sd_setImage(with: URL.init(string: mainUrl)!) { _, _, _, _ in
            self.imgView.hideSkeleton()
        }
    }
}
