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
    
    public func responseModelAndCache<T:HandyJSON>( success:@escaping ((T)->()),failure:@escaping ((Int?,Error)->()) )
        
    {
        responseString { (response) in
            if(response.result.isFailure){
                failure(response.response?.statusCode,response.error!)
                return;
            }
            
            let jsonStr = response.value
            let cacheKey:String? = self.makeKey(request: response.request!)
            
            if((cacheKey) != nil){
                self.saveCache(key:cacheKey!, value: jsonStr!)
            }

            let result:T = T.deserialize(from: jsonStr)!
            
            success( result)
            
        }
    }
    
    
    
    
    func makeKey(request:URLRequest) -> String? {        
        return safeString(request.url?.absoluteString) + safeString(request.httpMethod)  +  safeString(request.httpBody) + safeString(request.allHTTPHeaderFields?.description)
    }
    
    
    private func saveCache(key:String,value:String){
        
    }
    private func getCache(key:String)->String{
        
        return ""
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
