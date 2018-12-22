//
//  UICollectionView+Binder.swift
//  swiftArch
//
//  Created by czq on 2018/6/25.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

public extension UICollectionView {

    public func registerCellClass(cellClass: AnyClass, modelClass: AnyClass) {
        self.register(cellClass, forCellWithReuseIdentifier: String(describing: modelClass.self))
    }
    public func registerCellNib(nib: UINib, modelClass: AnyClass) {
        self.register(nib, forCellWithReuseIdentifier: String(describing: modelClass.self))
    }
}
