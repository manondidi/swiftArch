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
    
    public func responseModel<T:HandyJSON>( success:@escaping ((T)->()),failure:@escaping ((Int?,Error)->()) )
        
    {
         responseString { (response) in
            if(response.result.isFailure){
                failure(response.response?.statusCode,response.error!)
            }
            let jsonStr = response.value
            let result:T = T.deserialize(from: jsonStr)!
            success( result)
        
        }
    }
    
    public func responseModelAndCache<T:HandyJSON>( success:@escaping ((T,Bool)->()),failure:@escaping ((Int?,Error)->()) )
        
    {
        responseString { (response) in
            
            let cacheManager:CacheManager=CacheManager.shareInstance
            cacheManager.initCacheDB()
            let cacheKey:String? = self.makeKey(request: response.request!)
            
            let cacheJson = cacheManager.getCache(key:cacheKey!)
            if(cacheJson != nil){
                let cacheResult:T = T.deserialize(from: cacheJson)!
                success( cacheResult,true)
            }
            if(response.result.isFailure){
                failure(response.response?.statusCode,response.error!)
                return;
            }
            
            let jsonStr = response.value
            cacheManager.saveCache(key: cacheKey!, value: jsonStr!)
            if((cacheKey) != nil){
                cacheManager.saveCache(key:cacheKey!, value: jsonStr!)
            }
            let result:T = T.deserialize(from: jsonStr)! 
            success( result,false)
            
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
