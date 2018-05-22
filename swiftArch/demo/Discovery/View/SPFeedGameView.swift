//
//  SPFeedGameView.swift
//  swiftArch
//
//  Created by aron on 2018/5/21.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class SPFeedGameView: SPFeedLinkView {
    func setItem(game item: PostGame) -> () {
        self.iconView.kf.setImage(with: URL(string: item.icon))
        self.titleLabel.text = item.name
    }
}
