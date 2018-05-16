//
//  DemoViewController.swift
//  swiftArch
//
//  Created by czq on 2018/5/14.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class DemoViewController: BaseViewController {

    
    var remoteService:RemoteService=DataManager.shareInstance.remoteService
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData(userId: "manondidi", password: "12345566")
       
    }
    
    override func onReload() {
        self.showLoading() 
        self.loadData(userId: "manondidi", password: "123")
        
    }
    ///在此处定制各种 stateView
    override func setStateManagerView(sateManager: PageSateManager) { 
        sateManager.setLoadView(view: R.nib.userStyleLoadView.firstView(owner: nil)!)
    }
    func loadData(userId:String,password:String){
        self.showLoading()
        remoteService.getUser(userId: userId, password: password, success: { (user) in
            self.showContent()
            self.view.makeToast("success")
        }) { (code, msg) in
            self.showError()
            self.view.makeToast(msg)
        }
    }
 

}
