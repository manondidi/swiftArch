//
//  TableDemoVC.swift
//  swiftArch
//
//  Created by czq on 2018/5/9.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class TableDemoVC: UIViewController { 
    
    @IBOutlet weak var tableView: StateTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableView.setUpState()
        self.tableView.setLoadMoreCallback {
            self.tableView.endLoadMore()
        }
        self.tableView.setRefreshCallback {
            self.tableView.endRefresh()
        }
    }
 

}
