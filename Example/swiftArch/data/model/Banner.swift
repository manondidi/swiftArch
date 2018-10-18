//
//  Banner.swift
//  swiftArch
//
//  Created by czq on 2018/5/24.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import HandyJSON
class Banner: NSObject, HandyJSON {
    
    var id:String?
    var title:String?
    var summary:String?
    var cover:String?
    var isFirefly:Bool?
    var relatedType:String?
    var relatedId:String?
    var feedId:String?

  override  required init() {
        
    }
}




//{
//    "id": 1,
//    "title": "第一篇编辑精选",
//    "summary": "推荐摘要内容，这是我推荐的理由。",
//    "cover": "http:\/\/i1.cdn.test.17173.com\/gdthue\/YWxqaGBf\/snsapp\/20180313\/CyPAkJbmiotfEqc.jpg",
//    "isFirefly": true,
//    "relatedType": "gameInfo",
//    "relatedId": 10008039,
//    "feedId": null
//}
