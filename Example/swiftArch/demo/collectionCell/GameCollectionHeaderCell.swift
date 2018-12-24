//
//  GameCollectionHeaderCell.swift
//  swiftArch
//
//  Created by czq on 2018/6/25.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import swiftArch
class GameCollectionHeaderCell: UICollectionViewCell , CellProtocol {
  

    @IBOutlet weak var labelTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib() 
    }
    
    public func bindModel(_ m: NSObject) {
        let model = m as? GameCollectionHeaderModel
        labelTitle.text=model?.title
    }
}
