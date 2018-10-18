//
//  GameCollectionHeaderCell.swift
//  swiftArch
//
//  Created by czq on 2018/6/25.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class GameCollectionHeaderCell: UICollectionViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib() 
    }
    @objc var model:GameCollectionHeaderModel?{
        didSet
        {
            labelTitle.text=model?.title
        }
    }
}
