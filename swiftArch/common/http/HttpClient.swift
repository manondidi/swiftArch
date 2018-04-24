//
//  HttpClient.swift
//  swiftArch
//
//  Created by czq on 2018/4/20.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import Alamofire
class HttpClient: NSObject {//一个server对应一个httpclient 
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
    public func request(url:String,method:HTTPMethod,pathParams:Dictionary<String,String>=[:],params:Dictionary<String,String>=[:]) -> DataRequest  {
    
    
        var pathUrl=baseUrl!+url;
        for (key, value) in pathParams {
                pathUrl=pathUrl.replacingOccurrences(of:"{\(key)}", with: "\(value)")
         }
        return Alamofire.request(pathUrl, method:method, parameters: params, encoding: URLEncoding.default,headers:self.headers)
    } 

}
