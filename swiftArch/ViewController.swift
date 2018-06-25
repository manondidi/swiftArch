//
//  ViewController.swift
//  swiftArch
//
//  Created by czq on 2018/4/13.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import Closures
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        
        let btn1=UIButton(type: UIButtonType.roundedRect)
        self.view.addSubview(btn1)
        btn1.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(140)
        }
        btn1.setTitle("tableview组件演示默认样式的styleTable例子", for: UIControlState.normal)
        btn1.onTap {
            [weak self]  in
                self?.navigationController?.pushViewController(TableDemoVC(nibName: "TableDemoVC", bundle: nil), animated: true)
        }
 
        
        
        let btn2=UIButton(type: UIButtonType.roundedRect)
        self.view.addSubview(btn2)
        btn2.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(btn1.snp.bottom).offset(30)
        }
        btn2.titleLabel?.numberOfLines=0
        btn2.setTitle("tableview组件演示自定义样式的styleTable例子\n可自定义headview footview emptyview error loadingcover", for: UIControlState.normal)
        btn2.onTap {
            [weak self]  in
            self?.navigationController?.pushViewController(StyleTableDemoVC(), animated: true)
        }
        
        
        let btn3=UIButton(type: UIButtonType.roundedRect)
        self.view.addSubview(btn3)
        btn3.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(btn2.snp.bottom).offset(30)
        }
        btn3.setTitle("继承自BaseViewcontrollerDemo", for: UIControlState.normal)
        btn3.onTap {
            self.navigationController?.pushViewController(DemoViewController(), animated: true)
        }
        
        
        let btn4=UIButton(type: UIButtonType.roundedRect)
        self.view.addSubview(btn4)
        btn4.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(btn3.snp.bottom).offset(30)
        }
        btn4.titleLabel?.numberOfLines=0
        btn4.setTitle("继承自pagingViewcontrollerDemo(pageNum pageSize分页，\n autolayout行高)", for: UIControlState.normal)
        btn4.onTap {
            [weak self] in
            self?.navigationController?.pushViewController(PaingTalbeDemoViewController(), animated: true)
        }
        
        
        let btn5=UIButton(type: UIButtonType.roundedRect)
        self.view.addSubview(btn5)
        btn5.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(btn4.snp.bottom).offset(30)
        }
        btn5.titleLabel?.numberOfLines=0
        btn5.setTitle("继承自pagingViewcontrollerDemo(offset分页 \nautolayout行高)", for: UIControlState.normal)
        btn5.onTap {
            [weak self] in
            self?.navigationController?.pushViewController(PagingOffsetIdDemoViewController(), animated: true)
        }
        
        
        let btn6=UIButton(type: UIButtonType.roundedRect)
        self.view.addSubview(btn6)
        btn6.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(btn5.snp.bottom).offset(30)
        }
        btn6.titleLabel?.numberOfLines=0
        btn6.setTitle("pagingViewcontrollerDemo手动计算行高的例子", for: UIControlState.normal)
        btn6.onTap {
            [weak self] in
            self?.navigationController?.pushViewController(FeedsDemoViewController(), animated: true)
        }
        
        
        let btn7=UIButton(type: UIButtonType.roundedRect)
        self.view.addSubview(btn7)
        btn7.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(btn6.snp.bottom).offset(30)
        }
        btn7.titleLabel?.numberOfLines=0
        btn7.setTitle("pagingCollectionViewcontrollerDemo的例子", for: UIControlState.normal)
        btn7.onTap {
            [weak self] in
            self?.navigationController?.pushViewController(PagingCollectionDemoViewController(), animated: true)
        }
        
    }

}

