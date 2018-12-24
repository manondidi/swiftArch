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

    private var stateManager: PageStateManager?
    public let disposeBag = DisposeBag()
 

    open override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        start()
    }

    open func initView() { //需要子类重写
        self.view.backgroundColor = UIColor.white
        stateManager = PageStateManager(rootView: self.view)
        createStateManagerView(stateManager: self.stateManager!)
        stateManager?.setUpState()
        stateManager?.setReloadCallback { [weak self] in
            self?.start()
        }
    }
 
    open func start() {
        
    }

    open func createStateManagerView(stateManager: PageStateManager) { //子类重写这个方法去自定义几种View的样式
        
    }
    open func showContent() {
        stateManager?.showContent()
    }
    open func showLoading() {
        stateManager?.showLoading()
    }
    open func showEmpty() {
        stateManager?.showEmpty()
    }
    open func showError(_ error: Error? = nil) {
        stateManager?.showError()
        DDLogError(error?.localizedDescription ?? "")
    }



}
