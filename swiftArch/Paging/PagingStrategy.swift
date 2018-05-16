//
//  PagingStrategy.swift
//  swiftArch
//
//  Created by czq on 2018/5/14.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

///分页策略
protocol PagingStrategy{
    func addPage(info:Any)
    func resetPage()
    func getPageInfo()->Any
    func checkFinish(result:NSObject,listSize: Int) -> Bool
}
