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
    
    //可以不需要重写该方法
    override func initView() {
        super.initView()
        self.title="真实的分页请求"
    }
    
     
  
    override func registerCellModel() {
        super.registerCellModel()
        self.collectionView?.registerCellNib(nib: R.nib.gameCollectionCell(), modelClass: GameModel.self)
    }
    
    
    //自定义分页策略 需要用户去写
    override func getPagingStrategy() -> PagingStrategy {
        let strategy:PagingStrategy=NormalPagingStrategy(startPageNum: 0, pageSize: 20)
        return strategy
    }
    override func onLoadData(pagingStrategy: PagingStrategy) {
        
        let strategy:NormalPagingStrategy=pagingStrategy as! NormalPagingStrategy;
        let pageInfo:NormalPageInfo=strategy.getPageInfo() as! NormalPageInfo
        self.socailAppService.getGame(pageNum: pageInfo.pageNum, pageSize: pageInfo.pageSize, success: { [weak self] (gameListModel) in
            if let strongSelf = self {
                if(pageInfo.isFirstPage()){
                    strongSelf.pagingList=(gameListModel?.listData)!
                }else{
                    strongSelf.pagingList+=(gameListModel?.listData)!
                }
                strongSelf.loadSuccess(resultData: gameListModel!, dataSource: strongSelf.pagingList, pagingList: strongSelf.pagingList)
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
        }
    }
    
    override func collectionView(collection: UICollectionView, sizeForModel model: NSObject) -> CGSize {
        
        if let item:GameModel = model as? GameModel {
            return CGSize(width:85,height:95) 
        }
        return CGSize.zero
    }
    
    

}
