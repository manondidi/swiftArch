//
//  SPFeedCell.swift
//  swiftArch
//
//  Created by aron on 2018/5/21.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

/// Feed消息列表
class SPFeedCell: UITableViewCell {
    
    var isLastHighlighted = false
    
    /// 原创内容
    private lazy var originalView: UIView = {
        var originalView = UIView()
        return originalView
    }()
    
    // 图标
    private lazy var avatarIconView: UIImageView = {
        let avatarIconView = UIImageView()
        avatarIconView.layer.cornerRadius = 20
        avatarIconView.clipsToBounds = true
        avatarIconView.layer.shouldRasterize = true
        return avatarIconView
    }()
    
    // 用户名称
    private lazy var userNameLabel: UILabel = {
        let userNameLabel = UILabel()
        userNameLabel.font = UIFont.systemFont(ofSize: 15)
        return userNameLabel
    }()
    
    // 发布时间
    private lazy var createTimeLabel: UILabel = {
        let createTimeLabel = UILabel()
        createTimeLabel.font = UIFont.systemFont(ofSize: 12)
        createTimeLabel.textColor = UIColor.gray
        return createTimeLabel
    }()
    
    // Feed 富文本内容
    private lazy var contentTextView: SPFeedTextView = {
        let contentTextView = SPFeedTextView()
        contentTextView.textContainerInset = UIEdgeInsetsMake(0, -5 , 0, -5)
        contentTextView.isEditable = false
        contentTextView.isScrollEnabled = false
        contentTextView.isSelectable = false
        return contentTextView
    }()
    
    // Feed 图片内容
    private lazy var photosView: SPFeedPhotosView = {
        let photosView = SPFeedPhotosView(frame: CGRect.zero, itemWH: SPFeedVM.imageWH)
        return photosView
    }()
    
    // 链接内容
    private lazy var linkView: SPFeedLinkView = {
        let linkView = SPFeedLinkView()
        return linkView
    }()
    
    // 游戏内容
    private lazy var gameView: SPFeedGameView = {
        let gameView = SPFeedGameView()
        return gameView
    }()
    
    // 转发内容
    private lazy var retweetView: UIView = {
        let retweetView = UIView()
        retweetView.isUserInteractionEnabled = true
        return retweetView
    }()
    
    // 转发背景按钮
    private lazy var retweetViewBackBtn:UIButton = {
        var retweetViewBackBtn = UIButton(type: UIButtonType.system)
        retweetViewBackBtn.isUserInteractionEnabled = true
        retweetViewBackBtn.setBackgroundImage(R.image.timeline_card_bottom_background_highlighted(), for:.highlighted)
        retweetViewBackBtn.setBackgroundImage(R.image.timeline_card_bottom_background_normal(), for: UIControlState.normal)
        retweetViewBackBtn.onTap {
            
        }
        return retweetViewBackBtn
    }()
    
    // 转发Feed富文本内容
    private lazy var retweetContentTextView: SPFeedTextView = {
        let retweetContentTextView = SPFeedTextView()
        retweetContentTextView.textContainerInset = UIEdgeInsetsMake(0, -5 , 0, -5)
        retweetContentTextView.isEditable = false
        retweetContentTextView.isScrollEnabled = false
        retweetContentTextView.isSelectable = false
//        retweetContentTextView.isUserInteractionEnabled = false
        retweetContentTextView.backgroundColor = UIColor.clear
        return retweetContentTextView
    }()
    
    // 转发 Feed 图片内容
    private lazy var retweetPhotosView: SPFeedPhotosView = {
        let retweetPhotosView = SPFeedPhotosView(frame: CGRect.zero, itemWH: SPFeedVM.retweetImageWH)
        return retweetPhotosView
    }()
    
    // 转发链接内容
    private lazy var retweetLinkView: SPFeedLinkView = {
        let retweetLinkView = SPFeedLinkView()
        return retweetLinkView
    }()
    
    // 转发游戏内容
    private lazy var retweetGameView: SPFeedGameView = {
        let retweetGameView = SPFeedGameView()
        return retweetGameView
    }()
    
    private lazy var toolbar: SPFeedToolbar = {
        var toolbar = SPFeedToolbar()
        return toolbar
    }()
    
    // MARK:- 生命周期方法
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.setupOriginalFeed()
        self.setupRetweetFeed()
        self.setupToolbar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
//        print("setHighlighted===\(highlighted)")
        let highlightedColor = UIColor.cyan
        let normalColor = UIColor.white
        let handleViewArr = [self.contentView, self.contentTextView, self.toolbar, self.originalView, self.retweetView]
        let setViewColor = {
            (highlighted: Bool) in
            self.isLastHighlighted = highlighted
            UIView.animate(withDuration: 0.2, animations: {
                if highlighted {
                    for view in handleViewArr {
                        view.backgroundColor = highlightedColor
                    }
                } else {
                    for view in handleViewArr {
                        view.backgroundColor = normalColor
                    }
                }
            }, completion: { (complete: Bool) in
                if highlighted {
                    self.isLastHighlighted = false
                }else {
                    self.isLastHighlighted = true
                }
            })
        }
        setViewColor(highlighted)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.userNameLabel.text = nil
        self.createTimeLabel.text = nil
        self.contentTextView.attributedText = nil
        self.linkView.isHidden = true
        self.gameView.isHidden = true
        self.photosView.isHidden = true
    }
    
    // MARK:- setup
    
    private func setupOriginalFeed() {
        self.contentView.addSubview(self.originalView)
        self.originalView.addSubview(self.avatarIconView)
        self.originalView.addSubview(self.userNameLabel)
        self.originalView.addSubview(self.createTimeLabel)
        self.originalView.addSubview(self.contentTextView)
        self.originalView.addSubview(self.photosView)
        self.originalView.addSubview(self.gameView)
        self.originalView.addSubview(self.linkView)
    }
    
    private func setupRetweetFeed() {
        self.contentView.addSubview(self.retweetView)
        self.retweetView.addSubview(self.retweetViewBackBtn)
        self.retweetView.addSubview(self.retweetContentTextView)
        self.retweetView.addSubview(self.retweetPhotosView)
        self.retweetView.addSubview(self.retweetGameView)
        self.retweetView.addSubview(self.retweetLinkView)
    }
    
    private func setupToolbar() {
        self.contentView.addSubview(self.toolbar)
    }
    
    
    // MARK:- Public
    
    // KVO 设置数据模型
    @objc var model:SPFeedVM? {
        didSet
        {
            self.originalView.frame = (model?.originalViewFrame)!
            
            self.userNameLabel.frame = (model?.userNameLabelFrame)!
            self.userNameLabel.text = model?.feed?.user?.nickname
            
            self.createTimeLabel.frame = (model?.createTimeLabelFrame)!
            self.createTimeLabel.text = model?.showTimeStr
            
            self.avatarIconView.frame = (model?.avatarIconViewFrame)!
            if let avatar = model?.feed?.user?.avatar {
                self.avatarIconView.kf.setImage(with: URL(string: avatar))
            } else {
                self.avatarIconView.image = UIImage(named: "")
            }
            
            self.contentTextView.frame = (model?.contentTextViewFrame)!
            self.contentTextView.attributedText = model?.feed?.showAttributeText
            self.contentTextView.specials = (model?.feed?.specials)!
            
            // 设置图片
            if let images = model?.feed?.payload?.post?.images {
                if images.count > 0 {
                    self.photosView.frame = (model?.photosViewFrame)!
                    self.photosView.photos = model?.feed?.payload?.post?.images
                    self.photosView.isHidden = false
                } else {
                    self.photosView.isHidden = true
                }
            }
            
            // 链接内容
            if let link = model?.feed?.payload?.post?.link {
                self.linkView.frame = (model?.linkViewFrame)!
                self.linkView.setItem(link: link)
                self.linkView.isHidden = false
            } else {
                self.linkView.isHidden = true
            }
            
            // 游戏内容
            if let game = model?.feed?.payload?.game {
                self.gameView.frame = (model?.gameViewFrame)!
                self.gameView.setItem(game: game)
                self.gameView.isHidden = false
            } else {
                self.gameView.isHidden = true
            }
            
            // 处理转发内容
            if let retweedFeed = model?.feed?.payload?.post?.retweetFeed {
                
                self.retweetContentTextView.frame = (model?.retweetContentTextViewFrame)!
                self.retweetContentTextView.attributedText = retweedFeed.showAttributeText
                self.retweetContentTextView.specials = retweedFeed.specials
                
                // 设置图片
                if let images = retweedFeed.payload?.post?.images {
                    if images.count > 0 {
                        self.retweetPhotosView.frame = (model?.retweetPhotosViewFrame)!
                        self.retweetPhotosView.photos = retweedFeed.payload?.post?.images
                        self.retweetPhotosView.isHidden = false
                    } else {
                        self.retweetPhotosView.isHidden = true
                    }
                }
                
                // 链接内容
                if let link = retweedFeed.payload?.post?.link {
                    self.retweetLinkView.frame = (model?.retweetLinkViewFrame)!
                    self.retweetLinkView.setItem(link: link)
                    self.retweetLinkView.isHidden = false
                } else {
                    self.retweetLinkView.isHidden = true
                }
                
                // 游戏内容
                if let game = retweedFeed.payload?.game {
                    self.retweetGameView.frame = (model?.retweetGameViewFrame)!
                    self.retweetGameView.setItem(game: game)
                    self.retweetGameView.isHidden = false
                } else {
                    self.retweetGameView.isHidden = true
                }
                
                self.retweetView.frame = (model?.retweetViewFrame)!
                self.retweetViewBackBtn.frame = self.retweetView.bounds
                self.retweetView.isHidden = false
            } else {
                self.retweetView.isHidden = true
            }
            
            // Toolbar
            self.toolbar.frame = (model?.toolbarFrame)!
            self.toolbar.feed = model?.feed
        }
    }
    
}
