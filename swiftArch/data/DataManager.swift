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
    
    var baseUrlDev:String="http://47.98.129.57:8080/info-admin-web/"
    
    var baseUrlTest:String="http://47.98.129.57:8080/info-admin-web/"
    
    var baseUrlRelease:String="http://47.98.129.57:8080/info-admin-web/"
    
    let urlEnv=URL_ENVITORMENT.Dev;//在这切换环境
    
    var baseUrl=""
    
    //var remoteService = RemoteService()
    
    lazy var remoteService :RemoteService = {
        let service = RemoteService()
        return service
    }()
    
    static let shareInstance : DataManager = {
        let instance = DataManager()
        return instance
    }()
  
    private override init( ){
        
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
