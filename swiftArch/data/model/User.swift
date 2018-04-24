//
//  User.swift
//  swiftArch
//
//  Created by czq on 2018/4/23.
//  Copyright © 2018年 czq. All rights reserved.
//

import Foundation
import HandyJSON
//{"avtar":"","id":1,"sex":0,"userName":"manondidi"}
class User:NSObject,HandyJSON { 
    var avtar:String?
    var id:String?
    var sex:Int?
    var userName:String?
    
    required override init() {}
}
