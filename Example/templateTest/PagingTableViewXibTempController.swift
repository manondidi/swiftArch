//
//  PagingTableViewXibTempController.swift
//  swiftArch_Example
//
//  Created by czq on 2018/12/24.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import swiftArch
import RxSwift

class PagingTableViewXibTempController: PagingTableViewController { 


    var socailAppService: SocialAppService = DataManager.socailAppService

 	override func initView() {
        super.initView() 

    }

     override func initTableView() {
        self.tableView=(self.view.viewWithTag(9000001) as! StateTableView)
        self.tableView?.estimatedSectionHeaderHeight = 0
        
    }


    override func registerCellModel() {
        self.tableView?.registerCellNib(nib: UINib(nibName: "GameCell", bundle: nil), modelClass: GameModel.self)
    }
    
    override func registerEventforCell(cell: UITableViewCell, model: NSObject) {
        
    }
    
    override func getPagingStrategy() -> PagingStrategy? {
        let strategy: PagingStrategy = NormalPagingStrategy(startPageNum: 0, pageSize: 20)
        return strategy
    }
    
    override func onLoadData(pagingStrategy: PagingStrategy?) {
        
        let strategy: NormalPagingStrategy = pagingStrategy as! NormalPagingStrategy;
        let pageInfo: NormalPageInfo = strategy.getPageInfo() as! NormalPageInfo
        
        self.socailAppService.rxGetGame(pageNum: pageInfo.pageNum, pageSize: pageInfo.pageSize)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (result) in
                if(pageInfo.isFirstPage()) {
                    self?.dataSource.removeAll()
                    self?.pagingList.removeAll()
                }
                self?.dataSource.append(contentsOf: result.listData!)
                self?.pagingList.append(contentsOf: result.listData!)
                self?.loadSuccess(resultData: result)
                }, onError: { [weak self] error in
                    self?.loadFail(error)
            }).disposed(by: disposeBag)
        
        
    }
}

