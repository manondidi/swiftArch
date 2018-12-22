//
//  PagingOffsetIdDemoViewController.swift
//  swiftArch
//
//  Created by czq on 2018/5/16.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import RxSwift
import swiftArch

class PagingOffsetIdDemoViewController: PagingTableViewController {

    var socailAppService:SocialAppService=DataManager.shareInstance.socailAppService
    
   
    //可以不需要重写该方法
    override func initView() {
        super.initView()
        self.title="真实的分页请求"
        
        self.tableView?.estimatedRowHeight = 80;//这个值不影响行高 最好接近你想要的值
        self.tableView?.separatorStyle=UITableViewCell.SeparatorStyle.none
    }
    
   
    
 
    override func registerCellModel() {
        self.tableView?.registerCellClass(cellClass: BannerCell.self, modelClass: BannersVM.self)
        self.tableView?.registerCellNib(nib:UINib(nibName: "FeedArticleCell", bundle: nil), modelClass: FeedArtileModel.self)
        
    }
    
    //自定义分页策略 需要用户去写
    override func getPagingStrategy() -> PagingStrategy? {
        let strategy:PagingStrategy=OffsetStrategy(pageSize: 20, offsetIdKey: "id")
        return strategy
    }
    
    override func onLoadData(pagingStrategy: PagingStrategy?) {
        
        let strategy:OffsetStrategy=pagingStrategy as! OffsetStrategy;
        let pageInfo:OffsetPageInfo=strategy.getPageInfo() as! OffsetPageInfo
        
        self.socailAppService.rxGetBannerAndFeedArticle(direction: pageInfo.type, pageSize: pageInfo.pageSize, offsetId: pageInfo.offsetId)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (result) in
                    if(pageInfo.isFirstPage()){
                        self?.dataSource.removeAll()
                        self?.pagingList.removeAll()
                    }
                    self?.dataSource.append(contentsOf: result)
                    self?.pagingList.append(contentsOf: result)
                    self?.loadSuccess(resultData: result)
                }
            , onError: {[weak self]  (error) in
                if let strongSelf=self{
                    strongSelf.loadFail() 
                }
            }).disposed(by: disposeBag)
        
        
    }
    
    
     

}
