//
//  CollectCell.swift
//  swiftArch_Example
//
//  Created by czq on 2018/12/24.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import swiftArch

class CollectCell: UICollectionViewCell  , CellProtocol {

	var model: NSObject?

	public func bindModel(_ m: NSObject) {
        self.model = m as? NSObject
        //TODO: Model数据 设置到 控件
    }

     

}
