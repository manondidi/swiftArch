//
//  CMSResult.swift
//  swiftArch
//
//  Created by czq on 2018/4/24.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import HandyJSON
class CMSResult<T>:HandyJSON,ResultProtocol{
    
    var code:Int?
    var msg:String?
    var data:T?
    
    required   init() {}
    
    
}
