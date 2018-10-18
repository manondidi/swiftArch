//
//  NonePagingStrategy.swift
//  swiftArch
//
//  Created by czq on 2018/5/22.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

//列表不分页，当然直接使用PagingStrategy也可以
public class NonePagingStrategy: PagingStrategy {
    public func addPage(info: Any) {}
    
    public func resetPage() {}
    
    public func getPageInfo() -> Any {
        return ""
    }
    
    public func checkFinish(result: NSObject, listSize: Int) -> Bool {
        return true
    }
    
    
}
