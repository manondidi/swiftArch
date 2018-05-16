//
//  NormalPagingStrategy.swift
//  swiftArch
//
//  Created by czq on 2018/5/14.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class NormalPagingStrategy: PagingStrategy { 
    
    var pageInfo:NormalPageInfo=NormalPageInfo()
    
    convenience init(startPageNum:Int=0,pageSize:Int=20) {
        self.init()
        pageInfo.startPageNum=startPageNum
        pageInfo.pageNum=startPageNum;
        pageInfo.pageSize=pageSize
    }
    
    func addPage(info:Any) {
        pageInfo.pageNum+=1
    }
    
    func resetPage() {
        pageInfo.pageNum=pageInfo.startPageNum
    }
    
    func getPageInfo() -> Any {
        return pageInfo
    }
    func checkFinish(result:NSObject,listSize: Int) -> Bool {
        
        pageInfo.totalCount=(result.value(forKey: "totalNum") as! NSNumber).intValue
        return pageInfo.totalCount<=listSize
    }
    
 
    

}
