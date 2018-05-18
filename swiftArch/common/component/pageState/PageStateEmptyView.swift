//
//  PageStateEmptyView.swift
//  swiftArch
//
//  Created by czq on 2018/5/10.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class PageStateEmptyView: UIView {
    let emptyLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(emptyLabel)
        self.backgroundColor=UIColor.white
        emptyLabel.textColor=UIColor.darkGray
        emptyLabel.font=UIFont.systemFont(ofSize: 14)
        emptyLabel.text="404,资源不存在"
        emptyLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
