//
//  GameDateHeader.swift
//  swiftArch
//
//  Created by czq on 2018/5/17.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class GameDateHeader: UITableViewHeaderFooterView {

    var labelDate: UILabel?
    
    @objc var model:GameDateModel?{
        didSet
        {
            labelDate?.text=model?.date
            
        }
    }
 
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor=UIColor.white
        labelDate=UILabel()
        labelDate?.textColor=UIColor.black
        labelDate?.font=UIFont.systemFont(ofSize: 12)
        self.contentView.addSubview(labelDate!)
        labelDate?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(12.0)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(40)
        })
        
        let line=UIView()
        line.backgroundColor = UIColor(red: 243/255.0, green: 243/255.0, blue: 243/255.0, alpha: 1)
        self.contentView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1) 
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
