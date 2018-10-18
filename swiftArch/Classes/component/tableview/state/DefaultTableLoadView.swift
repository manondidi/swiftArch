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
        gifIV.animationImages=images as? [UIImage]
        gifIV.startAnimating()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
