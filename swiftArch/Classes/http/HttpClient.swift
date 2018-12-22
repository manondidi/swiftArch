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
public class HttpClient: NSObject {
    public var baseUrl: String? = nil;
    public var headers: HTTPHeaders? = nil;


    public init(baseUrl: String, headers: HTTPHeaders? = nil) {
        if(self.headers == nil) {
            self.headers = [:]
        }
        if (headers != nil) {
            for (key, value) in headers! {
                self.headers![key] = value
            }
        }
        self.baseUrl = baseUrl;
    }



    public func rxRequest<T:HandyJSON>(url: String, method: HTTPMethod, pathParams: Dictionary<String, String> = [:], params: Dictionary<String, String> = [:])
        -> Observable<T> {
            var pathUrl = baseUrl! + url;
            for (key, value) in pathParams {
                pathUrl = pathUrl.replacingOccurrences(of: "{\(key)}", with: "\(value)")
            }
            #if DEBUG
                return RxAlamofire.requestString(method, pathUrl, parameters: params, encoding: URLEncoding.default, headers: self.headers)
                    .debug()
                    .map({ (response, string) -> T in
                        let jsonStr = string
                        let result: T? = JsonUtil.jsonParse(jsonStr: jsonStr)
                        if let r = result {
                            return r
                        } else {
                            throw JsonError()
                        }
                    })
            #else
                return RxAlamofire.requestString(method, pathUrl, parameters: params, encoding: URLEncoding.default, headers: self.headers)
                    .map({ (response, string) -> T in
                        let jsonStr = string
                        let result: T? = JsonUtil.jsonParse(jsonStr: jsonStr)
                        if let r = result {
                            return r
                        } else {
                            throw JsonError()
                        }
                    })
            #endif



    }

}
