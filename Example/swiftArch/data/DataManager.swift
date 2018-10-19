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
    
    var baseUrlDevSocail:String="http://47.98.129.57:8080/info-admin-web/"
    var baseUrlTestSocail:String="http://47.98.129.57:8080/info-admin-web/"
    var baseUrlReleaseSocail:String="http://47.98.129.57:8080/info-admin-web/"
    let urlEnvSocail=URL_ENVITORMENT.Dev;//在这切换环境
    var baseUrlSocail=""
    
    
 
    
    lazy var socailAppService :SocialAppService = {
        let service = SocialAppService()
        return service
    }()
    
    static let shareInstance : DataManager = {
        let instance = DataManager()
        return instance
    }()
  
    private override init( ){
        
        switch urlEnvSocail {
        case .Dev:
            self.baseUrlSocail=baseUrlDevSocail
        case .Test:
             self.baseUrlSocail=baseUrlTestSocail
        case .Release:
             self.baseUrlSocail=baseUrlReleaseSocail
        }
        
      
    }
  
    

}
