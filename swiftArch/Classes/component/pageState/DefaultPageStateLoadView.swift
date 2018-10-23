//
//  PageStateLoadView.swift
//  swiftArch
//
//  Created by czq on 2018/5/10.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

open class DefaultPageStateLoadView:UIView, LoadViewProtocol{

    let loadLabel = UILabel()
    let gifIV = UIImageView() 
    lazy var bundle=Bundle(for: self.classForCoder)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame) 
        self.backgroundColor=UIColor.white
        self.addSubview(loadLabel)
        loadLabel.textColor=UIColor.darkGray
        loadLabel.font=UIFont.systemFont(ofSize: 14)
        loadLabel.text="很用力的加载中..."
        loadLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        self.addSubview(gifIV)
        gifIV.snp.makeConstraints { (make) in
            make.bottom.equalTo(loadLabel.snp.top).offset(-20)
            make.centerX.equalTo(loadLabel)
        }  
    }
     
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func startAnimate() {
        if( gifIV.animationImages?.isEmpty ?? true) {
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
        
        gifIV.startAnimating()
    }
    
    open func stopAnimate() {
         gifIV.stopAnimating()
    }

}
