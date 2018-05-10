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
        btn1.setTitle("默认样式的styleTable例子", for: UIControlState.normal)
        btn1.onTap {
            self.navigationController?.pushViewController(TableDemoVC(nibName: "TableDemoVC", bundle: nil), animated: true)
        }
 
        
        
        let btn2=UIButton(type: UIButtonType.roundedRect)
        self.view.addSubview(btn2)
        btn2.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(btn1.snp.bottom).offset(30)
        }
        btn2.setTitle("自定义样式的styleTable例子", for: UIControlState.normal)
        btn2.onTap {
            self.navigationController?.pushViewController(StyleTableDemoVC(), animated: true)
        }
    }

}

