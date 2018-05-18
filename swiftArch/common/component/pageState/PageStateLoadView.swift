//
//  PageStateLoadView.swift
//  swiftArch
//
//  Created by czq on 2018/5/10.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class PageStateLoadView: UIView {

    let loadLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame) 
        self.backgroundColor=UIColor.white
        self.addSubview(loadLabel)
        loadLabel.textColor=UIColor.darkGray
        loadLabel.font=UIFont.systemFont(ofSize: 14)
        loadLabel.text="很用力的加载中..."
        loadLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
    }
    
    override var isHidden: Bool{
        set {
            if newValue {
                
            }else{
                
            }
            super.isHidden=newValue
            
        }
        get {
            return super.isHidden
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
