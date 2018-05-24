//
//  PostContent.swift
//  swiftArch
//
//  Created by aron on 2018/5/20.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import HandyJSON

class Feed: NSObject, HandyJSON  {
    
    // 使用KVC添加objc关键字
    @objc var id = 0
    var type = ""
    var payload: PayLoad?
    var user: PostUser?
    var isRetweeted: Bool = false
    
    var specials: [TextSpecial] = [TextSpecial]()
    var textParts: [TextPart] = [TextPart]()
    
    // 属性字符串，用于内容显示
    var showAttributeText: NSAttributedString?
    
    // 属性字符串，用于二次操作
    lazy var attributeText: NSAttributedString = {
        var attributeText = NSMutableAttributedString()
        if let text = self.payload?.post?.content?.text {
            // 用户发送文本
            var composeText = text
            var atUser: PostUser?
            if self.isRetweeted {
                atUser = user
            }
            return self.composeAttrStr(text: composeText, extraText: nil, atUser: atUser)
        } else if let text = self.payload?.record?.reviewContent {
            // 游戏记录
            var composeText = text
//            if self.isRetweeted {
//                if let nickName = user?.nickname {
//                    composeText = "@" + nickName + " " + text
//                }
//            }
            let extraText = (self.payload?.record?.deserve == 1 ? "值得玩，" : "不值得玩，")
            composeText = text
            return self.composeAttrStr(text: composeText, extraText: extraText, atUser: nil)
        }
        return attributeText
    }()
    
    func composeAttrStr(text: String, extraText: String? = nil, atUser: PostUser? = nil) -> NSAttributedString {
        
        var textParts = [TextPart]()
       
        // 遍历entities
        var curOffset = 0
        var entities: [PostTextContentEntity] = [PostTextContentEntity]()
        if self.payload?.post?.content?.entities != nil {
            entities = (self.payload?.post?.content?.entities)!.sorted { $0.offset < $1.offset}
            for entity in entities {
                if entity.offset > curOffset {
                    // 普通文字 curOffset-entity.offset
                    let part = TextPart()
                    part.range = NSRange.init(location: curOffset, length: entity.offset - curOffset)
                    if part.range.location + part.range.length > text.count {
                        break;
                    }
                    part.text = (text as NSString).substring(with: part.range)
                    part.isSpecial = false
                    textParts.append(part)
                }
                
                // 特殊文字 entity.offset-entity.offset+entity.length
                let part = TextPart()
                part.range = NSRange.init(location: entity.offset, length: entity.length)
                if part.range.location + part.range.length > text.count {
                    break;
                }
                part.text = (text as NSString).substring(with: part.range)
                part.isSpecial = true
                textParts.append(part)
                
                curOffset = entity.offset+entity.length
            }
        }
        
        // 最后的普通文字
        if curOffset < text.count {
            let part = TextPart()
            part.range = NSRange.init(location: curOffset, length: text.count - curOffset)
            part.text = (text as NSString).substring(with: part.range)
            part.isSpecial = false
            textParts.append(part)
        }
        
        textParts.sort { $0.range.location < $1.range.location }
        self.textParts = textParts
        
        let specialAttributes = [NSAttributedStringKey.foregroundColor: UIColor.blue, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
        let normalAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
        let extraAttributes = [NSAttributedStringKey.foregroundColor: UIColor.purple, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
        let iconFont = UIFont(name: "iconFont", size: 15)
        let iconAttributes = [NSAttributedStringKey.foregroundColor: UIColor.blue, NSAttributedStringKey.font: iconFont]

        let mAttrStr = NSMutableAttributedString()
        var textSpecials = [TextSpecial]()
        
        // 处理at用户
        if atUser != nil {
            let special = TextSpecial()
            special.text = "@" + (atUser?.nickname)! + " "
            special.specialType = .atUser
            special.range = NSRange.init(location: mAttrStr.length, length: special.text.count)
            
            // 特殊数据
            let specialEntityData = PostTextContentEntity()
            specialEntityData.type = "user"
            let specialData = PostTextContentEntityData()
            specialData.id = (atUser?.id)!
            specialEntityData.data = specialData
            special.specialObj = specialEntityData
            
            textSpecials.append(special)
            
            mAttrStr.append(NSAttributedString(string: special.text, attributes: specialAttributes))
        }
        
        // 处理附加的文字
        if extraText != nil {
//            let special = TextSpecial()
//            special.text = extraText!
//            special.range = NSRange.init(location: mAttrStr.length, length: special.text.count)
//            textSpecials.append(special)
            
            mAttrStr.append(NSAttributedString(string: extraText!, attributes: extraAttributes))
        }
        
        // 处理内容中的特殊内容
        var specialDataIndex = 0
        for textPart in textParts {
            if textPart.isSpecial {
                let attr = NSMutableAttributedString()
                
                // 处理特殊文字中的图标（iconFont）
                if textPart.text.contains("\u{e60e}") {
                    let iconAttr = NSAttributedString(string: "\u{e618}", attributes: (iconAttributes as Any as! [NSAttributedStringKey : Any]))
                    let iconTextAttr = NSAttributedString(string: (textPart.text as NSString).replacingOccurrences(of: "\u{e60e}", with: ""), attributes: specialAttributes)
                    attr.append(iconAttr)
                    attr.append(iconTextAttr)
                } else {
                    attr.append(NSAttributedString(string: textPart.text, attributes: specialAttributes))
                }
                
                let special = TextSpecial()
                special.text = textPart.text
                special.specialObj = entities[specialDataIndex]
                specialDataIndex += 1
                special.range = NSRange.init(location: mAttrStr.length, length: textPart.text.count)
                textSpecials.append(special)
                
                mAttrStr.append(attr)
            } else {
                mAttrStr.append(NSAttributedString(string: textPart.text, attributes: normalAttributes))
            }
        }
        self.specials = textSpecials
        return mAttrStr
    }
    
    required override init() {}
}

class PayLoad: NSObject, HandyJSON {
    var post: Post?
    var game: PostGame?
    var record: PostRecord?
    var article: PostArticle?
    required override init() {}
}

class PostUser: NSObject, HandyJSON {
    var id: Int = 0
    var avatar: String = ""
    var nickname: String = ""
    var followStatus: String = ""
    var isFireflyUser: Bool = false
    
    required override init() {}
}


class Post: NSObject, HandyJSON {
    var id: Int = 0
    var content: PostTextContent?
    var topicId = ""
    var topicTitle = ""
    var replyCount: Int = 0
    var likeCount: Int = 0
    var shareCount: Int = 0
    var retweetCount: Int = 0
    var likeStatus: String = ""
    var createTime: Int = 0
    var images: [PostImage] = [PostImage]()
    var game: PostGame?
    var link: PostLink?
    var type: String = ""
    var retweetFeed: Feed?
    
    required override init() {}
}

class PostTextContent: NSObject, HandyJSON {
    var text: String?
    var entities: [PostTextContentEntity] = [PostTextContentEntity]()
    
    required override init() {}
}

class PostTextContentEntity: NSObject, HandyJSON {
    var data: PostTextContentEntityData?
    var length: Int = 0
    var offset: Int = 0
    var type: String = ""
    
    required override init() {}
}

class PostTextContentEntityData: NSObject, HandyJSON {
    var id: Int = 0
    var name: String = ""
    var hasRecord: Bool = true
    var title: String = ""
    var nickname: String = ""
    
    required override init() {}
}

class PostImage: NSObject, HandyJSON {
    var fileType: String = ""
    var height: Int = 0
    var width: Int = 0
    var url: String = ""
    var thumb: String = ""
    var medium: String = ""

    required override init() {}
}

class PostGame: NSObject, HandyJSON {
    var id: Int = 0
    var name: String = ""
    var icon: String = ""
    var iconType: String = ""
    var platform: String = ""
    var playedPerson: Int = 0
    var deservePercent: String?
    
    required override init() {}
}

class PostRecord: NSObject, HandyJSON {
    var playTimeRange: String = ""
    var playStatus: String = ""
    var reviewContent: String = ""
    var deserve: Int = 0
    var playPlatforms: [String] = [String]()
    var recordCreateTime: Int = 0
    var recordUpdateTime: Int = 0
    var retweetCount: Int = 0
    var likeCount: Int = 0
    var shareCount: Int = 0
    var replyCount: Int = 0
    var likeStatus: String = ""
    
    required override init() {}
}

class PostLink: NSObject, HandyJSON {
    var url: String = ""
    var imageUrl: String = ""
    var title: String = ""
    var type: Int = 0
    
    required override init() {}
}

class PostArticle: NSObject, HandyJSON {
    var id: Int = 0
    var title: String = ""
    var cover: PostImage?
    var summary: String = ""
    var replyCount: Int = 0
    var likeCount: Int = 0
    var shareCount: Int = 0
    var retweetCount: Int = 0
    var likeStatus: String = ""
    var createTime: Int = 0
    var images: [PostImage] = [PostImage]()
    var game: PostGame?
    var isFireflyArticle: Bool = false

    required override init() {}
}

class TextPart: NSObject {
    var isSpecial = false
    var text: String = ""
    var range: NSRange = NSRange()
}

class TextSpecial: NSObject {
    
    enum TextSpecialType {
        case normal
        case atUser
        case deserved
        case game
    }
    
    var specialType: TextSpecialType = .normal
    var specialObj: PostTextContentEntity?
    var text: String = ""
    var range: NSRange = NSRange()
}

