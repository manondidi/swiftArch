//
//  PageSateManager.swift
//  swiftArch
//
//  Created by czq on 2018/5/10.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import Closures

class PageSateManager: NSObject {

    private var emptyView:UIView?
    private var errorView:UIView?
    private var loadView:UIView?
    
    
    typealias reloadCallback = () -> Void
    
    private var reloadCallback:reloadCallback?
    
    private var rootView:UIView
    
    init(rootView:UIView) {
        self.rootView=rootView
        
    }
    
    public func bringCoverToFront(){
        self.rootView.bringSubview(toFront: emptyView!)
        self.rootView.bringSubview(toFront: errorView!)
        self.rootView.bringSubview(toFront: loadView!)
    }
    
    public func setEmptyView(view:UIView){
        self.emptyView=view
    }
    
    public func setErrorView(view:UIView){
        self.errorView=view
    }
    public func setLoadView(view:UIView){
        self.loadView=view
    }
    
    private func userDefaultEmptyView(){
        self.emptyView=PageStateEmptyView()
    }
    
    private func userDefaultErrorView(){
        self.errorView=PageStateErrorView()
    }
    
    private func userDefaultLoadView(){
        self.loadView=PageStateLoadView()
    }
    
    
    public func setReloadCallback(reloadCallback:@escaping reloadCallback){
        self.reloadCallback=reloadCallback
    }
    
    public func showContent( ){
        self.errorView?.isHidden=true
        self.loadView?.isHidden=true
        self.emptyView?.isHidden=true
    }
    
    public func showEmpty(){
        self.showContent()
        self.emptyView?.isHidden=false
        self.bringCoverToFront()
    }
    public func showLoading(){
        self.showContent()
        self.loadView?.isHidden=false
        self.bringCoverToFront()
    }
    public func showError(){
        self.showContent()
        self.errorView?.isHidden=false
        self.bringCoverToFront()
    }
    
    public func setUpState()  {
        if (self.errorView==nil){
            self.userDefaultErrorView()
        }
        
        if (self.emptyView==nil){
            self.userDefaultEmptyView()
        }
        
        if (self.loadView==nil){
            self.userDefaultLoadView()
        }
        
        rootView.addSubview(emptyView!)
        rootView.addSubview(errorView!)
        rootView.addSubview(loadView!)
        
        emptyView?.snp.makeConstraints({ (make) in
            make.width.height.equalToSuperview()
        })
        errorView?.snp.makeConstraints({ (make) in
            make.width.height.equalToSuperview()
        })
        loadView?.snp.makeConstraints({ (make) in
            make.width.height.equalToSuperview()
        })
        
        errorView?.addTapGesture(handler: { [weak self] (tap) in
            self?.reloadCallback?()
        })
        
        
    }
    

}
