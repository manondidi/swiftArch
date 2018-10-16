//
//  JsonError.swift
//  swiftArch
//
//  Created by czq on 2018/10/16.
//  Copyright © 2018年 czq. All rights reserved.
//

import Foundation
class JsonError: NSError {
    override var localizedDescription: String{
        get{
            return "Json转换失败"
        }
    }
}


 
