//
//  JsonUtil.swift
//  swiftArch
//
//  Created by czq on 2018/6/5.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import HandyJSON
class JsonUtil: NSObject {
    
    public static func jsonParse<T:HandyJSON>(jsonStr:String?)->T?{
        let result:T? = T.deserialize(from: jsonStr)
        return result
    }
     
    public static func toJsonString(any:Any)->String{
        
        //首先判断能不能转换
        guard JSONSerialization.isValidJSONObject(any) else {
            return ""
        }
        let jsonData = try? JSONSerialization.data(withJSONObject: any, options: [])
        if let jsonData = jsonData {
            let str = String(data: jsonData, encoding: String.Encoding.utf8)
            return str ?? ""
        }else {
            return ""
        }
    }
    
    

}
