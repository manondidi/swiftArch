//
//  StateViewController.swift
//  swiftArch
//
//  Created by czq on 2018/5/12.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import CocoaLumberjack
import RxSwift
import Toast_Swift
open class BaseViewController: UIViewController {

    private var stateManager:PageSateManager?
    public let disposeBag=DisposeBag()
    
    open  override  func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    open func initView() {//需要子类重写
        self.view.backgroundColor=UIColor.white
        stateManager=PageSateManager(rootView: self.view)
        self.setStateManagerView(sateManager: self.stateManager!)
        stateManager?.setUpState()
        stateManager?.setReloadCallback {[weak self] in
            self?.onReload()
        } 
    }
    open func setStateManagerView(sateManager:PageSateManager){//子类重写这个方法去自定义几种View的样式
            //  stateManager?.setLoadView(view: )
    }
    
    open func onReload(){ //子类必须重写这个方法
        //当用户点击erroview的时候会回调这个方法
    } 
    open func showContent(){
        stateManager?.showContent()
    }
    open func showLoading(){
        stateManager?.showLoading()
    }
    open func showEmpty(){
        stateManager?.showEmpty()
    }
    open func showError(){
        stateManager?.showError()
    }
 

    deinit { 
        DDLogVerbose("###############\(String(describing:self.classForCoder.self))##############deinit")
    }
}
