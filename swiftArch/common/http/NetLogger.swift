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
      
        debugPrint("\n")
        if let headers = response.request?.allHTTPHeaderFields {
              print("NetLogger#### header:"+headers.description)
        }
        debugPrint("NetLogger#### url:"+response.request!.httpMethod!+": "+response.request!.url!.absoluteString)
        
        if let body = response.request?.httpBody {
            debugPrint("NetLogger#### httpBody:"+String(data: body, encoding: String.Encoding.utf8)!)
        }
        
        if let result = response.value {
            debugPrint("NetLogger#### result:"+result)
        }
        
        debugPrint("\n")
    }
}
