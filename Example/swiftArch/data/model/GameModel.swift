//
//  GameModel.swift
//  swiftArch
//
//  Created by czq on 2018/5/16.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import HandyJSON
/*
 {
 "createTime": 1526374588,
 "hasRecrod": false,
 "icon": "http://i1.17173cdn.com/9axtlo/YWxqaGBf/gamelib/20180515/aDEuWEbmnrqkrku.png!a-3-240x.png",
 "iconType": "normal",
 "id": 10089387,
 "title": "Octocopter: Double or Squids"
 }
 
 
 */

class GameModel: NSObject,HandyJSON {
    var createTime:Int?
    var hasRecrod:Bool?
    var icon:String?
    var iconType:String?
    var id:String?
    var title:String?
    
    required override init() {
        
    }
}
