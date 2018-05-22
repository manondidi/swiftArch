//
//  SPFeedVM.swift
//  swiftArch
//
//  Created by aron on 2018/5/21.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class SPFeedVM: NSObject {
    
    // Feed 富文本内容
    private lazy var measure5LineLabel: UILabel = {
        let measure5LineLabel = UILabel()
        measure5LineLabel.numberOfLines = 5
        return measure5LineLabel
    }()
    
    private lazy var measure6LineLabel: UILabel = {
        let measure6LineLabel = UILabel()
        measure6LineLabel.numberOfLines = 6
        return measure6LineLabel
    }()
    
    // 分页策略器使用到的id
    @objc var id = 0

    static var paddingH:CGFloat = 8
    static var paddingV:CGFloat = 8
    static var avatarWH:CGFloat = 40
    static var imageWH = (UIScreen.main.bounds.width - SPFeedVM.avatarWH - SPFeedVM.paddingH * 5)/3
    static var linkViewH:CGFloat = 50
    static var gameViewH:CGFloat = 50
    static var retweetImageWH = (UIScreen.main.bounds.width - SPFeedVM.avatarWH - SPFeedVM.paddingH * 7)/3
    static var toolBarH:CGFloat = 40
    
    // MARK:- 显示内容
    @objc var feed: Feed? {
        didSet {
            self.setupViewFrame()
            if let id = feed?.id {
                self.id = id
            }
        }
    }
    
    lazy var showTimeStr: String = {
        var showTimeStr = ""
        if let createTimeInternal = (self.feed?.payload?.post?.createTime) {
            var date = Date(timeIntervalSince1970: Double(createTimeInternal))
            showTimeStr = self.postDateFormatter.string(from: date)
        } else if let createTimeInternal = (self.feed?.payload?.record?.recordCreateTime) {
            var date = Date(timeIntervalSince1970: Double(createTimeInternal))
            showTimeStr = self.postDateFormatter.string(from: date)
        }
        return showTimeStr
    }()
    
    lazy var postDateFormatter: DateFormatter = {
        var postDateFormatter = DateFormatter()
        postDateFormatter.dateFormat = " YYYY-MM-dd HH:mm"
        return postDateFormatter
    }()
    
    // MARK:- View 尺寸信息
    var cellHeight: CGFloat = 0
    var originalViewFrame: CGRect = CGRect.zero
    var avatarIconViewFrame: CGRect = CGRect.zero
    var userNameLabelFrame: CGRect = CGRect.zero
    var createTimeLabelFrame: CGRect = CGRect.zero
    var contentTextViewFrame: CGRect = CGRect.zero
    var photosViewFrame: CGRect = CGRect.zero
    var linkViewFrame: CGRect = CGRect.zero
    var gameViewFrame: CGRect = CGRect.zero
    var retweetViewFrame: CGRect = CGRect.zero
    var retweetContentTextViewFrame: CGRect = CGRect.zero
    var retweetPhotosViewFrame: CGRect = CGRect.zero
    var retweetLinkViewFrame: CGRect = CGRect.zero
    var retweetGameViewFrame: CGRect = CGRect.zero
    var toolbarFrame: CGRect = CGRect.zero
    
    /// 设置Cell中View的Frame
    func setupViewFrame() -> () {
        
        let cellW:CGFloat = UIScreen.main.bounds.size.width
        
        // Original Feed
        self.avatarIconViewFrame = CGRect.init(x: SPFeedVM.paddingH, y: SPFeedVM.paddingV, width: SPFeedVM.avatarWH, height: SPFeedVM.avatarWH)
        self.userNameLabelFrame = CGRect.init(x: self.avatarIconViewFrame.maxX + 4, y: self.avatarIconViewFrame.minY, width: cellW - self.avatarIconViewFrame.maxX - SPFeedVM.paddingH, height: 16)
        self.createTimeLabelFrame = CGRect.init(x: self.userNameLabelFrame.minX, y: self.userNameLabelFrame.maxY + 4, width: self.userNameLabelFrame.width, height: 16)
        
        // 内容处理
        let conentW = cellW - self.avatarIconViewFrame.maxX - SPFeedVM.paddingH * 2
        
        // 设置5行的限制
        let fitSize = CGSize(width: conentW, height: CGFloat(MAXFLOAT))
        // 重新生成属性文字，保存在showAttributeText中
        if let feed = self.feed {
            let _ = self.recomposeAttrStr(feed: feed, fitSize: fitSize)
        }
        if let showAttributeText = self.feed?.showAttributeText {
            let contentSize = showAttributeText.boundingRect(with: CGSize(width: conentW, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
            self.contentTextViewFrame = CGRect.init(x: self.createTimeLabelFrame.minX, y: self.createTimeLabelFrame.maxY + 10, width: conentW, height: contentSize.height)
        } else {
            self.contentTextViewFrame = CGRect.init(x: self.createTimeLabelFrame.minX, y: self.createTimeLabelFrame.maxY, width: conentW, height: 0)
        }
        
        var offsetY: CGFloat = self.contentTextViewFrame.maxY
        if let count = self.feed?.payload?.post?.images.count {
            if count > 0 {
                let photoH: CGFloat = SPFeedVM.imageWH + SPFeedVM.paddingV * 2
                self.photosViewFrame = CGRect(x: self.contentTextViewFrame.minX, y: self.contentTextViewFrame.maxY + 4, width: conentW, height: photoH)
                offsetY = self.photosViewFrame.maxY
            }
        }
        
        if let _ = self.feed?.payload?.post?.link {
            self.linkViewFrame = CGRect(x: self.contentTextViewFrame.minX, y: self.contentTextViewFrame.maxY + 4, width: conentW, height: SPFeedVM.linkViewH)
            offsetY = self.linkViewFrame.maxY
        }
        
        if let _ = self.feed?.payload?.game {
            self.gameViewFrame = CGRect(x: self.contentTextViewFrame.minX, y: self.contentTextViewFrame.maxY + 4, width: conentW, height: SPFeedVM.gameViewH)
            offsetY = self.gameViewFrame.maxY
        }
        
        self.originalViewFrame = CGRect(x: 0, y: 0, width: cellW, height: offsetY)
        
        // Retweet Feed
        if let retweetFeed = self.feed?.payload?.post?.retweetFeed {
            let retweetViewW = conentW
            let retweetContentW = retweetViewW - SPFeedVM.paddingH * 2
            
            // 设置5行的限制
            let fitSize = CGSize(width: retweetContentW, height: CGFloat(MAXFLOAT))
            // 重新生成属性文字，保存在showAttributeText中
            let _ = self.recomposeAttrStr(feed: retweetFeed, fitSize: fitSize)
            if let showAttributeText = retweetFeed.showAttributeText {
                let contentSize = showAttributeText.boundingRect(with: CGSize(width: conentW, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
                self.retweetContentTextViewFrame = CGRect.init(x: SPFeedVM.paddingH, y: SPFeedVM.paddingV, width: retweetContentW, height: (contentSize.height))
            } else {
                self.retweetContentTextViewFrame = CGRect.init(x: SPFeedVM.paddingH, y: 0, width: retweetContentW, height: 0)
            }
            
            var innerOffsetY: CGFloat = 0
            if let count = retweetFeed.payload?.post?.images.count {
                if count > 0 {
                    let photoH: CGFloat = SPFeedVM.retweetImageWH + SPFeedVM.paddingV * 2
                    self.retweetPhotosViewFrame = CGRect(x: SPFeedVM.paddingV, y: self.retweetContentTextViewFrame.maxY + 4, width: retweetContentW, height: photoH)
                    innerOffsetY = self.retweetPhotosViewFrame.maxY
                }
            }
            
            if let _ = retweetFeed.payload?.post?.link {
                self.retweetLinkViewFrame = CGRect(x: SPFeedVM.paddingH, y: self.retweetContentTextViewFrame.maxY + 4, width: retweetContentW, height: SPFeedVM.linkViewH)
                innerOffsetY = self.retweetLinkViewFrame.maxY
            }
            
            if let _ = retweetFeed.payload?.game {
                self.retweetGameViewFrame = CGRect(x: SPFeedVM.paddingH, y: self.retweetContentTextViewFrame.maxY + 4, width: retweetContentW, height: SPFeedVM.gameViewH)
                innerOffsetY = self.retweetGameViewFrame.maxY
            }
            
            self.retweetViewFrame = CGRect(x: self.contentTextViewFrame.minX, y: self.originalViewFrame.maxY + 8, width: retweetViewW, height: innerOffsetY + 8)
            offsetY = self.retweetViewFrame.maxY
        }
        
        // Toolbar
        self.toolbarFrame = CGRect(x: 0, y: offsetY, width: cellW, height: SPFeedVM.toolBarH)
        offsetY = self.toolbarFrame.maxY
        
        self.cellHeight = offsetY
    }
    
    
    // MARK:- Helper
    
    /// 判断尺寸是否合适
    private func judgeSizeIsMatch(attributeText: NSAttributedString, fitSize: CGSize) -> (Bool) {
        self.measure5LineLabel.attributedText = attributeText;
        let fit5LineSize = self.measure5LineLabel.sizeThatFits(fitSize)
        
        self.measure6LineLabel.attributedText = attributeText;
        let fit6LineSize = self.measure6LineLabel.sizeThatFits(fitSize)
        
        if abs(fit5LineSize.height - fit6LineSize.height) > 0.1 {
            return false
        }
        return true
    }
    
    /// 重新生成显示的属性字符串
    private func recomposeAttrStr(feed: Feed, fitSize: CGSize) -> NSAttributedString? {
        // 判断是否匹配
        var isMatch = self.judgeSizeIsMatch(attributeText: feed.attributeText, fitSize: fitSize)
        // 添加显示更多的文字
        if isMatch == false {
            // 循环处理文字内容
            if feed.textParts.count > 0 {
                for index in 0...feed.textParts.count-1 {
                    let textPart = feed.textParts[feed.textParts.count - 1 - index]
                    let range = textPart.range
                    
                    let attributeText = feed.attributeText

                    let subToPartLocAttrStr = attributeText.attributedSubstring(from: NSRange(location: 0, length: range.location))
                    isMatch = self.judgeSizeIsMatch(attributeText: subToPartLocAttrStr, fitSize: fitSize)
                    if isMatch {
                        var isFoundFit = false
                        var partLen = textPart.range.length - 4
                        let seeMoreStr = " 查看更多"
                        let seeMoreAttr = NSAttributedString(string: seeMoreStr, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15), NSAttributedStringKey.foregroundColor: UIColor.blue])
                        
                        // 特殊内容和长度不足的内容特别处理
                        if textPart.isSpecial || partLen <= 0 {
                            // 直接去掉当前项目，添加查看更多，计算是否合适
                            let subAttrStr = NSMutableAttributedString()
                            subAttrStr.append(subToPartLocAttrStr)
                            subAttrStr.append(seeMoreAttr)
                            isMatch = self.judgeSizeIsMatch(attributeText: subAttrStr, fitSize: fitSize)
                            if isMatch {
                                // 保存当前的属性字符串
                                isFoundFit = true
                                feed.showAttributeText = subAttrStr
                                
                                // 处理Special
                                let special = TextSpecial()
                                special.text = seeMoreStr
                                special.range = NSRange.init(location: subToPartLocAttrStr.length, length: seeMoreStr.count)
                                self.handleSpecial(feed: feed, lastRange: range, lastSpecial: special)
                                
                                break
                            }
                        } else if partLen > 0 {
                            // 循环进行当前位置所在的内容减去固定位数处理
                            while partLen > 0 {
                                
                                let subAttrStr = NSMutableAttributedString()
                                let partAttrStr = attributeText.attributedSubstring(from: NSRange(location: 0, length: range.location + partLen))
                                subAttrStr.append(partAttrStr)
                                subAttrStr.append(seeMoreAttr)
                                
                                isMatch = self.judgeSizeIsMatch(attributeText: subAttrStr, fitSize: fitSize)
                                if isMatch {
                                    // 保存当前的属性字符串
                                    isFoundFit = true
                                    feed.showAttributeText = subAttrStr
                                    
                                    // 处理Special
                                    let special = TextSpecial()
                                    special.text = seeMoreStr
                                    special.range = NSRange.init(location: partAttrStr.length, length: seeMoreStr.count)
                                    self.handleSpecial(feed: feed, lastRange: range, lastSpecial: special)
                                    
                                    break
                                }
                                
                                partLen -= 4
                            }
                        }
                        
                        // 发现当前位置找到合适，退出for循环
                        if isFoundFit {
                            break;
                        }
                    }
                }
            }
        } else {
            feed.showAttributeText = feed.attributeText
        }
        
        return feed.showAttributeText
    }
    
    // 处理Specials特殊字符串数组
    private func handleSpecial(feed: Feed, lastRange: NSRange, lastSpecial: TextSpecial) {
        for index in 0...feed.specials.count-1 {
            let exitSpecial = feed.specials[feed.specials.count-1 - index]
            if exitSpecial.range.location >= lastRange.location {
                feed.specials.removeLast()
            } else {
                break
            }
        }
        // 添加新的Special
        feed.specials.append(lastSpecial)
    }
}
