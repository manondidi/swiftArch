//
//  FeedPageInfo.swift
//  swiftArch
//
//  Created by czq on 2018/5/15.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class FeedPageInfo: NSObject {

    var type="new"
    var pageSize=20
    var offsetId:String?=nil
    
    convenience init(pageSize:Int=20) {
        self.init()
        self.pageSize=pageSize
    }
    
    func isFirstPage() -> Bool { 
        return type=="new"
    }
    
    
}
