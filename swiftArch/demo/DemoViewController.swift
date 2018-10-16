//
//  DemoViewController.swift
//  swiftArch
//
//  Created by czq on 2018/5/14.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import RxSwift

class DemoViewController: BaseViewController {

    
    let disposeBag=DisposeBag()
    var socailAppService:SocialAppService=DataManager.shareInstance.socailAppService
  
    
    override func initView() {
        super.initView()
        let label=UILabel()
        label.text="界面是 demo包下的 DemoViewController\n,一定来看看源码,mock功能的演示"
        label.numberOfLines=0
        label.textColor=UIColor.black
        label.font=UIFont.systemFont(ofSize: 20)
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        UIApplication.shared.keyWindow?.makeToast("这个开小差是我故意的,请点一下空白处", duration: 3)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData(userId: "manondidi", password: "12345566")//错误的账号密码 肯定失败
       
    }
    
    override func onReload() {
        self.showLoading() 
        self.loadMockData(userId: "manondidi", password: "12345566") // 这里走mock 肯定成功
        
    }
    ///在此处定制各种 stateView
    override func setStateManagerView(sateManager: PageSateManager) { 
        sateManager.setLoadView(view: R.nib.userStyleLoadView.firstView(owner: nil)!)
    }
    func loadData(userId:String,password:String){
        self.showLoading()
        socailAppService.rxGetUser(userId: userId, password: password)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (bannerArticleList) in
                if let strongSelf=self{
                    strongSelf.showContent()
                }
                }, onError: {[weak self]  (error) in
                    if let strongSelf=self{
                        strongSelf.showError()
                        strongSelf.view.makeToast("点击空白处")
                    }
            }).disposed(by: disposeBag)
    }
    
    func loadMockData(userId:String,password:String){
        self.showLoading()
        
        socailAppService.rxGetUserMock(userId: userId, password: password)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (bannerArticleList) in
                if let strongSelf=self{
                    strongSelf.showContent()
                    strongSelf.view.makeToast("mock必然成功演示")
                }
                }, onError: {[weak self]  (error) in
                    if let strongSelf=self{
                        strongSelf.showError()
                        strongSelf.view.makeToast(error.localizedDescription)
                    }
            }).disposed(by: disposeBag)
                
        }
        

    
 

}
