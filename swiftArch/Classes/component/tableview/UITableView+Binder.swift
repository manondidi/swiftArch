//
//  UITableView+Binder.swift
//  swiftArch
//
//  Created by czq on 2018/5/16.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

public extension UITableView {


    public func registerCellClass(cellClass: AnyClass, modelClass: AnyClass) {
        self.register(cellClass, forCellReuseIdentifier: String(describing: modelClass.self))
    }
    public func registerCellNib(nib: UINib, modelClass: AnyClass) {
        self.register(nib, forCellReuseIdentifier: String(describing: modelClass.self))
    }

    ///headerClass必须继承UITableViewHeaderFooterView
    public func registerHeaderClass(headerClass: AnyClass, modelClass: AnyClass) {
        self.register(headerClass, forHeaderFooterViewReuseIdentifier: String(describing: modelClass.self))
    }
    public func registerHeaderNib(nib: UINib, modelClass: AnyClass) {
        self.register(nib, forHeaderFooterViewReuseIdentifier: String(describing: modelClass.self))
    }
}
