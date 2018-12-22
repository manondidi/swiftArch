//
//  FeedPaingStrategy.swift
//  swiftArch
//
//  Created by czq on 2018/5/15.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

public class OffsetStrategy: PagingStrategy {
    public var pageInfo:OffsetPageInfo=OffsetPageInfo()
    public var offsetIdKey=""
    
    public convenience init(pageSize:Int=20,offsetIdKey:String) {
        self.init()
        self.offsetIdKey=offsetIdKey
        pageInfo.pageSize=pageSize
        pageInfo.type="new"
    }
    
    public func addPage(info: Any?) {
        pageInfo.type="old"
        let arr=info as?[NSObject]
        let feed=arr?.last 
        pageInfo.offsetId=feed?.value(forKey: offsetIdKey) as? String
    }
    
    public func resetPage() {
        
        pageInfo.type="new"
        pageInfo.offsetId=nil
    }
    
    public func getPageInfo() -> Any? {
        return pageInfo
    }
    
    public func checkFinish(result: Any?, listSize: Int) -> Bool {
        let arr=result as! [Any]
        return arr.count==0
    }
    

}
