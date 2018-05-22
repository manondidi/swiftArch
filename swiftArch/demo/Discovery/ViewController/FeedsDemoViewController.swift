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

        self.remoteService.getFeedsMock { (result: Array<SPFeedVM>) in
            print("")
            
            if(pageInfo.isFirstPage()){
                self.datasource=result
            
            }else{
                self.datasource = self.datasource + result
            }
            // 调用者必须维护两个列表
            // 1.和分页相关的列表
            // 2.总数据源的列表
            self.loadSuccess(resultData: result as NSObject, dataSource: self.datasource, pagingList: self.datasource)
        }
    }
     
    
    override func tableView(_ cell: UITableViewCell, heightForModel model: NSObject)->CGFloat {
        let realItem = model as! SPFeedVM
        return realItem.cellHeight
    }
}
