//
//  DiscoveryDemoViewController.swift
//  swiftArch
//
//  Created by aron on 2018/5/20.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class FeedsDemoViewController: PagingViewController {

    private var remoteService:RemoteService=DataManager.shareInstance.remoteService
    private var datasource=Array<NSObject>()

    
    override func initTableView() {
        super.initTableView()
    }
    
    override func registerCellModel() {
        super.registerCellModel()
        self.tableView?.registerCellClass(cellClass: SPFeedCell.self, modelClass: SPFeedVM.self) 
    }
    
    override func getPagingStrategy() -> PagingStrategy {
        let strategy:PagingStrategy=FeedPaingStrategy(pageSize: 20, offsetIdKey: "id")
        return strategy
    }
    
    override func onLoadData(pagingStrategy: PagingStrategy) {

        let strategy:FeedPaingStrategy=pagingStrategy as! FeedPaingStrategy;
        let pageInfo:FeedPageInfo=strategy.getPageInfo() as! FeedPageInfo

        self.remoteService.getFeedsMock { [weak self] (result: Array<SPFeedVM>) in
//            print("")
            if let strongSelf=self{
            
                    if(pageInfo.isFirstPage()){
                        strongSelf.datasource=result
                    
                    }else{
                        strongSelf.datasource = strongSelf.datasource + result
                    }
                // 调用者必须维护两个列表
                // 1.和分页相关的列表
                // 2.总数据源的列表
                    strongSelf.loadSuccess(resultData: result as NSObject, dataSource: strongSelf.datasource, pagingList: strongSelf.datasource)
                }
         }
    }
     
    
    override  func tableView(_ tableView: UITableView,heightForModel model: NSObject)->CGFloat {
        let realItem = model as! SPFeedVM
        return realItem.cellHeight
    }
}
