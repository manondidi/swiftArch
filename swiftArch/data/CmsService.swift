//
//  CmsService.swift
//  swiftArch
//
//  Created by czq on 2018/5/25.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
//一个service对应一个服务端系统的大业务
class CmsService: NSObject {
 
    let httpClient = HttpClient(baseUrl:DataManager.shareInstance.baseUrlCms,headers:["X-Requested-With":"XMLHttpRequest"])
    let mockService:MockService=MockService();
    
    
    
    
    
    private func getData<T>(result:CMSResult<T>)->T?{
        if self.checkSuccess(result: result) {
            return result.data;
        }
        else{
            return nil
        }
    } 
    private  func checkSuccess(result:NSObject) -> Bool {
        return true==result.value(forKey: "isSuccess") as? Bool
    }
}
