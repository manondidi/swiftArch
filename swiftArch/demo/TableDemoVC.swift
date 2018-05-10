//
//  TableDemoVC.swift
//  swiftArch
//
//  Created by czq on 2018/5/9.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class TableDemoVC: UIViewController {

    //     var remoteService:RemoteService=DataManager.shareInstance.remoteService
    
//    let tableView=StateTableView()
    
    @IBOutlet weak var tableView: StateTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //        remoteService.getUser(userId: "manondidi", password: "123", success: { (user) in
        //          print("success")
        //        }, failure: { (statusCode, msg) in
        //            print("failure")
        //        })
        
        
//        self.view.addSubview(tableView)
//        self.tableView.snp.makeConstraints { (make) in
//            make.left.right.top.bottom.equalToSuperview()
//        }
        self.tableView.setUpState()
        self.tableView.setLoadMoreCallback {
            self.tableView.endLoadMore()
        }
        self.tableView.setRefreshCallback {
            self.tableView.endRefresh()
        }
    }
 

}
