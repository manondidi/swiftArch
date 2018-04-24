//
//  DataManager.swift
//  swiftArch
//
//  Created by czq on 2018/4/17.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

enum URL_ENVITORMENT{
    case Dev
    case Test
    case Release
}

class DataManager: NSObject {
    
    var baseUrlDev:String="http://baidu.com/"
    
    var baseUrlTest:String="http://baidu.com/"
    
    var baseUrlRelease:String="http://baidu.com/"
    
    let urlEnv=URL_ENVITORMENT.Dev;//在这切换环境
    
    var baseUrl=""
    
    var remoteService = RemoteService()
    
    static let shareInstance = DataManager.init()
    
 
    override
    private init( ){
        switch urlEnv {
        case .Dev:
            self.baseUrl=baseUrlDev
        case .Test:
             self.baseUrl=baseUrlTest
        case .Release:
             self.baseUrl=baseUrlRelease
        }
    }
  
    

}
