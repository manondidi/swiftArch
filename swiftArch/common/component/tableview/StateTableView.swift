//
//  StateTableView.swift
//  swiftArch
//
//  Created by czq on 2018/5/8.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh
import Closures

class StateTableView: UITableView {
    
    var loadView:UIView?
    var emptyView:UIView?
    var errorView:UIView?
    
    
    private var refreshHeader:MJRefreshHeader?
    private var loadMoreFooter:MJRefreshFooter?
    
    
    typealias refreshCallback = () -> Void
    typealias loadMoreCallback = () -> Void
    
   private var refreshCallback:refreshCallback?
   private var loadMoreCallback:loadMoreCallback?
    
    func setUpLoadView(view:UIView) {
        loadView=view;
    }
    
    func setUpEmptyiew(view:UIView) {
        emptyView=view;
    }
    
    
    func setUpErroriew(view:UIView) {
        errorView=view;
    }
    
    func setRefreshCallback(refreshCallback:@escaping refreshCallback){
        self.refreshCallback=refreshCallback
    }
    func setLoadMoreCallback(loadMoreCallback:@escaping loadMoreCallback){
        self.loadMoreCallback=loadMoreCallback
    }
    
    
    func setUpState()  {
        
        if loadView==nil {
            let dLoadView:DefaultTableLoadView = Bundle.main.loadNibNamed("DefaultTableLoadView", owner: nil, options: nil)?.first as! DefaultTableLoadView
            loadView=dLoadView
        }
        
        if emptyView==nil {
            let dEmptyView:DefaultTableEmptyView = Bundle.main.loadNibNamed("DefaultTableEmptyView", owner: nil, options: nil)?.first as! DefaultTableEmptyView
            emptyView=dEmptyView
        }
        
        if errorView==nil {
            let dErrorView:DefaultTableErrorView = Bundle.main.loadNibNamed("DefaultTableErrorView", owner: nil, options: nil)?.first as! DefaultTableErrorView
            errorView=dErrorView
        } 
        self.superview?.addSubview(loadView!)
        self.superview?.addSubview(emptyView!)
        self.superview?.addSubview(errorView!)
        
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
        
        self.mj_header.setRefreshingTarget(self, refreshingAction: #selector(self.onRefresh))
        self.mj_footer.setRefreshingTarget(self, refreshingAction: #selector(self.onLoadMore))
        self.showLoading()
        
        
        emptyView?.addTapGesture(handler: { (tap) in
            self.beginRefresh()
            self.showLoading()
        })
        errorView?.addTapGesture(handler: { (tap) in
            self.beginRefresh()
            self.showLoading()
        })
        
        self.showError()
        
    }
    @objc func onRefresh(){
        self.refreshCallback?()
    }
    
    @objc func onLoadMore(){
        
        self.loadMoreCallback?()
    }
    
   public func showContent(){
        loadView?.isHidden=true
        emptyView?.isHidden=true
        errorView?.isHidden=true
    }
    
   public func showLoading()  {
        self.showContent()
        loadView?.isHidden=false
    }
    public func showEmpty()  {
        self.showContent()
        emptyView?.isHidden=false
    }
    
    public func showError()  {
        self.showContent()
        errorView?.isHidden=false
    }
    
    public func beginRefresh() {
        refreshHeader?.beginRefreshing()
    }
    
    public func endRefresh(){
        self.showContent()
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
        loadMoreFooter=MJRefreshAutoFooter()
    }
  

}
