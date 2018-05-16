//
//  UITableView+Binder.swift
//  swiftArch
//
//  Created by czq on 2018/5/16.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

extension UITableView { 
    func registerCellClass(cellClass:AnyClass,modelClass:AnyClass) {
        self.register(cellClass, forCellReuseIdentifier:String(describing:modelClass.self) )
    }
    func registerCellNib(nib:UINib,modelClass:AnyClass){
        self.register(nib, forCellReuseIdentifier: String(describing:modelClass.self))
    }
}
