//
//  StoreController.swift
//  iOSArchitecture
//
//  Created by Muhammad Umar on 20/06/2021.
//  Copyright © 2021 Muhammad Umar. All rights reserved.
//

import UIKit
import MBProgressHUD
import Foundation
import SkeletonView

class StoresController: BaseController, StoryboardInitializable
{
    /// StoryboardInitializable protocol will search the view controller with identifier same as class name in storyboard name defined in the function.
    static func storyboardName() -> String {
        return "Stores"
    }
    
    /// Both Coordinator and view models are initialized by MVVM+Coordinator pattern
    var coordinator : StoresCoordinator!
    var viewModel : StoresViewModel!
    
    /// If there is no code path that re-adds the outlet to the view hierarchy, it would also be good to make it weak to not hold on to it unnecessarily when it gets removed:
    @IBOutlet weak var storesTableView : UITableView!
    @IBOutlet weak var noRecordImg   : UIImageView!

    // MARK:- LifeCycle Functions    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        /// For loading
        self.noRecordImg.isHidden = false
        self.storesTableView.isUserInteractionEnabled = false

        /// Adding delegate functions to table view
        self.storesTableView.delegate = self
        self.storesTableView.dataSource = self
        
        /// Any updates to listeners will be reflected here. In current controller we want to display stores list. Any change in stores list will call this function
        viewModel.didChangeData = { [weak self] stores, error  in
                    
            guard let strongSelf = self else { return }
            
            if let error = error {
                /// Utility class for displaying errors and other helper functions
                Utilities.showErrorAlert(errorMessage: error.localizedDescription, coordinator: strongSelf.coordinator!, shouldFinish: false)
                return
            }
            
            /// Incase no stores we will display no records found image
            if stores.count > 0 {
                strongSelf.storesTableView.isHidden = false
                strongSelf.noRecordImg.isHidden = true
            }else{
                strongSelf.storesTableView.isHidden = true
                strongSelf.noRecordImg.isHidden = false
            }

            strongSelf.storesTableView.reloadData()
        }
        
        /// Ideally used in sync with API calls. Each api call update the state to .loading state and response call will update the state to .idle
        viewModel.updateState = { [weak self ] state in
        
            guard let strongSelf = self else { return }

            if state == .loading {
                MBProgressHUD.showAdded(to: strongSelf.view, animated: true)
            }else if state == .idle {
                MBProgressHUD.hide(for: strongSelf.view, animated: true)
                strongSelf.storesTableView.isUserInteractionEnabled = true
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.startObserving()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        /// Incase we call startObserving in viewDidLoad, we don't need to call it as deinit is already in place in viewModel
        self.viewModel.stopObserving()
    }
}

// MARK:- UITableViewDataSource
extension StoresController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// 4 Sekeleton views while the stores data is being loaded
        return self.viewModel.state == .loading ? 4 : self.viewModel.storesList.count
    }
                
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = StoreCell.dequeue(tableView: tableView)
        /// We are showing a skeleton view only if state is loading
        if self.viewModel.state == .loading {
            cell.update()
        } else {
            let store = self.viewModel.storesList[indexPath.row]
            cell.update(store: store)
        }
        
        return cell
    }
}

//MARK:- UITableViewDelegate
extension StoresController: UITableViewDelegate {
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.openStore(store: self.viewModel.storesList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
