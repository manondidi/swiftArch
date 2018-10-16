//
//  PagingOffsetIdDemoViewController.swift
//  swiftArch
//
//  Created by czq on 2018/5/16.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import RxSwift

class PagingOffsetIdDemoViewController: PagingViewController {

    var socailAppService:SocialAppService=DataManager.shareInstance.socailAppService
    
    private var datasource=Array<NSObject>()
    private var pagingList=Array<NSObject>()
    let disposeBag = DisposeBag()
    
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
        self.tableView?.registerCellClass(cellClass: BannerCell.self, modelClass: BannersVM.self)
        self.tableView?.registerCellNib(nib: R.nib.feedArticleCell(), modelClass: FeedArtileModel.self)
    }
    
    //自定义分页策略 需要用户去写
    override func getPagingStrategy() -> PagingStrategy {
        let strategy:PagingStrategy=OffsetStrategy(pageSize: 20, offsetIdKey: "id")
        return strategy
    }
    override func onLoadData(pagingStrategy: PagingStrategy) {
        
        let strategy:OffsetStrategy=pagingStrategy as! OffsetStrategy;
        let pageInfo:OffsetPageInfo=strategy.getPageInfo() as! OffsetPageInfo
        
        self.socailAppService.rxGetBannerAndFeedArticle(direction: pageInfo.type, pageSize: pageInfo.pageSize, offsetId: pageInfo.offsetId)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (bannerArticleList) in
                if let strongSelf=self{
                    if(pageInfo.isFirstPage()){
                        strongSelf.pagingList=bannerArticleList
                        strongSelf.datasource=bannerArticleList
                    }else{
                        strongSelf.pagingList = strongSelf.pagingList + bannerArticleList
                        strongSelf.datasource = strongSelf.datasource + bannerArticleList
                    }
                    strongSelf.loadSuccess(resultData: bannerArticleList as NSObject, dataSource: strongSelf.datasource, pagingList: strongSelf.pagingList)
                }
            }, onError: {[weak self]  (error) in
                if let strongSelf=self{
                    strongSelf.loadFail() 
                }
            }).disposed(by: disposeBag)
        
        
    }
    
    
     

}
