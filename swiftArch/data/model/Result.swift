//
//  File.swift
//  swiftArch
//
//  Created by czq on 2018/4/23.
//  Copyright © 2018年 czq. All rights reserved.
//

import HandyJSON

class Result<T>:NSObject,HandyJSON{
    
    var status:Int?
    var msg:String?
    var data:T?
   
    required  override init() {}
    
    func checkSuccess( ) -> Bool {
        return status==0
    }
    
     
     
}
