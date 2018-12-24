//
//  GameCell.swift
//  swiftArch
//
//  Created by czq on 2018/5/16.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import Kingfisher
import swiftArch
class GameCell: UITableViewCell , CellProtocol {

    @IBOutlet weak var lbGameName: UILabel!
    @IBOutlet weak var ivIcon: UIImageView!


    public func bindModel(_ m: NSObject) {
        let model = m as? GameModel

        self.lbGameName.text = model?.title
        self.ivIcon.kf.setImage(with: URL(string: (model?.icon)!))
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
