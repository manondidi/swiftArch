//
//  GameCollectionCell.swift
//  swiftArch
//
//  Created by czq on 2018/6/25.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import swiftArch
class GameCollectionCell: UICollectionViewCell , CellProtocol {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var ivIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }


    public func bindModel(_ m: NSObject) {
        let model = m as? GameModel
        self.labelName.text = model?.title
        self.ivIcon.kf.setImage(with: URL(string: model?.icon ?? ""))
    }
}
