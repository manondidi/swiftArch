//
//  PagingCollectionViewTempController.swift
//  swiftArch_Example
//
//  Created by czq on 2018/12/24.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import swiftArch
import RxSwift

class PagingCollectionViewTempController: PagingCollectionViewController { 
 
    var socailAppService: SocialAppService = DataManager.socailAppService

 	override func initView() {
        super.initView() 

    }
 

    override func registerCellModel() {
        super.registerCellModel()
        self.collectionView?
            .registerCellNib(nib: UINib(nibName: "GameCollectionCell", bundle: nil), modelClass: GameModel.self)
        self.collectionView?
            .registerCellNib(nib: UINib(nibName: "AddGameCollectionCell", bundle: nil), modelClass: AddGameModel.self)
        self.collectionView?
            .registerCellNib(nib: UINib(nibName: "GameCollectionHeaderCell", bundle: nil), modelClass: GameCollectionHeaderModel.self)

    }


    override func registerEventforCell(cell: UICollectionViewCell, model: NSObject) {
        
    }

    override func collectionView(collection: UICollectionView, sizeForModel model: NSObject) -> CGSize {

        if let _: GameModel = model as? GameModel {
            let width = UIScreen.main.bounds.width / 4.0
            return CGSize(width: width, height: 130 / 115.0 * width)
        } else if let _: AddGameModel = model as? AddGameModel {
            let width = UIScreen.main.bounds.width / 4.0
            return CGSize(width: width, height: 130 / 115.0 * width)
        } else if let _: GameCollectionHeaderModel = model as? GameCollectionHeaderModel {
            let width = UIScreen.main.bounds.width
            return CGSize(width: width, height: 40)
        }
        return CGSize.zero
    } 
 
   
    
    //自定义分页策略 需要用户去写
    override func getPagingStrategy() -> PagingStrategy? { 
        let strategy: PagingStrategy = NormalPagingStrategy(startPageNum: 0, pageSize: 30)
        return strategy
    }
    
    override func onLoadData(pagingStrategy: PagingStrategy?) {
        
        let strategy: NormalPagingStrategy = pagingStrategy as! NormalPagingStrategy
        let pageInfo: NormalPageInfo = strategy.getPageInfo() as! NormalPageInfo
        
        self.socailAppService.rxGetGame(pageNum: pageInfo.pageNum, pageSize: pageInfo.pageSize)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (result) in
                if(pageInfo.isFirstPage()) {
                    self?.pagingList.removeAll()
                    self?.dataSource.removeAll()
                }
                self?.dataSource.append(GameCollectionHeaderModel(title: "第\(pageInfo.pageNum)页数据"))
                self?.dataSource.append(contentsOf: result.listData!)
                self?.pagingList.append(contentsOf: result.listData!)
                self?.loadSuccess(resultData: result)
                }, onError: { [weak self] error in
                    self?.loadFail(error)
            })
            .disposed(by: disposeBag)
        
    }
     
}

