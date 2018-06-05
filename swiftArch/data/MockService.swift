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

    
    
    func getUser(userId:String,password:String,result:@escaping (User)->()){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            result(self.loadJsonFromFile(fileName: "getUser.json" ,model:User()));
        }
        
    }
    
    // 获取Feeds
    func getFeeds(result: @escaping ((Result<Array<Feed>>)->())) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            result(self.loadJsonFromFile(fileName: "feeds.json" ,model:Result<Array<Feed>>()));
        }
    }
    
    // 获取banner
    func getBanners(result: @escaping ((Result<Array<Banner>>)->())) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            result(self.loadJsonFromFile(fileName: "banner.json" ,model:Result<Array<Banner>>()));
        }
    }
    
    func loadJsonFromFile<T:HandyJSON>(fileName:String,model:T ) -> T {
        
        let jsonPath = Bundle.main.path(forResource: fileName, ofType: "")
        let jsonStr=try?String(contentsOfFile: jsonPath!)
        let result:T = JsonUtil.jsonParse(jsonStr: jsonStr)!
        return result
        
    }
    
}
