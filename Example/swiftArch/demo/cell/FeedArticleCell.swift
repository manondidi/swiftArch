//
//  FeedArticleCell.swift
//  swiftArch
//
//  Created by czq on 2018/5/16.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class FeedArticleCell: UITableViewCell {
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var labelGameName: UILabel!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var labelFlyIcon: UILabel!
    @IBOutlet weak var labelFlyText: UILabel!
    @objc var model:FeedArtileModel?{
        didSet
        {
            self.imgAvatar.layer.cornerRadius=15/2.0
            self.imgAvatar.layer.masksToBounds=true
            self.imgAvatar.kf.setImage(with:URL(string: (model?.user?.avatar)!))
            self.imgCover.kf.setImage(with:URL(string: (model?.payload?.article?.cover?.medium)!))
            self.labelTitle.text=model?.payload?.article?.title
            self.labelUserName.text=model?.user?.nickname
            if(model?.payload?.article?.game != nil){
                self.labelGameName.text=model?.payload?.article?.game?.name
            }else{
                self.labelGameName.text=""
            }
            
            
            let isFirefly=model?.payload?.article?.isFireflyUser ?? false
            
            labelFlyIcon.isHidden = !isFirefly
            labelFlyText.isHidden = !isFirefly
            if(isFirefly ){
                imgCover.snp.updateConstraints { (make) in
                    make.top.equalToSuperview().offset(36.0)
                }
                
            }else{
                imgCover.snp.updateConstraints { (make) in
                    make.top.equalToSuperview().offset(15.0)
                } 
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
    }
    
}
