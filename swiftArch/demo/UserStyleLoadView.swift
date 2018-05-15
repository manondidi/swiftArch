//
//  UserStyleLoadView.swift
//  swiftArch
//
//  Created by czq on 2018/5/14.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class UserStyleLoadView: UIView {

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
        gifIv.animationImages=[R.image.load0(),
                               R.image.load1(),
                               R.image.load2(),
                               R.image.load3(),
                               R.image.load4(),
                               R.image.load5(),
                               R.image.load6(),
                               R.image.load7(),
                               R.image.load8(),
                               R.image.load9(),
                               R.image.load10()] as? [UIImage]
        gifIv.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
