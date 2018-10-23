//
//  DefaultTableviewLoadView.swift
//  swiftArch
//
//  Created by czq on 2018/5/8.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

public class DefaultTableLoadView: UIView,LoadViewProtocol {
    @IBOutlet weak var gifIV: UIImageView!
    lazy var bundle=Bundle(for: self.classForCoder)
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        let swiftArchBundle = Bundle.init(url: bundle.url(forResource: "swiftArch", withExtension: "bundle")!)
        let images=[UIImage(named: "load0", in:swiftArchBundle,compatibleWith:nil),
                    UIImage(named: "load1", in:swiftArchBundle,compatibleWith:nil),
                    UIImage(named: "load2", in:swiftArchBundle,compatibleWith:nil),
                    UIImage(named: "load3", in:swiftArchBundle,compatibleWith:nil),
                    UIImage(named: "load4", in:swiftArchBundle,compatibleWith:nil),
                    UIImage(named: "load5", in:swiftArchBundle,compatibleWith:nil),
                    UIImage(named: "load6", in:swiftArchBundle,compatibleWith:nil),
                    UIImage(named: "load7", in:swiftArchBundle,compatibleWith:nil),
                    UIImage(named: "load8", in:swiftArchBundle,compatibleWith:nil),
                    UIImage(named: "load9", in:swiftArchBundle,compatibleWith:nil),
                    UIImage(named: "load10", in:swiftArchBundle,compatibleWith:nil)]
        gifIV.animationImages=images as? [UIImage]
         
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func startAnimate() {
        gifIV.startAnimating()
    }
    
    public func stopAnimate() {
         gifIV.stopAnimating()
    }
    
}
