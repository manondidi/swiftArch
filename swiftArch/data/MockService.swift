//
//  MockService.swift
//  swiftArch
//
//  Created by czq on 2018/4/17.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import HandyJSON

class MockService    {

    func getUser(userId:String,password:String)->(User){
        
       return  self.loadJsonFromFile(fileName: "getUser.json" ,model:User());
    }
    
    
    func loadJsonFromFile<T:HandyJSON>(fileName:String,model:T ) -> T {
        
        let jsonPath = Bundle.main.path(forResource: "fileName", ofType: "json")
     
        let data = NSData.init(contentsOfFile: jsonPath!)
       
        let result:T = T.deserialize(from: jsonStr)!
        //在此处做延时操作
        return  result
    }
}
