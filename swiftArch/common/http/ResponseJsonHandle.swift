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
    
    public func responseModel<T:HandyJSON>( success:@escaping ((T)->()),failure:@escaping ((T?,Error?)->()) )
        
    {
         responseString { (response) in
            if(response.result.isFailure){
                failure(nil,response.error!)
            }
            let jsonStr = response.value
            let result:T = T.deserialize(from: jsonStr)!
            
            if(ResultChecker.checkSuccess(result: result as AnyObject)){
                success(result)
            }else{
                failure(result,response.error!)
            }
             
        }
    }
}
