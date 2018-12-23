//
//  PaingTalbeDemoViewController.swift
//  swiftArch
//
//  Created by czq on 2018/5/16.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import RxSwift
import swiftArch
class PaingTalbeDemoViewController: PagingTableViewController {

    var socailAppService: SocialAppService = DataManager.socailAppService


    //可以不需要重写该方法
    override func initView() {
        super.initView()
        self.title = "真实的分页请求(还支持section)"

        self.tableView?.estimatedRowHeight = 80//这个值不影响行高 最好接近你想要的值
        self.tableView?.estimatedSectionHeaderHeight = 40
        
    }
    
    override func registerEventforCell(cell: UITableViewCell, model: NSObject) {
        
    }
    
    override func registerEventforSectionHeader(header: UIView, model: NSObject) {
        
    }


    override func registerCellModel() {
        super.registerCellModel()
        self.tableView?.registerCellNib(nib: UINib(nibName: "GameCell", bundle: nil), modelClass: GameModel.self)
    }

    override func registerSectionHeaderModel() {
        super.registerSectionHeaderModel()
        self.tableView?.registerHeaderClass(headerClass: GameDateHeader.self, modelClass: GameDateModel.self)
    }

    //自定义分页策略 需要用户去写
    override func getPagingStrategy() -> PagingStrategy {
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
                self?.dataSource.append(GameDateModel(date: "2011-11-\(Int(arc4random() % 30) + 1)"))
                self?.dataSource.append(contentsOf: result.listData!)
                self?.pagingList.append(contentsOf: result.listData!)
                self?.loadSuccess(resultData: result)
            }, onError: { [weak self] error in
                    self?.loadFail(error)
                }).disposed(by: disposeBag)

    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if let _ = self.getRealDataSourceModel(indexPath: indexPath) as? GameModel {
            return true
        }
        return false
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.dataSource.remove(at: self.getDataSourceRowIndex(indexPath: indexPath))
        self.pagingList.remove(at: 0)//随便删除哪条 只是用来作分页计算
        self.tableView?.reloadData()
    }

}
