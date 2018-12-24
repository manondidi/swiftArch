//
//  PagingCollectionViewController.swift
//  swiftArch
//
//  Created by czq on 2018/6/25.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import SnapKit
import CocoaLumberjack
import UICollectionViewLeftAlignedLayout
open class PagingCollectionViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    open var collectionView: StateCollectionView?

    var pagingStrategy: PagingStrategy?

    public var dataSource = Array<Any>()

    public var pagingList = Array<Any>()

    open override func initView() {
        super.initView()
        self.pagingStrategy = self.getPagingStrategy()
        self.initCollectionView()
        self.registerCellModel()
        self.createCollectionStateView()
        self.collectionView?.setUpState()
        self.collectionView?.setRefreshCallback { [weak self] in
            self?.onCollectionViewRefresh()
        }
        self.collectionView?.setLoadMoreCallback { [weak self] in
            self?.onCollectionViewLoadMore()
        }
        self.collectionView?.dataSource = self;
        self.collectionView?.delegate = self;
    }
    
    open override func start() {
        super.start()
        self.collectionView?.beginRefresh()
    }
    
    ///提供分页策略 必须重写
    open func getPagingStrategy() -> PagingStrategy? {
        return nil
    }


    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.dataSource[indexPath.item] as? NSObject ?? NSObject()
        let cellKey = String(describing: item.classForCoder.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellKey, for: indexPath)
        let c = cell as! CellProtocol
        c.bindModel(item)
        self.registerEventforCell(cell: cell, model: item)
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = self.dataSource[indexPath.item] as? NSObject ?? NSObject()
        return self.collectionView(collection: collectionView, sizeForModel: item)
    }

    //必须重写
    open func collectionView(collection: UICollectionView, sizeForModel model: NSObject) -> CGSize {
        return CGSize.zero
    }
    

    open func initCollectionView() { //子类重写(如果有必要)
        let layout = UICollectionViewLeftAlignedLayout();
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        self.collectionView = StateCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.collectionView?.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView!)
        self.collectionView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })

    }

    open func registerCellModel() { }

    open func createCollectionStateView() { }

    open func onCollectionViewRefresh() {
        self.pagingStrategy?.resetPage()
        if self.dataSource.count == 0 {
            self.collectionView?.showLoading()
        }
        self.loadData()
    }

    open func loadData(){
        self.onLoadData(pagingStrategy: self.pagingStrategy)
    }
    
    
    open func onCollectionViewLoadMore() {
        self.loadData()
    }

    ///
    /// - Parameters:
    ///   - resultData: 完整的返回值(因为我要从里面取分页信息比如total)
    open func loadSuccess(resultData: NSObject?) {
        self.collectionView?.showContent()
        self.pagingStrategy?.addPage(info: self.pagingList)
        let isFinish = self.pagingStrategy?.checkFinish(result: resultData, listSize: self.pagingList.count)
        self.collectionView?.setLoadMoreEnable(b: !isFinish!)
        self.collectionView?.reloadData()
        if self.dataSource.isEmpty {
            self.collectionView?.showEmpty()
        }
    }

    open func loadFail(_ error: Error? = nil) {
        if(self.dataSource.count == 0) {
            self.collectionView?.showError()
        } else {
            self.view.makeToast("加载失败")
        }
        DDLogError(error?.localizedDescription ?? "")
    }

    ///子类必须重写
    open func onLoadData(pagingStrategy: PagingStrategy?) { }


    ///子类重写去注册cell或者cell内部的事件
    open func registerEventforCell(cell: UICollectionViewCell, model: NSObject) { }
}
