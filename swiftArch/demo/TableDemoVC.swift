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
        self.tableView.setLoadMoreCallback  {
            [weak self] in
                if let strongSelf = self{
                    strongSelf.tableView.endLoadMore()
            }
            
        }
        self.tableView.setRefreshCallback {
            [weak self] in
            if let strongSelf = self{ 
                strongSelf.tableView.endRefresh()
            }
            
        }
    }
 
    deinit {
        print("TableDemoVC deinit")
    }

}
