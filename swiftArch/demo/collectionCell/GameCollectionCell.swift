//
//  GameCollectionCell.swift
//  swiftArch
//
//  Created by czq on 2018/6/25.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class GameCollectionCell: UICollectionViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var ivIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib() 
    }
    @objc var model:GameModel?{
        didSet
        {
            self.labelName.text=model?.title
            self.ivIcon.kf.setImage(with:URL(string: (model?.icon)!))
        }
    }
}
