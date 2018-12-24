//
//  BaseTempXibViewController.swift
//  swiftArch_Example
//
//  Created by czq on 2018/12/24.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import swiftArch

class BaseTempXibViewController: BaseViewController {

    @IBOutlet weak var btnCount: UIButton!

    private var count = 1

    override func initView() {
        super.initView()
        btnCount.addTapGesture { [weak self] tap in
            self?.count += 1
            self?.btnCount.setTitle("\(self?.count ?? 0)", for: .normal)
        }

    }


    override func start() {
        super.start()


    }

}
