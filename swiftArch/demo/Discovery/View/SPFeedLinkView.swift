//
//  SPFeedLinkView.swift
//  swiftArch
//
//  Created by aron on 2018/5/21.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import Kingfisher

class SPFeedLinkView: UIView {
    
    lazy var backButton: UIButton = {
        
        var backButton = UIButton(type: UIButtonType.system)
        backButton.layer.shouldRasterize = true
        backButton.layer.cornerRadius = 4
        backButton.layer.masksToBounds = true
        backButton.clipsToBounds = true
        backButton.isUserInteractionEnabled = true
        backButton.setBackgroundImage(R.image.timeline_card_bottom_background_highlighted(), for: .highlighted)
        backButton.setBackgroundImage(R.image.timeline_card_bottom_background_normal(), for: UIControlState.normal)
        backButton.onTap {
//            print("Tap")
        }
        return backButton
    }()
    
    lazy var iconView: UIImageView = {
        var iconView = UIImageView()
        iconView.layer.shouldRasterize = true
        iconView.layer.cornerRadius = 4
        iconView.layer.masksToBounds = true
        iconView.clipsToBounds = true
        return iconView
    }()
    
    lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backButton.frame = self.bounds
        self.iconView.frame = CGRect(x: 5, y: 5, width: 40, height: 40)
        self.titleLabel.frame = CGRect(x: self.iconView.frame.maxX + 8, y: 0, width: self.frame.width - self.iconView.frame.maxX - 16, height: self.frame.height)
    }
    
    func setupUI() -> () {
        self.isUserInteractionEnabled = true
        self.addSubview(self.backButton)
        self.addSubview(self.iconView)
        self.addSubview(self.titleLabel)
    }
    
    // MARK:- Public
    
    func setItem(link item: PostLink) -> () {
        self.iconView.kf.setImage(with: URL(string: item.imageUrl))
        self.titleLabel.text = item.title
    }
    
}
