//
//  DiscoveryDemoViewController.swift
//  swiftArch
//
//  Created by aron on 2018/5/20.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import RxSwift
import swiftArch
class FeedsDemoViewController: PagingTableViewController {

    private var socailAppService: SocialAppService = DataManager.shareInstance.socailAppService
    private var datasource = Array<NSObject>()
    private var pagingDatas = Array<SPFeedVM>()



    override func initTableView() {
        super.initTableView()
        self.tableView?.estimatedSectionHeaderHeight = 0
    }

    override func registerCellModel() {
        super.registerCellModel()
        self.tableView?.registerCellClass(cellClass: SPFeedCell.self, modelClass: SPFeedVM.self)
    }

    override func getPagingStrategy() -> PagingStrategy? {
        let strategy: PagingStrategy = OffsetStrategy(pageSize: 20, offsetIdKey: "id")
        return strategy
    }

    override func onLoadData(pagingStrategy: PagingStrategy) {

        let strategy: OffsetStrategy = pagingStrategy as! OffsetStrategy;
        let pageInfo: OffsetPageInfo = strategy.getPageInfo() as! OffsetPageInfo

        self.socailAppService.rxGetFeedsMock()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (result) in
                if(pageInfo.isFirstPage()) {
                    self?.dataSource.removeAll()
                    self?.pagingList.removeAll()
                }
                self?.dataSource.append(contentsOf: result)
                self?.pagingList.append(contentsOf: result)
                self?.loadSuccess(resultData: result)
            }
                , onError: { [weak self] (error) in
                    if let strongSelf = self {
                        strongSelf.loadFail()
                    }
                }).disposed(by: disposeBag)

    }

    override func tableView(_ tableView: UITableView, heightForModel model: NSObject) -> CGFloat {
        let realItem = model as! SPFeedVM
        return realItem.cellHeight
    }
}
