//
//  FeedPaingStrategy.swift
//  swiftArch
//
//  Created by czq on 2018/5/15.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class FeedPaingStrategy: PagingStrategy {
    var pageInfo:FeedPageInfo=FeedPageInfo()
    var offsetIdKey=""
    
    convenience init(pageSize:Int=20,offsetIdKey:String) {
        self.init()
        self.offsetIdKey=offsetIdKey
        pageInfo.pageSize=pageSize
        pageInfo.type="new"
    }
    
    func addPage(info: Any) {
        pageInfo.type="old"
        let arr=info as?[NSObject]
        let feed=arr?.last 
        pageInfo.offsetId=feed?.value(forKey: offsetIdKey) as? String
    }
    
    func resetPage() {
        
        pageInfo.type="new"
        pageInfo.offsetId=nil
    }
    
    func getPageInfo() -> Any {
         return pageInfo
    }
    
    func checkFinish(result: NSObject, listSize: Int) -> Bool {
        let arr=result as! [Any]
        return arr.count==0
    }
    

}
