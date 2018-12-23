//
//  ViewController.swift
//  swiftArch
//
//  Created by czq on 10/17/2018.
//  Copyright (c) 2018 czq. All rights reserved.
//

import UIKit
import swiftArch
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        
        
        
        let btn3=UIButton(type: UIButton.ButtonType.roundedRect)
        self.view.addSubview(btn3)
        btn3.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(140)
        }
        btn3.setTitle("BaseViewcontroller", for: UIControl.State.normal)
        btn3.onTap {
            self.navigationController?.pushViewController(DemoViewController(), animated: true)
        }
        
        
        let btn4=UIButton(type: UIButton.ButtonType.roundedRect)
        self.view.addSubview(btn4)
        btn4.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(btn3.snp.bottom).offset(30)
        }
        btn4.titleLabel?.numberOfLines=0
        btn4.setTitle("PaingTalbeDemoViewController gameList,section方案 pagenum分页策略", for: UIControl.State.normal)
        btn4.onTap {
            [weak self] in
            self?.navigationController?.pushViewController(PaingTalbeDemoViewController(), animated: true)
        }
        
        
        let btn5=UIButton(type: UIButton.ButtonType.roundedRect)
        self.view.addSubview(btn5)
        btn5.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(btn4.snp.bottom).offset(30)
        }
        btn5.titleLabel?.numberOfLines=0
        btn5.setTitle("PagingOffsetIdDemoViewController banner offset分页策略", for: UIControl.State.normal)
        btn5.onTap {
            [weak self] in
            self?.navigationController?.pushViewController(PagingOffsetIdDemoViewController(), animated: true)
        }
        
        
        let btn6=UIButton(type: UIButton.ButtonType.roundedRect)
        self.view.addSubview(btn6)
        btn6.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(btn5.snp.bottom).offset(30)
        }
        btn6.titleLabel?.numberOfLines=0
        btn6.setTitle("FeedsDemoViewController手动计算行高 feed流", for: UIControl.State.normal)
        btn6.onTap {
            [weak self] in
            self?.navigationController?.pushViewController(FeedsDemoViewController(), animated: true)
        }
        
        
        let btn7=UIButton(type: UIButton.ButtonType.roundedRect)
        self.view.addSubview(btn7)
        btn7.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(btn6.snp.bottom).offset(30)
        }
        btn7.titleLabel?.numberOfLines=0
        btn7.setTitle("PagingCollectionDemoViewController collectionView pagenum分页策略", for: UIControl.State.normal)
        btn7.onTap {
            [weak self] in
            self?.navigationController?.pushViewController(PagingCollectionDemoViewController(), animated: true)
        }
        
    }


}

