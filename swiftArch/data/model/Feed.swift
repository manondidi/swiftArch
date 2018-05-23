//
//  PostContent.swift
//  swiftArch
//
//  Created by aron on 2018/5/20.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import HandyJSON
import RegexKitLite_NoWarning

class Feed: NSObject, HandyJSON  {
    
    // 使用KVC添加objc关键字Ô
    @objc var id = 0
    var type = ""
    var payload: PayLoad?
    var user: PostUser?
    
    var specials: [TextSpecial] = [TextSpecial]()
    var textParts: [TextPart] = [TextPart]()

    // 属性字符串，用于内容显示
    var showAttributeText: NSAttributedString?
    
    // 属性字符串，用于二次操作
    lazy var attributeText: NSAttributedString = {
        var attributeText = NSMutableAttributedString()
        if let text = self.payload?.post?.content?.text {
            // 普通文本
            return self.composeAttrStr(text: text)
        } else if let text = self.payload?.record?.reviewContent {
            // 游戏文本
            return self.composeAttrStr(text: text)
        }
        return attributeText
    }()
    
    func composeAttrStr(text: String) -> NSAttributedString {
        // 表情的规则
        let emotionPattern = "\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
        // @的规则
        let atPattern = "@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
        // #话题#的规则
        let topicPattern = "#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
        // url链接的规则
        let urlPattern = "\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
        let pattern = "\(emotionPattern)|\(atPattern)|\(topicPattern)|\(urlPattern)"
        
        var textParts = [TextPart]()
        
        (text as! NSString).enumerateStringsMatched(byRegex: pattern) { (captureCount: Int, capString: UnsafePointer<NSString?>?, capRange: UnsafePointer<NSRange>?, stop: UnsafeMutablePointer<ObjCBool>?) in
            let captureString = capString?.pointee as! String
            let captureRange = capRange?.pointee as! NSRange
            
            let part = TextPart()
            part.text = captureString
            part.isSpecial = true
            part.range = captureRange
            textParts.append(part)
        }
        
        (text as! NSString).enumerateStrings(separatedByRegex: pattern) { (captureCount: Int, capString: UnsafePointer<NSString?>?, capRange: UnsafePointer<NSRange>?, stop: UnsafeMutablePointer<ObjCBool>?) in
            let captureString = capString?.pointee as! String
            let captureRange = capRange?.pointee as! NSRange
            
            let part = TextPart()
            part.text = captureString
            part.isSpecial = false
            part.range = captureRange
            textParts.append(part)
        }
        
        textParts.sort { (p1: TextPart, p2: TextPart) -> Bool in
            return p1.range.location < p2.range.location
        }
        self.textParts = textParts
        
        let specialAttributes = [NSAttributedStringKey.foregroundColor: UIColor.blue, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
        let normalAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]

        let mAttrStr = NSMutableAttributedString()
        var textSpecials = [TextSpecial]()
        for textPart in textParts {
            if textPart.isSpecial {
                let attr = NSAttributedString(string: textPart.text, attributes: specialAttributes)
                
                let special = TextSpecial()
                special.text = textPart.text
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
    required override init() {}
}

class PostUser: NSObject, HandyJSON {
    var id:Int = 0
    var avatar: String = ""
    var nickname: String = ""
    var followStatus: String = ""
    var isFireflyUser:Bool = false
    
    required override init() {}
}


class Post: NSObject, HandyJSON {
    var id:Int = 0
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
    var length:Int = 0
    var offset:Int = 0
    var type: String = ""
    
    required override init() {}
}

class PostTextContentEntityData: NSObject, HandyJSON {
    var id:Int = 0
    var name:String = ""
    var hasRecord: Bool = true
    
    required override init() {}
}

class PostImage: NSObject, HandyJSON {
    var fileType: String = ""
    var thumb: String = ""
    var height: Int = 0
    var width: Int = 0
    var url: String = ""
    
    required override init() {}
}

class PostGame: NSObject, HandyJSON {
    var id:Int = 0
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

class TextPart: NSObject {
    var isSpecial = false
    var text: String = ""
    var range: NSRange = NSRange()
}

class TextSpecial: NSObject {
    var text: String = ""
    var range: NSRange = NSRange()
}

