//
//  PagingOffsetIdDemoViewController.swift
//  swiftArch
//
//  Created by czq on 2018/5/16.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class PagingOffsetIdDemoViewController: PagingViewController {

    var remoteService:RemoteService=DataManager.shareInstance.remoteService
    
    private var datasource=Array<NSObject>()
    private var pagingList=Array<NSObject>()
    
    //可以不需要重写该方法
    override func initView() {
        super.initView()
        self.title="真实的分页请求"
    }
    
    override func initTableView() {
        super.initTableView()
        self.tableView?.estimatedRowHeight = 80;//这个值不影响行高 最好接近你想要的值 
        self.tableView?.separatorStyle=UITableViewCellSeparatorStyle.none
       
    }
    
 
    override func registerCellModel() {
        self.tableView?.registerCellNib(nib: R.nib.feedArticleCell(), modelClass: FeedArtileModel.self)
    }
    
    //自定义分页策略 需要用户去写
    override func getPagingStrategy() -> PagingStrategy {
        let strategy:PagingStrategy=FeedPaingStrategy(pageSize: 20, offsetIdKey: "id")
        return strategy
    }
    override func onLoadData(pagingStrategy: PagingStrategy) {
        
        let strategy:FeedPaingStrategy=pagingStrategy as! FeedPaingStrategy;
        let pageInfo:FeedPageInfo=strategy.getPageInfo() as! FeedPageInfo
        
        self.remoteService.getFeedArticle(direction: pageInfo.type, pageSize: pageInfo.pageSize, offsetId: pageInfo.offsetId, success: {
            [weak self] (feedArticleList) in
            if let strongSelf=self{
                 if(pageInfo.isFirstPage()){
                    strongSelf.pagingList=feedArticleList!
                    strongSelf.datasource=feedArticleList!
                }else{
                    strongSelf.pagingList = strongSelf.pagingList + feedArticleList!
                    strongSelf.datasource = strongSelf.datasource + feedArticleList!
                }
                strongSelf.loadSuccess(resultData: feedArticleList! as NSObject, dataSource: strongSelf.datasource, pagingList: strongSelf.pagingList)
            }
        }) {[weak self] (code, msg) in
              self?.loadFail()
        }
        
        
    }
    
    
     

}
