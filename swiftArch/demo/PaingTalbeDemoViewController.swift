//
//  PaingTalbeDemoViewController.swift
//  swiftArch
//
//  Created by czq on 2018/5/16.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class PaingTalbeDemoViewController: PagingViewController {

    var remoteService:RemoteService=DataManager.shareInstance.remoteService
    
    private var datasource=Array<NSObject>()
    private var pagingList=Array<GameModel>()
 
   //可以不需要重写该方法
    override func initView() {
        super.initView() 
    }
     
    override func initTableView() {
        super.initTableView()
        self.tableView?.estimatedRowHeight = 80//这个值不影响行高 最好接近你想要的值
        self.tableView?.rowHeight=UITableViewAutomaticDimension
        self.tableView?.estimatedSectionHeaderHeight = 40 
    }
    
    //如果使用默认的列表Stateview可以不需要重写该方法(用于自定义 empty error loadingview)
    //也可再次自定义 上下拉的 head 和foot
    override func setTalbeStateView() {
        let emptyView=UserStyleTableEmptyView()
        emptyView.button.onTap {    //我的tableview已经在empty和error上加入了点击会触发下beginRefresh
                                    //但是你依然可以在emptyView上添加你想要的View比如按钮, 点击之后的事件 和我的点击重新加载不冲突
            self.view.makeToast("去添加")
        }
        self.tableView?.setEmptyiew(view: emptyView)
    }
    override func registerCellModel() {
        self.tableView?.registerCellNib(nib: R.nib.gameCell(), modelClass: GameModel.self)
    }
    override func registerSectionHeaderModel() {
        self.tableView?.registerHeaderClass(headerClass: GameDateHeader.self, modelClass: GameDateModel.self)
    }
    
    //自定义分页策略 需要用户去写
    override func getPagingStrategy() -> PagingStrategy {
        let strategy:PagingStrategy=NormalPagingStrategy(startPageNum: 0, pageSize: 20)
        return strategy
    }
    override func onLoadData(pagingStrategy: PagingStrategy) {
         
        let strategy:NormalPagingStrategy=pagingStrategy as! NormalPagingStrategy;
        let pageInfo:NormalPageInfo=strategy.getPageInfo() as! NormalPageInfo
        self.remoteService.getGame(pageNum: pageInfo.pageNum, pageSize: pageInfo.pageSize, success: { (gameListModel) in
            if(pageInfo.isFirstPage()){
                self.pagingList=(gameListModel?.listData)!
                self.datasource=(gameListModel?.listData)!
                
                self.datasource.insert(GameDateModel(date:"2011-11-11"), at: 0)
            }else{
                self.pagingList+=(gameListModel?.listData)!
                
                
                self.datasource.append(GameDateModel(date:"2011-11-\(Int(arc4random()%30)+1)"))
                self.datasource.append(contentsOf: (gameListModel?.listData)!) 
            }
            //调用者必须维护两个列表
            //1.和分页相关的列表
            //2.总数据源的列表
            self.loadSuccess(resultData: gameListModel!, dataSource: self.datasource, pagingList: self.pagingList)
            
        }) { (code, msg) in
            self.loadFail()
        }
        
    }

    
    
}
