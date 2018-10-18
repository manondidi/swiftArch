//
//  EmptyHeader.swift
//  swiftArch
//
//  Created by czq on 2018/5/18.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

public class EmptyHeader: UITableViewHeaderFooterView {
   
    @objc var model:EmptyHeaderModel?
    public var view:UIView?
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        view=UIView()
        self.contentView.backgroundColor=UIColor.clear
        self.contentView.addSubview(view!)
        view?.snp.makeConstraints({ (make) in
            make.left.top.bottom.equalToSuperview()
            make.height.equalTo(1)//不能设成0
        }) 
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
