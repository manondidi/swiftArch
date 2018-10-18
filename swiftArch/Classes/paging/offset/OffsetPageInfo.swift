//
//  FeedPageInfo.swift
//  swiftArch
//
//  Created by czq on 2018/5/15.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

public class OffsetPageInfo: NSObject {

    public var type="new"
    public var pageSize=20
    public var offsetId:String?=nil
    
    public convenience init(pageSize:Int=20) {
        self.init()
        self.pageSize=pageSize
    }
    
    public func isFirstPage() -> Bool {
        return type=="new"
    }
    
    
}
