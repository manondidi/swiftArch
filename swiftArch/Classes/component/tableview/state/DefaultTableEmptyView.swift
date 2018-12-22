//
//  DefaultTableEmptyView.swift
//  swiftArch
//
//  Created by czq on 2018/5/8.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import SnapKit

public class DefaultTableEmptyView: UIView {
    public lazy var emptyLabel = UILabel()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(emptyLabel)
        self.backgroundColor = UIColor.white
        emptyLabel.textColor = UIColor.darkGray
        emptyLabel.font = UIFont.systemFont(ofSize: 14)
        emptyLabel.text = "空空如也~"
        emptyLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }


    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
