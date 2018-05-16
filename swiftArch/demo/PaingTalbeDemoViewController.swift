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
 
  
    override func initTableView() {
        super.initTableView()
        self.tableView?.estimatedRowHeight = 80;//这个值不影响行高 最好接近你想要的值
        self.tableView?.rowHeight=UITableViewAutomaticDimension
    }
    override func registerCellModel() {
        self.tableView?.registerCellNib(nib: R.nib.gameCell(), modelClass: GameModel.self)
    }
    override func getPagingStrategy() -> PagingStrategy {
        let strategy:PagingStrategy=NormalPagingStrategy(startPageNum: 0, pageSize: 20)
        return strategy
    }
    override func onLoadData(pagingStrategy: PagingStrategy) {
         
        let strategy:NormalPagingStrategy=pagingStrategy as! NormalPagingStrategy;
        let pageInfo:NormalPageInfo=strategy.getPageInfo() as! NormalPageInfo
        self.remoteService.getGame(pageNum: pageInfo.pageNum, pageSize: pageInfo.pageSize, success: { (gameListModel) in
            if(pageInfo.pageNum==pageInfo.startPageNum){
                self.pagingList=(gameListModel?.listData)!
                self.datasource=(gameListModel?.listData)!
            }else{
                self.pagingList+=(gameListModel?.listData)!
                self.datasource.append(contentsOf: (gameListModel?.listData)!) 
            }
            self.loadSuccess(resultData: gameListModel!, dataSource: self.datasource, pagingList: self.pagingList)
            
        }) { (code, msg) in
            self.loadFail()
        }
        
    }
}
