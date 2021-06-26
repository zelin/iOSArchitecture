//
//  DetailsController.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import UIKit
import SDWebImage
import Foundation
import MBProgressHUD

class DetailsController: BaseController, StoryboardInitializable {
    
    static func storyboardName() -> String {
        return "Details"
    }
    
    var coordinator : DetailsCoordinator!
    var viewModel : DetailsViewModel!{
        didSet {
        }
    }

    @IBOutlet private weak var imagesColView : UICollectionView!

    @IBOutlet private weak var storeBgImg     : UIImageView!
    @IBOutlet private weak var storeLogoImg   : UIImageView!

    @IBOutlet private weak var nameLbl     : UILabel!
    @IBOutlet private weak var detailLbl   : UILabel!
    @IBOutlet private weak var ratingLbl   : UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.observeQuery()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.storeLogoImg.layer.cornerRadius = self.storeLogoImg.frame.size.width/2
        self.storeLogoImg.layer.borderWidth = 2
        self.storeLogoImg.layer.borderColor = UIColor.white.cgColor
        
        self.imagesColView.delegate = self
        self.imagesColView.dataSource = self
    
        viewModel.didChangeData = { [weak self] data in

            guard let store = data else { return }
            guard let strongSelf = self else { return }
            
            strongSelf.updateData(store: store)
        }
        
        viewModel.updateState = { [weak self ] state in
        
            guard let strongSelf = self else { return }

            if state == .loading {
                MBProgressHUD.showAdded(to: strongSelf.view, animated: true)
            }else if state == .idle {
                MBProgressHUD.hide(for: strongSelf.view, animated: true)
            }
        }
    }
    
    func updateData(store: StoreModel)
    {
        self.nameLbl.text = store.name
        self.detailLbl.text = store.details
        
        if let logo = store.logoUrl{
            self.storeLogoImg.sd_setImage(with: URL.init(string: logo), completed: nil)
        }

        if let bgUrl = store.bgImageUrl{
            self.storeBgImg.sd_setImage(with: URL.init(string: bgUrl), completed: nil)
        }
        
        if let rating = store.rating {
            self.ratingLbl.text = String.init(format: "%.1f", rating)
        }else{
            self.ratingLbl.text = "0.0"
        }
        
        self.imagesColView.reloadData()
        
    }
    
    // MARK:- IBActions
    @IBAction func backBtnPressed(_btn: UIButton) {
        coordinator?.popViewController()
    }
    
    @IBAction func openStoreBtnPressed(_btn: UIButton) {
        
        guard let webUrl = self.viewModel.store.webUrl else {
            return
        }
        
        let url = URL(string:webUrl)!
        if UIApplication.shared.canOpenURL(url){            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

//MARK:- UICollectionViewDelegate
extension DetailsController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension DetailsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.view.frame.size.width * 0.42,
                           height: collectionView.frame.size.height
        )
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12)
    }
}

//MARK:- UICollectionViewDelegate
extension DetailsController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = HighlightCell.dequeue(collectionView: collectionView, indexPath: indexPath)
        cell.setup(url: self.viewModel.store.imagesList![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.store.imagesList?.count ?? 0
    }
}
