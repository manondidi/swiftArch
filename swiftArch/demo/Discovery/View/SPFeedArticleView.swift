//
//  SPFeedArticleView.swift
//  swiftArch
//
//  Created by aron on 2018/5/23.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import Kingfisher

class SPFeedArticleView: UIView {
    
    private lazy var coverImageView: UIImageView = {
        var coverImageView = UIImageView()
        coverImageView.layer.cornerRadius = 5
        coverImageView.layer.masksToBounds = true
        coverImageView.layer.shouldRasterize = true
        return coverImageView
    }()
    
    private lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor.white
        titleLabel.lineBreakMode = .byTruncatingTail
        return titleLabel
    }()
    
    var article: PostArticle? {
        didSet {
            if article != nil {
                if let coverImgUrlStr = article?.cover?.thumb {
                    self.coverImageView.kf.setImage(with: URL(string: coverImgUrlStr))
                }
                self.titleLabel.text = article?.title
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.coverImageView)
        self.addSubview(self.titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.coverImageView.frame = self.bounds
        self.titleLabel.frame = CGRect(x: 8, y: self.frame.height - 20 - 8, width: self.frame.width - 16, height: 20)
    }
    
}
