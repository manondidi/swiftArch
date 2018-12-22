//
//  NormalPageInfo.swift
//  swiftArch
//
//  Created by czq on 2018/5/15.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

public class NormalPageInfo: NSObject {
    public var pageSize: Int = 0
    public var pageNum: Int = 0
    public var totalCount: Int = 0
    public var startPageNum: Int = 0//从多少开始计算的 一般分页要么是0 要么是1

    public func isFirstPage() -> Bool {
        return startPageNum == pageNum
    }
}
