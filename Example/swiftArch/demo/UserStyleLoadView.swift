//
//  UserStyleLoadView.swift
//  swiftArch
//
//  Created by czq on 2018/5/14.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import swiftArch
class UserStyleLoadView: PageStateLoadView {

    @IBOutlet weak var gifIv: UIImageView!
    override var isHidden: Bool{
        set {
            if newValue {
                if(gifIv != nil){
                    gifIv.stopAnimating()
                }
            }else{
                if(gifIv != nil){
                    gifIv.startAnimating()
                }
            }
            super.isHidden=newValue
            
        }
        get {
            return super.isHidden
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let images=[UIImage(named: "load0"),
                    UIImage(named: "load1"),
                    UIImage(named: "load2"),
                    UIImage(named: "load3"),
                    UIImage(named: "load4"),
                    UIImage(named: "load5"),
                    UIImage(named: "load6"),
                    UIImage(named: "load7"),
                    UIImage(named: "load8"),
                    UIImage(named: "load9"),
                    UIImage(named: "load10")]
        gifIv.animationImages=images as! [UIImage]
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func startAnimate() {
        gifIv.startAnimating()
    }
    
    override func stopAnimate() {
        gifIv.stopAnimating()
    }

}
