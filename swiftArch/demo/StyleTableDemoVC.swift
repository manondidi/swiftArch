//
//  StyleTableDemoVC.swift
//  swiftArch
//
//  Created by czq on 2018/5/9.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import Closures
import Toast_Swift
import MJRefresh

class StyleTableDemoVC: UIViewController {

    let tableView=StateTableView()
    let emptyView=UserStyleTableEmptyView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        emptyView.button.onTap { //我的tableview已经在empty和error上加入了点击会触发下beginRefresh
                                //但是你依然可以在emptyView上添加你想要的View比如按钮, 点击之后的事件 和我的点击重新加载不冲突
            self.view.makeToast("去添加")
        }
        self.tableView.setEmptyiew(view:emptyView )//这里采用自定义的emptyview
        self.tableView.setRefreshHeader(refreshHeader: MJRefreshNormalHeader())//采用自定义的下拉刷新
        
        self.tableView.setUpState()
        self.tableView.setLoadMoreCallback {
            self.tableView.endLoadMore()
        }
        self.tableView.setRefreshCallback {
            self.tableView.showLoading()//页面没数据的时候要showloading比较友好
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.tableView.endRefresh()
                self.tableView.showContent()
            } 
        }
       
        self.tableView.showEmpty()
//        self.tableView.showLoading()
//        self.tableView.beginRefresh();
        
    }

   
    
 

}
