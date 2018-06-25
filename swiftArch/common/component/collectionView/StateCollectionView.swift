//
//  StateCollectionView.swift
//  swiftArch
//
//  Created by czq on 2018/6/25.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import MJRefresh
class StateCollectionView: UICollectionView  {
    
    var loadView:UIView?
    var emptyView:UIView?
    var errorView:UIView?
    
    
    private var refreshHeader:MJRefreshHeader?
    private var loadMoreFooter:MJRefreshFooter?
    
    
    typealias refreshCallback = () -> Void
    typealias loadMoreCallback = () -> Void
    
    private var refreshCallback:refreshCallback?
    private var loadMoreCallback:loadMoreCallback?
    
    func setLoadView(view:UIView) {
        loadView=view;
    }
    func setEmptyiew(view:UIView) {
        emptyView=view;
    }
    
    func setErroriew(view:UIView) {
        errorView=view;
    }
    
    func setRefreshHeader(refreshHeader:MJRefreshHeader)  {
        self.refreshHeader=refreshHeader
    }
    
    func setLoadMoreFooter(loadMoreFooter:MJRefreshFooter)  {
        self.loadMoreFooter=loadMoreFooter
    }
    
    func setRefreshCallback(refreshCallback:@escaping refreshCallback){
        self.refreshCallback=refreshCallback
    }
    func setLoadMoreCallback(loadMoreCallback:@escaping loadMoreCallback){
        self.loadMoreCallback=loadMoreCallback
    }
    
    
    func setUpState()  {
        
        if loadView==nil {
            let dLoadView:DefaultTableLoadView=R.nib.defaultTableLoadView.firstView(owner: nil)!
            loadView=dLoadView
        }
        if emptyView==nil {
            let dEmptyView:DefaultTableEmptyView=R.nib.defaultTableEmptyView.firstView(owner: nil)!
            emptyView=dEmptyView
        }
        if errorView==nil {
            let dErrorView:DefaultTableErrorView=R.nib.defaultTableErrorView.firstView(owner: nil)!
            errorView=dErrorView
        }
        
        self.addSubview(loadView!)
        self.addSubview(emptyView!)
        self.addSubview(errorView!)
        loadView?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(self)
        })
        emptyView?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(self)
        })
        errorView?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(self)
        })
        if refreshHeader == nil {
            useDefaultHeaderStyle()
        }
        if loadMoreFooter == nil {
            useDefaultFooterStyle()
        }
        self.mj_header=refreshHeader
        self.mj_footer=loadMoreFooter
        self.mj_footer.isHidden=true
        self.mj_header.setRefreshingTarget(self, refreshingAction: #selector(self.onRefresh))
        self.mj_footer.setRefreshingTarget(self, refreshingAction: #selector(self.onLoadMore))
        emptyView?.addTapGesture(handler: { [weak self] (tap) in
            self?.beginRefresh()
            self?.showLoading()
        })
        
        errorView?.addTapGesture(handler: {[weak self]  (tap) in
            self?.beginRefresh()
            self?.showLoading()
        })
        
        self.showContent()
        
        
    }
    @objc func onRefresh(){
        
        loadMoreFooter?.isHidden=true
        self.refreshCallback?()
    }
    
    @objc func onLoadMore(){
        
        self.loadMoreCallback?()
    }
    
    private func hideAllCover(){
        
        loadView?.isHidden=true
        emptyView?.isHidden=true
        errorView?.isHidden=true
    }
    
    public func showContent(){
        
        self.endRefresh()
        self.endLoadMore()
        self.hideAllCover()
        
    }
    
    public func showLoading()  {
        self.hideAllCover()
        loadView?.isHidden=false
        self.bringCoverToFront()
    }
    public func showEmpty()  {
        
        self.showContent()
        emptyView?.isHidden=false
        self.bringCoverToFront()
    }
    
    public func showError()  {
        
        self.showContent()
        errorView?.isHidden=false
        self.bringCoverToFront()
    }
    
    public func beginRefresh() {
        refreshHeader?.beginRefreshing()
    }
    
    public func endRefresh(){
        refreshHeader?.endRefreshing()
    }
    
    public func beginLoadMore(){
        loadMoreFooter?.beginRefreshing()
    }
    
    public func endLoadMore(){
        loadMoreFooter?.endRefreshing()
    }
    
    public func setLoadMoreEnable(b:Bool){
        self.mj_footer.isHidden = !b;
    }
    public func setRefreshEnable(b:Bool){
        self.mj_header.isHidden = !b;
    }
    
    private func useDefaultHeaderStyle(){
        refreshHeader=MJRefreshGifHeader()
        (refreshHeader as! MJRefreshGifHeader).lastUpdatedTimeLabel.isHidden=true
        (refreshHeader as! MJRefreshGifHeader).stateLabel.isHidden = true;
        let images=[R.image.load0(),
                    R.image.load1(),
                    R.image.load2(),
                    R.image.load3(),
                    R.image.load4(),
                    R.image.load5(),
                    R.image.load6(),
                    R.image.load7(),
                    R.image.load8(),
                    R.image.load9(),
                    R.image.load10()]
        (refreshHeader as! MJRefreshGifHeader).setImages(images, for: MJRefreshState.idle)
        (refreshHeader as! MJRefreshGifHeader).setImages(images, for: MJRefreshState.pulling)
        (refreshHeader as! MJRefreshGifHeader).setImages(images, for: MJRefreshState.refreshing)
    }
    private func useDefaultFooterStyle(){
        loadMoreFooter=MJRefreshAutoNormalFooter()
    }
    
    public func bringCoverToFront(){
        self.bringSubview(toFront: emptyView!)
        self.bringSubview(toFront: errorView!)
        self.bringSubview(toFront: loadView!)
    }
    
    
}
