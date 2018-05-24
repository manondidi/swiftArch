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
        let strategy:PagingStrategy = FeedPaingStrategy(pageSize: 20, offsetIdKey: "id")
        return strategy
    }
    
    override func onLoadData(pagingStrategy: PagingStrategy) {
        
        let strategy:FeedPaingStrategy=pagingStrategy as! FeedPaingStrategy;
        let pageInfo:FeedPageInfo = strategy.getPageInfo() as! FeedPageInfo
        
        self.remoteService.getFeedsMock { (result: Array<SPFeedVM>) in
            print("")
            
            if(pageInfo.isFirstPage()){
                self.pagingDatas = result
                self.datasource = result
                //如果要使用sectionHeader功能
                // self.datasource.insert(EmptyHeaderModel(), at: 0)//第一行一定是SectionModel
                //因为我是靠sectionmodel的个数做section截断
                //如果和业务相悖,就插入emptyheadermodel占位
                //这个model对应的headerview是是个高度为1 完全透明的一个header
                //如果你确定你的一整个datasource是不可能存在sectionmodel即不使用section功能
                //那你可以不需要插EmptyHeaderModel
                
            }else{
                self.pagingDatas += result
                self.datasource = self.datasource + result
            }
            
            // 调用者必须维护两个列表
            // 1.和分页相关的列表
            // 2.总数据源的列表
            self.loadSuccess(resultData: result as NSObject, dataSource: self.datasource, pagingList: self.pagingDatas)
        }
    }
    
    // MARK:- UITableViewDataSource
    override func tableView(_ cell: UITableViewCell?, heightForModel model: NSObject) -> CGFloat {
        let realItem = model as! SPFeedVM
        return realItem.cellHeight
    }
}
