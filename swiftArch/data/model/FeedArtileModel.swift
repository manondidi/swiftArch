
//
//  FeedArtileModel.swift
//  swiftArch
//
//  Created by czq on 2018/5/16.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import HandyJSON
class FeedArtileModel: NSObject,HandyJSON {
    @objc var id:String?
    var payload:Payload?
    var user:User?
    override required init( ) { }

    class Payload:NSObject,HandyJSON{
        var article:Article?
        
        override required init( ) { }
    }
    
    class Article:NSObject,HandyJSON{
        var id:String?
        var title:String?
        var cover:Cover?
        var isFireflyUser:Bool?
        var game:Game?
        override required init( ) { }
        
    }
    class Cover:NSObject,HandyJSON{
        var url:String?
        var medium:String?
        var thumb:String?
        override required init( ) { }
       
    }
    class Game:NSObject,HandyJSON{
        var id:String?
        var name:String?
        var icon:String?
        override required init( ) { }
    }
    class User:NSObject,HandyJSON{
        var id:String?
        var avatar:String?
        var nickname:String?
        override required init( ) { }
        
    }
    
    
}


/*
{
    "id": 170950,
    "createTime": 1526367486,
    "payload": {
        "article": {
            "id": 106572,
            "title": "《电竞俱乐部》一款经营类的电竞游戏",
            "cover": {
                "url": "https://i.17173cdn.com/gdthue/YWxqaGBf/snsapp/20180515/yyDclQbmnrjpadn.jpg!a-4-x640.jpg",
                "thumb": "https://i.17173cdn.com/gdthue/YWxqaGBf/snsapp/20180515/yyDclQbmnrjpadn.jpg!a-3-240x.jpg",
                "medium": "https://i.17173cdn.com/gdthue/YWxqaGBf/snsapp/20180515/yyDclQbmnrjpadn.jpg!a-4-x480.jpg"
            },
            "summary": "首先感谢萤火虫提供的激活码。 游戏是一款以电竞为题材的模拟类游戏，包含了PFS和MOBA两大主流电竞比赛项目。 游戏中需要创建俱乐部，签约选手，组建战...",
            "replyCount": 4,
            "likeCount": 5,
            "shareCount": 0,
            "retweetCount": 0,
            "likeStatus": "normal",
            "createTime": 1526367486,
            "game": {
                "id": 10070273,
                "name": "电竞俱乐部",
                "icon": "http://i2.17173cdn.com/9axtlo/YWxqaGBf/gamelib/20180112/vuBdnkbmduwqCkA.jpg!a-3-240x.png",
                "iconType": "normal",
                "recordedUserCount": 31,
                "hasRecord": false
            },
            "isFireflyArticle": true,
            "userId": 127480428,
            "nickname": "西决",
            "isFireflyUser": true,
            "avatar": "https://i.17173cdn.com/gdthue/YWxqaGBf/snsapp/20180417/mktifubmljjagvh.jpg!a-1-120x120.jpg"
        }
    },
    "type": "create-article",
    "user": {
        "avatar": "https://i.17173cdn.com/gdthue/YWxqaGBf/snsapp/20180417/mktifubmljjagvh.jpg!a-1-120x120.jpg",
        "nickname": "西决",
        "id": 127480428,
        "followStatus": "unfollowed",
        "isFireflyUser": true
    }
}
 */
