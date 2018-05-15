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
        pageInfo.pageSize=pageSize
    }
    
    func addPage(info:Any) {
        pageInfo.pageNum+=1
    }
    
    func resetPage(info:Any) {
        pageInfo.pageNum=pageInfo.startPageNum
    }
    
    func getPageInfo() -> Any {
        return pageInfo
    }
    func checkFinish(result:Any,listSize: Int) -> Bool {
        let dic = result as? [String:Any]
        pageInfo.totalCount=dic?["totalCount"] as! Int
        return pageInfo.totalCount>=listSize
    }
    
 
    

}
