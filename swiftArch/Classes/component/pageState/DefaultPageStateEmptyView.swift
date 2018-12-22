//
//  PageStateEmptyView.swift
//  swiftArch
//
//  Created by czq on 2018/5/10.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

public class DefaultPageStateEmptyView: UIView {
    public lazy var emptyLabel = UILabel()


    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(emptyLabel)
        self.backgroundColor = UIColor.white
        emptyLabel.textColor = UIColor.darkGray
        emptyLabel.font = UIFont.systemFont(ofSize: 14)
        emptyLabel.text = "404,资源不存在"
        emptyLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
