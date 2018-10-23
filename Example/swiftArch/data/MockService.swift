//
//  MockService.swift
//  swiftArch
//
//  Created by czq on 2018/4/17.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import swiftArch
import RxSwift
import HandyJSON

class MockService{
    
    func rxGetBanners()->Observable<Result<Array<Banner>>> {
        return self.rxLoadJsonFromFile(fileName: "banner.json" ,model:Result<Array<Banner>>())
    }
    
    func rxGetUser(userId:String,password:String)->Observable<User>{
         return self.rxLoadJsonFromFile(fileName: "getUser.json" ,model:User())
    }
    
    
    // 获取Feeds
    func rxGetFeeds()->Observable<Result<Array<Feed>>> {
         return self.rxLoadJsonFromFile(fileName: "feeds.json" ,model:Result<Array<Feed>>())
    }
    
   
    
    func loadJsonFromFile<T:HandyJSON>(fileName:String,model:T ) -> T {
        
        let jsonPath = Bundle.main.path(forResource: fileName, ofType: "")
        let jsonStr=try?String(contentsOfFile: jsonPath!)
        let result:T = JsonUtil.jsonParse(jsonStr: jsonStr)!
        return result
    }
    
    func rxLoadJsonFromFile<T:HandyJSON>(fileName:String,model:T ) ->  Observable<T> {
        return Observable<T>.create { observable in
            let jsonPath = Bundle.main.path(forResource: fileName, ofType: "")
            let jsonStr=try?String(contentsOfFile: jsonPath!)
            let result:T = JsonUtil.jsonParse(jsonStr: jsonStr)!
            observable.onNext(result)
            return Disposables.create { }
        }.delay(2, scheduler: MainScheduler.instance)
    }
    
}
