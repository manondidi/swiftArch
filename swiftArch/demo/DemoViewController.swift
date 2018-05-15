//
//  DemoViewController.swift
//  swiftArch
//
//  Created by czq on 2018/5/14.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class DemoViewController: BaseViewController {

  
    override func initView() {
        super.initView()
        self.showError()
        
    }
    
    override func onReload() {
        self.view.makeToast("onReload")
        self.showLoading()
        
    }
    override func setStateManagerView(sateManager: PageSateManager) { 
        sateManager.setLoadView(view: R.nib.userStyleLoadView.firstView(owner: nil)!)
    }
 

}
