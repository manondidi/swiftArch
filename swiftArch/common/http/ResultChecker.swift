//
//  ResultChecker.swift
//  swiftArch
//
//  Created by czq on 2018/4/24.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class ResultChecker: NSObject {
  

    static func checkSuccess (result:AnyObject)->Bool{
         
        if let rs = result as!  Result<Any>{
            return rs.status==0;
        }
      
        return true;
    }
     
    
}
