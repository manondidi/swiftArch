//
//  PagingCollectionDemoViewController.swift
//  swiftArch
//
//  Created by czq on 2018/6/25.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class PagingCollectionDemoViewController: PagingCollectionViewController {

    var socailAppService:SocialAppService=DataManager.shareInstance.socailAppService
    
    private var pagingList=Array<GameModel>()
    
    private var datasource=Array<NSObject>()
    
    //可以不需要重写该方法
    override func initView() {
        super.initView()
        self.title="真实的分页请求"
    }
  
    override func registerCellModel() {
        super.registerCellModel()
        self.collectionView?.registerCellNib(nib: R.nib.gameCollectionCell(), modelClass: GameModel.self)
        self.collectionView?.registerCellNib(nib: R.nib.addGameCollectionCell(), modelClass: AddGameModel.self)
        self.collectionView?.registerCellNib(nib: R.nib.gameCollectionHeaderCell(), modelClass: GameCollectionHeaderModel.self)
    }
    
    
    //自定义分页策略 需要用户去写
    override func getPagingStrategy() -> PagingStrategy {
        let strategy:PagingStrategy=NormalPagingStrategy(startPageNum: 0, pageSize: 30)
        return strategy
    }
    override func onLoadData(pagingStrategy: PagingStrategy) {
        
        let strategy:NormalPagingStrategy=pagingStrategy as! NormalPagingStrategy;
        let pageInfo:NormalPageInfo=strategy.getPageInfo() as! NormalPageInfo
        self.socailAppService.getGame(pageNum: pageInfo.pageNum, pageSize: pageInfo.pageSize, success: { [weak self] (gameListModel) in
            if let strongSelf = self {
                if(pageInfo.isFirstPage()){
                    strongSelf.pagingList=(gameListModel?.listData)!
                    strongSelf.datasource=(gameListModel?.listData)!
                    strongSelf.datasource.insert(GameCollectionHeaderModel(title: "第\(pageInfo.pageNum)页数据"), at: 0)
                }else{
                    strongSelf.pagingList+=(gameListModel?.listData)!
                    strongSelf.datasource.append(GameCollectionHeaderModel(title: "第\(pageInfo.pageNum)页数据"))
                    strongSelf.datasource = strongSelf.datasource + (gameListModel?.listData)!
                }
                strongSelf.loadSuccess(resultData: gameListModel!, dataSource: strongSelf.datasource, pagingList: strongSelf.pagingList)
                let isFinish=strategy.checkFinish(result: gameListModel!, listSize: strongSelf.pagingList.count)
                if(isFinish){
                    strongSelf.datasource.append(AddGameModel())
                    strongSelf.loadSuccess(resultData: gameListModel!, dataSource: strongSelf.datasource, pagingList: strongSelf.pagingList)
                }
                
            }
        }) {[weak self] (code, msg) in
            self?.loadFail()
        }
        
    }
 
    override func registerEventforCell(cell: UICollectionViewCell, model: NSObject) {
        if let item:GameModel = model as? GameModel {
            
            cell.addTapGesture {[weak self] (tap) in
                self?.view.makeToast("cell被点击\(String(describing: item.title))")
            }
        }else   if let item:AddGameModel = model as? AddGameModel {
            
            cell.addTapGesture {[weak self] (tap) in
                self?.view.makeToast("添加cell被点击")
            }
        }
    }
    
    override func collectionView(collection: UICollectionView, sizeForModel model: NSObject) -> CGSize {
        
        if let _:GameModel = model as? GameModel {
            let width=UIScreen.main.bounds.width/4.0
            return CGSize(width:width,height:130/115.0*width)
        }else if let _:AddGameModel = model as? AddGameModel {
                let width=UIScreen.main.bounds.width/4.0
                return CGSize(width:width,height:130/115.0*width)
        }else if let _:GameCollectionHeaderModel = model as? GameCollectionHeaderModel {
            let width=UIScreen.main.bounds.width
            return CGSize(width:width,height:40)
        }
        return CGSize.zero
    }
    
    

}
