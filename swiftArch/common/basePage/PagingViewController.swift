//
//  PagingViewController.swift
//  swiftArch
//
//  Created by czq on 2018/5/14.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

//用于计算分页
class PagingViewController: BaseViewController {
 
    var tableView:StateTableView?
    
    override func initView() {
        super.initView()
        self.initTableView()
        self.setTalbeStateView()
        self.tableView?.setUpState()
        self.tableView?.tableFooterView=UIView()
        self.tableView?.setRefreshCallback {
            self.onTableRresh()
        }
        self.tableView?.setLoadMoreCallback {
             self.onTableLoadMore()
        }
    }
    
    
    /// 用于个性化定制整个页面的cover,用法:子类覆盖该方法
    /// example: sateManager.setLoadView(view: )
    /// - Parameter sateManager: 页面的管理器
    override func setStateManagerView(sateManager: PageSateManager) {}
 
    
    
    /// 子类必须重写该方法,当下拉刷新时回调
    func  onTableRresh() {}
    /// 子类必须重写该方法,当上拉加载时回调
    func onTableLoadMore(){}
    
    /// 子类单页面需要个性化定制tablevview的stateCover请重写
    ///如果采用默认的stateCover那就不需要重写
    ///example:self.tableView?.setLoadView(view: )
    func setTalbeStateView(){}
    
    
    /// 用于个性化提供tableView 用法:子类重写
    ///我的这个tableview是默认添加在self.view的
    /// 如果你的页面tableview有别的初始化方式 比方说nib
    ///或者 tableview不是添加在self.view
    ///或者大小位置需要自定义,你可以重写这个方法
    func initTableView(){//子类重写(如果有必要)
        self.tableView=StateTableView()
        self.view.addSubview(self.tableView!)
        self.tableView?.snp.makeConstraints({ (make) in
            make.width.height.equalToSuperview()
        })
    }
    
    //以下用于tableview的cover展示代码
    func showTableLoading(){
        self.tableView?.showLoading()
    }
    func showTableContent(){
        self.tableView?.showContent()
    }
    func showTableError(){
        self.tableView?.showError()
    }
    func showTableEmpty(){
        self.tableView?.showEmpty()
    }
    
    
}
