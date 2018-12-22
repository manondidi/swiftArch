//
//  DefaultTableErrorView.swift
//  swiftArch
//
//  Created by czq on 2018/5/8.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import SnapKit

public class DefaultTableErrorView: UIView {

    public lazy var errorLabel = UILabel()


    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(errorLabel)
        errorLabel.textColor = UIColor.darkGray
        errorLabel.font = UIFont.systemFont(ofSize: 14)
        errorLabel.text = "服务器开小差"
        errorLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



}
