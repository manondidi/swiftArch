//
//  DefaultTableviewLoadView.swift
//  swiftArch
//
//  Created by czq on 2018/5/8.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import SnapKit

public class DefaultTableLoadView: UIView, LoadViewProtocol {

    public lazy var loadLabel = UILabel()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(loadLabel)
        loadLabel.textColor = UIColor.darkGray
        loadLabel.font = UIFont.systemFont(ofSize: 14)
        loadLabel.text = "很用力的加载中..."
        loadLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }




    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open func startAnimate() {

    }

    open func stopAnimate() {
    }


}
