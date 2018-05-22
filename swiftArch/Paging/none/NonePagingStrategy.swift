//
//  NonePagingStrategy.swift
//  swiftArch
//
//  Created by czq on 2018/5/22.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

//列表不分页，当然直接使用PagingStrategy也可以
class NonePagingStrategy: PagingStrategy {
    func addPage(info: Any) {}
    
    func resetPage() {}
    
    func getPageInfo() -> Any {
        return ""
    }
    
    func checkFinish(result: NSObject, listSize: Int) -> Bool {
        return true
    }
    

}
