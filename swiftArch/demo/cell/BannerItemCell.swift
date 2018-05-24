//
//  BannerItemCell.swift
//  swiftArch
//
//  Created by czq on 2018/5/24.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import FSPagerView
class BannerItemCell: FSPagerViewCell {
    
    let lbArticleTitle=UILabel()
    let lbGameName=UILabel()
    let lbGameDesc=UILabel()
    let ivFirefly=UIImageView()
    let ivMask=UIImageView()
    let gameLine=UIView()
    
    var model:Banner?{
        didSet
        {
            
            self.imageView!.layer.cornerRadius = 10
            self.ivMask.layer.cornerRadius = 10
            self.contentView.layer.cornerRadius = 10
            self.contentView.layer.shadowRadius = 5;
            self.imageView?.kf.setImage(with:URL(string: (model!.cover)!))
            self.imageView?.contentMode = .scaleAspectFill
            self.imageView?.clipsToBounds = true
            if(model!.relatedType=="article"){
                self.setType(isGame: false)
                self.lbArticleTitle.text=model!.title
            }else{
                self.setType(isGame: true)
                self.lbGameName.text=model!.title
                self.lbGameDesc.text=model!.summary
                self.ivFirefly.isHidden = !model!.isFirefly!
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        ivFirefly.image=R.image.icon_firefly()
        ivMask.image=R.image.banner_gray_mask()
        ivMask.contentMode=UIViewContentMode.scaleToFill
        
        lbGameName.text="lbGameName"
        lbGameDesc.text="lbGameDesc"
        lbArticleTitle.text="lbArticleTitle"
        
        lbArticleTitle.textColor=UIColor.white
        lbGameName.textColor=UIColor.white
        lbGameDesc.textColor=UIColor.white
        
        lbArticleTitle.font=UIFont.boldSystemFont(ofSize: 16)
        lbGameName.font=UIFont.boldSystemFont(ofSize: 16)
        lbGameDesc.font=UIFont.systemFont(ofSize: 13)
        gameLine.backgroundColor=UIColor(red: 92/255.0, green: 81/255.0, blue: 203/255.0, alpha: 1)
        
        self.imageView?.addSubview(ivMask)
        self.imageView?.addSubview(gameLine)
        self.imageView?.addSubview(ivFirefly)
        self.imageView?.addSubview(lbGameName)
        self.imageView?.addSubview(lbGameDesc)
        self.imageView?.addSubview(lbArticleTitle)
        
        ivFirefly.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
       
        lbArticleTitle.numberOfLines=2
        lbArticleTitle.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(13)
            make.right.bottom.equalToSuperview().offset(-13)
        }
        
        
        lbGameName.numberOfLines=1
        lbGameName.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-58)
            make.left.equalToSuperview().offset(10)
//            make.right.lessThanOrEqualToSuperview().offset(-10)
        }
        
        gameLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(lbGameName)
            make.height.equalTo(5)
            make.top.equalTo(lbGameName.snp.bottom).offset(-5)
        }
        lbGameDesc.numberOfLines=2
        lbGameDesc.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        ivMask.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setType(isGame:Bool){
        lbArticleTitle.isHidden = isGame
        lbGameName.isHidden = !isGame
        lbGameDesc.isHidden = !isGame
        ivFirefly.isHidden = !isGame
        gameLine.isHidden = !isGame
    
    }
    
    
}
