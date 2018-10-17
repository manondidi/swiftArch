//
//  DiscoveryDemoViewController.swift
//  swiftArch
//
//  Created by aron on 2018/5/20.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import RxSwift

class FeedsDemoViewController: PagingViewController {
    
    private var socailAppService:SocialAppService=DataManager.shareInstance.socailAppService
    private var datasource = Array<NSObject>()
    private var pagingDatas = Array<SPFeedVM>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK:- 模板方法重写
    
    override func initTableView() {
        super.initTableView()
        self.tableView?.estimatedSectionHeaderHeight = 0
    }
    
    override func registerCellModel() {
        super.registerCellModel()
        self.tableView?.registerCellClass(cellClass: SPFeedCell.self, modelClass: SPFeedVM.self)
    }
    
    override func getPagingStrategy() -> PagingStrategy {
        let strategy:PagingStrategy = OffsetStrategy(pageSize: 20, offsetIdKey: "id")
        return strategy
    }
    
    override func onLoadData(pagingStrategy: PagingStrategy) {
        
        let strategy:OffsetStrategy=pagingStrategy as! OffsetStrategy;
        let pageInfo:OffsetPageInfo=strategy.getPageInfo() as! OffsetPageInfo

        self.socailAppService.rxGetFeedsMock()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (result) in
                if let strongSelf=self{
                    if(pageInfo.isFirstPage()){
                        strongSelf.datasource=result
                    }else{
                        strongSelf.datasource = strongSelf.datasource + result
                    }
                    strongSelf.loadSuccess(resultData: result as NSObject, dataSource: strongSelf.datasource, pagingList: strongSelf.datasource)
                }
         }).disposed(by: disposeBag)
    }
    
    override func tableView(_ tableView: UITableView, heightForModel model: NSObject) -> CGFloat {
        let realItem = model as! SPFeedVM
        return realItem.cellHeight
    }
}
