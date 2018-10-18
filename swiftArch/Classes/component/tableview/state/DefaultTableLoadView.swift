//
//  DefaultTableviewLoadView.swift
//  swiftArch
//
//  Created by czq on 2018/5/8.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

public class DefaultTableLoadView: UIView {
  
    @IBOutlet weak var gifIV: UIImageView!
    
    public override var isHidden: Bool{
        set {
            if newValue {
                if(gifIV != nil){
                    gifIV.stopAnimating()
                }
            }else{
                if(gifIV != nil){
                    gifIV.startAnimating()
                }
            }
            super.isHidden=newValue
           
        }
        get {
            return super.isHidden
        }
    } 
    public override func awakeFromNib() {
        super.awakeFromNib()
//        let images=[UIImage(named: "load0",in:bundle,compatibleWith:nil),
//                    UIImage(named: "load1", in:bundle,compatibleWith:nil),
//                    UIImage(named: "load2", in:bundle,compatibleWith:nil),
//                    UIImage(named: "load3", in:bundle,compatibleWith:nil),
//                    UIImage(named: "load4", in:bundle,compatibleWith:nil),
//                    UIImage(named: "load5", in:bundle,compatibleWith:nil),
//                    UIImage(named: "load6", in:bundle,compatibleWith:nil),
//                    UIImage(named: "load7", in:bundle,compatibleWith:nil),
//                    UIImage(named: "load8", in:bundle,compatibleWith:nil),
//                    UIImage(named: "load9", in:bundle,compatibleWith:nil),
//                    UIImage(named: "load10", in:bundle,compatibleWith:nil)]
//        gifIV.animationImages=images as? [UIImage]
        gifIV.startAnimating()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
