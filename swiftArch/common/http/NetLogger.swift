//
//  NetLogger.swift
//  swiftArch
//
//  Created by czq on 2018/5/24.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import Alamofire
class NetLogger: NSObject {

    static func log(response:DataResponse<String>) {
      
        print("\n")
        if let headers = response.request?.allHTTPHeaderFields {
              print("NetLogger#### header:"+headers.description)
        }
        print("NetLogger#### url:"+response.request!.httpMethod!+": "+response.request!.url!.absoluteString)
        
        if let body = response.request?.httpBody {
            print("NetLogger#### httpBody:"+String(data: body, encoding: String.Encoding.utf8)!)
        }
        
        if let result = response.value {
            print("NetLogger#### result:"+result)
        }
        
        print("\n")
    }
}
