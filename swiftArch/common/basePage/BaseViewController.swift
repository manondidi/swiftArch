//
//  StateViewController.swift
//  swiftArch
//
//  Created by czq on 2018/5/12.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    private var stateManager:PageSateManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    func initView() {//需要子类重写
        self.view.backgroundColor=UIColor.white
        stateManager=PageSateManager(rootView: self.view)
        self.setStateManagerView(sateManager: self.stateManager!)
        stateManager?.setUpState()
        stateManager?.setReloadCallback {[weak self] in
            self?.onReload()
        } 
    }
    func setStateManagerView(sateManager:PageSateManager){//子类重写这个方法去自定义几种View的样式
            //  stateManager?.setLoadView(view: )
    }
    
    func onReload(){ //子类必须重写这个方法
        //当用户点击erroview的时候会回调这个方法
    } 
    func showContent(){
        stateManager?.showContent()
    }
    func showLoading(){
        stateManager?.showLoading()
    }
    func showEmpty(){
        stateManager?.showEmpty()
    }
    func showError(){
        stateManager?.showError()
    }
 

    deinit {
        print("########### \(String(describing:self.classForCoder.self))deinit################")
    }
}
