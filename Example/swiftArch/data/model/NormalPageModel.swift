//
//  NormalPageModel.swift
//  swiftArch
//
//  Created by czq on 2018/5/16.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import HandyJSON
class NormalPageModel<T:HandyJSON>: NSObject,HandyJSON {
    var pageNo:Int?
    var pageSize:Int?
    @objc var totalNum:NSNumber?//因为要用kvc所以只能使用nsnumber
    var listData:Array<T>?
    
    required  override init() {}
}
