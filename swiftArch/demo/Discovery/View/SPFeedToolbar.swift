//
//  SPFeedToolbar.swift
//  swiftArch
//
//  Created by aron on 2018/5/21.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

/// Feed内容Toolbar
class SPFeedToolbar: UIView {
    
    var feed: Feed? {
        didSet {
            self.setCount(button: self.repostButton, count: feed?.payload?.post?.retweetCount)
            self.setCount(button: self.commentButton, count: feed?.payload?.post?.replyCount)
            self.setCount(button: self.likeButton, count: feed?.payload?.post?.likeCount)
        }
    }
    
    private lazy var buttons = [UIButton]()
    
    private lazy var repostButton: UIButton = {
        var repostButton = self.composeButton(icon: R.image.timeline_icon_retweet())
        return repostButton
    }()
    
    private lazy var commentButton: UIButton = {
        var commentButton = self.composeButton(icon: R.image.timeline_icon_comment())
        return commentButton
    }()
    
    private lazy var likeButton: UIButton = {
        var likeButton = self.composeButton(icon: R.image.timeline_icon_unlike())
        return likeButton
    }()
    
    private func composeButton(icon: UIImage?) -> UIButton {
        let button = UIButton()
        button.setImage(icon, for: UIControlState.normal)
        button.setTitleColor(UIColor.gray, for: UIControlState.normal)
        button.setBackgroundImage(R.image.timeline_card_bottom_background_highlighted(), for: UIControlState.highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.buttons.append(button)
        return button
    }
    
    private func setCount(button: UIButton, count c: Int?) {
        if let count = c {
            if count > 0 {
                button.setTitle("\(count)", for: UIControlState.normal)
            } else {
                button.setTitle("", for: UIControlState.normal)
            }
        }
    }
    
    // MARK:- Override

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.repostButton)
        self.addSubview(self.commentButton)
        self.addSubview(self.likeButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let btnH = self.frame.height
        let btnW = (self.frame.width * 0.8)/CGFloat(self.buttons.count);
        let startX = self.frame.width - (btnW * CGFloat(self.buttons.count))
        for index in 0..<buttons.count {
            let button = buttons[index]
            button.frame = CGRect(x: startX + CGFloat(index) * btnW, y: 0, width: btnW, height: btnH)
        }
    }
}
