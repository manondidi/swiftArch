//
//  UserStyleTableEmptyView.swift
//  swiftArch
//
//  Created by czq on 2018/5/9.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import SnapKit
class UserStyleTableEmptyView: UIView {

    let label = UILabel()
    let button = UIButton(type: UIButton.ButtonType.roundedRect)
    
    
    convenience init(){
        self.init(frame: CGRect.zero)
        self.backgroundColor=UIColor.white
        label.text="空空如也~"
        label.textColor=UIColor.gray
        self.addSubview(label)
        button.setTitle("去添加", for: UIControl.State.normal)
        self.addSubview(button) 
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        button.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(20)
        }
        
    }

}
