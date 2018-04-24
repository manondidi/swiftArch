//
//  MockService.swift
//  swiftArch
//
//  Created by czq on 2018/4/17.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import HandyJSON

class MockService: DataProtocol {

    func getUser(userId:String,password:String,success:@escaping ((User?)->()),failure:@escaping ((Int?,String?)->()) ){
        
       success(  self.loadJsonFromFile(fileName: "getUser.json" ,model:User()));
    }
    
    
    func loadJsonFromFile<T:HandyJSON>(fileName:String,model:T ) -> T {
        
//        let result:T = T.deserialize(from: jsonStr)!
//        return  result
    }
}
