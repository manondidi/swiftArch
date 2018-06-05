//
//  ResponseJsonHandle.swift
//  swiftArch
//
//  Created by czq on 2018/4/23.
//  Copyright © 2018年 czq. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
extension DataRequest {
    
    public func responseModel<T:HandyJSON>( success:@escaping ((T)->()),failure:@escaping ((Int?,String?)->()) )
        
    {
         responseString { (response) in
            NetLogger.log(response: response)
            if(response.result.isFailure){
                failure(response.response?.statusCode,response.error?.localizedDescription)
            }
            let jsonStr = response.value
            let result:T? = JsonUtil.jsonParse(jsonStr: jsonStr!)
            if let r = result{
                success( r)
            }else{
                failure(-2,"json解析失败")
            }
        
        }
    }
    
    /// 调用或者存储缓存 使用该方法来接reqeust肯定会做存储动作
    ///
    /// - Parameters:
    ///   - useCache:是否读缓存,一定会去存
    ///   - success: 成功回调,第一个参数是整个返回值model节点,第二个参数是该回调是否是缓存回调
    ///   - failure: 失败回调
    public func responseModelAndCache<T:HandyJSON>( readCache:Bool,success:@escaping ((T,Bool)->()),failure:@escaping ((Int?,String?)->()) )
        
    {
        responseString { (response) in
            
            NetLogger.log(response: response)
            let cacheManager:CacheManager=CacheManager.shareInstance
            cacheManager.initCacheDB()
            let cacheKey:String? = self.makeKey(request: response.request!)
            
            let cacheJson = cacheManager.getCache(key:cacheKey!)
            if(cacheJson != nil && readCache){
                let cacheResult:T? = JsonUtil.jsonParse(jsonStr: cacheJson!)
                if let r = cacheResult{
                   success( r,true)
                }
            }
            if(response.result.isFailure){
                failure(response.response?.statusCode,response.error?.localizedDescription)
                return;
            }
            
            let jsonStr = response.value
            cacheManager.saveCache(key: cacheKey!, value: jsonStr!)
            if((cacheKey) != nil){
                cacheManager.saveCache(key:cacheKey!, value: jsonStr!)
            }
            let result:T? = JsonUtil.jsonParse(jsonStr: jsonStr!)
            if let r = result{
                success( r,false)
            }else{
                failure(-2,"json解析失败")
            }
            
        }
    }
    
    
    
    
    func makeKey(request:URLRequest) -> String? {
    
        return safeString(request.httpMethod) + "|||"
            + safeString(request.url?.absoluteString) + "|||"
            +  safeString(request.httpBody) + "|||"
            + safeString(request.allHTTPHeaderFields?.description)
        //key具有可读性
        
    }
    
    
  
    
}

func safeString(_ d :Data?) ->String{
    if let data = d , let s = String(data: data, encoding: String.Encoding.utf8) {
        return s
    }
    return ""
}

func safeString(_ s :String?) -> String{
    if s == nil {
        return ""
    }
    return s!
}
