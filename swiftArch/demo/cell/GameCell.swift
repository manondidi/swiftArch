//
//  GameCell.swift
//  swiftArch
//
//  Created by czq on 2018/5/16.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import Kingfisher
class GameCell: UITableViewCell {

    @IBOutlet weak var lbGameName: UILabel!
    @IBOutlet weak var ivIcon: UIImageView!
    
    @objc var model:GameModel?{
        didSet
        {
            self.lbGameName.text=model?.title
            self.ivIcon.kf.setImage(with:URL(string: (model?.icon)!))
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
