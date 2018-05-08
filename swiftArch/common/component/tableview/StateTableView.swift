//
//  StateTableView.swift
//  swiftArch
//
//  Created by czq on 2018/5/8.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import SnapKit

class StateTableView: UITableView {
    
    var loadView:UIView?
    var emptyView:UIView?
    var errorView:UIView?
    
    func setUpLoadView(view:UIView?) {
        if (view != nil ){
            loadView=view;
        }
        else{
            loadView=defaultLoadView()
        }
    }
    
    private func defaultLoadView()->UIView{
        
        return UIView()
    }
    
    
    func setUpEmptyiew(view:UIView?) {
        if (view != nil ){
            emptyView=view;
        }
        else{
            emptyView=defaultEmptyView()
        }
    }
    
    private func defaultEmptyView()->UIView{
        
        return UIView()
    }
    
    
    func setUpErroriew(view:UIView?) {
        if (view != nil ){
            errorView=view;
        }
        else{
            errorView=defaultErrorView()
        }
    }
    
    private func defaultErrorView()->UIView{
        
        return UIView()
    }
    
    func setUpState()  {
        
        self.addSubview(loadView!)
        self.addSubview(emptyView!)
        self.addSubview(errorView!)
        
        loadView?.snp.makeConstraints({ (make) in
            make.left.right.top.bottom.equalToSuperview()
        })
        emptyView?.snp.makeConstraints({ (make) in
            make.left.right.top.bottom.equalToSuperview()
        })
        errorView?.snp.makeConstraints({ (make) in
            make.left.right.top.bottom.equalToSuperview()
        })
        
        self.showLoading()
        
        
    }
    
    func showContent(){
        loadView?.isHidden=true
        emptyView?.isHidden=true
        errorView?.isHidden=true
    }
    
    func showLoading()  {
        self.showContent()
        loadView?.isHidden=false
    }
    func showEmpty()  {
        self.showContent()
        emptyView?.isHidden=false
    }
    
    func showError()  {
        self.showContent()
        errorView?.isHidden=false
    }
    
    func beginRefresh() {
        
    }
    
    func endRefresh(){
        
    }
    
    func beginLoadMore(){
        
    }
    
    func endLoadMore(){
        
        
    }
  

}
