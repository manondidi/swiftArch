//
//  HttpClient.swift
//  swiftArch
//
//  Created by czq on 2018/4/20.
//  Copyright © 2018年 czq. All rights reserved.
//


import RxSwift
import RxAlamofire
import Alamofire
import HandyJSON
class HttpClient: NSObject {
    var baseUrl:String?=nil;
    var headers:HTTPHeaders?=nil;
    
    
    init(baseUrl:String,headers:HTTPHeaders?=nil) {
        if(self.headers==nil){
            self.headers=[:]
        }
        if (headers != nil) { 
            for (key,value) in headers! {
                self.headers![key] = value
            }
        }
        self.baseUrl=baseUrl;
    }
 
    
    
    public func rxRequest<T:HandyJSON>(url:String,method:HTTPMethod,pathParams:Dictionary<String,String>=[:],params:Dictionary<String,String>=[:])
    -> Observable<T>{
        var pathUrl=baseUrl!+url;
        for (key, value) in pathParams {
            pathUrl=pathUrl.replacingOccurrences(of:"{\(key)}", with: "\(value)")
        } 
        
        return RxAlamofire.requestString(method, pathUrl, parameters: params, encoding: URLEncoding.default, headers: self.headers)
            .debug()
            .map({ (response, string) ->T in
                let jsonStr = string
                let result:T? = JsonUtil.jsonParse(jsonStr: jsonStr)
                if let r = result{
                    return r
                }else{
                    throw JsonError()
                }
            })
    }

}
