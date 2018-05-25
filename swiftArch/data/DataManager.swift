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
    
    
    var baseUrlDevCms:String="http://47.98.129.57:8080/info-admin-web/"
    var baseUrlTestCms:String="http://47.98.129.57:8080/info-admin-web/"
    var baseUrlReleaseCms:String="http://47.98.129.57:8080/info-admin-web/"
    let urlEnvCms=URL_ENVITORMENT.Dev;//在这切换环境
    var baseUrlCms=""
     
    
    lazy var cmsService :CmsService = {
        let service = CmsService()
        return service
    }()
    
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
        
        switch urlEnvCms {
        case .Dev:
            self.baseUrlCms=baseUrlDevCms
        case .Test:
            self.baseUrlCms=baseUrlTestCms
        case .Release:
            self.baseUrlCms=baseUrlReleaseCms
        }
    }
  
    

}
