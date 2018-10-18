//
//  PagingCollectionViewController.swift
//  swiftArch
//
//  Created by czq on 2018/6/25.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import UICollectionViewLeftAlignedLayout
open class PagingCollectionViewController: BaseViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
   
   open var collectionView:StateCollectionView?
    
   open var pagingStrategy:PagingStrategy?
    
   open var dataSource=Array<NSObject>()
    
    open override func initView() {
        super.initView()
        self.edgesForExtendedLayout = UIRectEdge.bottom
        self.automaticallyAdjustsScrollViewInsets = false;
        self.pagingStrategy=self.getPagingStrategy()
        self.initCollectionView()
        self.registerCellModel()
        self.setCollectionStateView()
        self.collectionView?.setUpState()
        self.collectionView?.setRefreshCallback {[weak self] in
            self?.onCollectionViewRefresh()
        }
        self.collectionView?.setLoadMoreCallback {[weak self] in
            self?.onCollectionViewLoadMore()
        }
        
        self.collectionView?.dataSource=self;
        self.collectionView?.delegate=self;
    }
    ///提供分页策略 必须重写
    open func getPagingStrategy() -> PagingStrategy {
        return NonePagingStrategy()
    }
    
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item=self.dataSource[indexPath.item]
        let cellKey=String(describing:item.classForCoder.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellKey, for: indexPath)
        cell.setValue(item, forKey: "model")
        self.registerEventforCell(cell: cell, model: item)
        return cell
    }

    //禁止重写
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item:NSObject = self.dataSource[indexPath.item]
        return self.collectionView(collection:collectionView, sizeForModel: item)
        
    }

    //必须重写
    open func collectionView(collection: UICollectionView,sizeForModel model: NSObject)->CGSize {
        return CGSize.zero
    }
    open override  func viewDidAppear(_ animated: Bool) {
        self.collectionView?.beginRefresh()
    }
    
    open func initCollectionView(){//子类重写(如果有必要)
        
        let layout=UICollectionViewLeftAlignedLayout();
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        self.collectionView=StateCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.collectionView?.backgroundColor=UIColor.white
        self.view.addSubview(self.collectionView!)
        self.collectionView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
       
    }
    
    open func registerCellModel()  {}
    
    open func setCollectionStateView(){}
    
    open func  onCollectionViewRefresh() {
        self.pagingStrategy?.resetPage()
        if self.dataSource.count==0 {
            self.collectionView?.showLoading()
        }
        self.onLoadData(pagingStrategy: self.pagingStrategy!)
    }
    
    open func onCollectionViewLoadMore(){
        self.onLoadData(pagingStrategy:self.pagingStrategy!)
    }
    ///
    /// - Parameters:
    ///   - resultData: 完整的返回值(因为我要从里面取分页信息比如total)
    ///   - dataSource: 完整的列表的数组(用于展示)
    ///   - pagingList: 分页相关的列表数组
    open func loadSuccess(resultData:NSObject,dataSource:Array<NSObject>,pagingList:Array<NSObject>){
        self.collectionView?.showContent()
        self.pagingStrategy?.addPage(info: pagingList)
        let isFinish=self.pagingStrategy?.checkFinish(result: resultData, listSize: pagingList.count)
        self.collectionView?.setLoadMoreEnable(b:!isFinish! )
       
        self.reloadDatasource(dataSource: dataSource)
    }
    open func loadFail(){
        if(self.dataSource.count==0){
            self.collectionView?.showError()
        }else{
            self.view.makeToast("加载失败")
        }
    }
    
    open func reloadDatasource(dataSource:Array<NSObject>){
        if(dataSource.count==0){
            self.collectionView?.showEmpty()
        }
        self.dataSource=dataSource;
        self.collectionView?.reloadData()
    }
    
    ///子类必须重写
    open func onLoadData(pagingStrategy:PagingStrategy){}
    
    
    ///子类重写去注册cell或者cell内部的事件
    open func registerEventforCell(cell:UICollectionViewCell,model:NSObject){}
}
