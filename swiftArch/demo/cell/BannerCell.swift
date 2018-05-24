//
//  BannerCell.swift
//  swiftArch
//
//  Created by czq on 2018/5/24.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import FSPagerView
class BannerCell: UITableViewCell,FSPagerViewDataSource,FSPagerViewDelegate {
    
    var pagerView:FSPagerView?
    
    @objc var model:BannersVM?{
        didSet
        {
            pagerView?.reloadData()
        }
    }
    
    
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return model?.banners?.count ?? 0
    }
    
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let banner:Banner=(model?.banners![index])!
        let cell:BannerItemCell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index) as! BannerItemCell 
        cell.model=banner
         
        return cell
    }

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let ivIconRecommond=UIImageView()
        ivIconRecommond.image=R.image.ic_recommond()
        self.contentView.addSubview(ivIconRecommond)
        ivIconRecommond.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(13)
        }
        
        let labelRecommond=UILabel()
        labelRecommond.text="推荐"
        labelRecommond.font=UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(labelRecommond)
        labelRecommond.snp.makeConstraints { (make) in
            make.left.equalTo(ivIconRecommond.snp.right).offset(4)
            make.centerY.equalTo(ivIconRecommond)
        }
        
        pagerView = FSPagerView()
        pagerView?.interitemSpacing = 16
        pagerView?.itemSize = CGSize(width: 340, height: 140)
        pagerView?.transformer = FSPagerViewTransformer(type: .linear)
        pagerView?.dataSource = self
        pagerView?.delegate = self
        pagerView?.register(BannerItemCell.self, forCellWithReuseIdentifier: "cell")
        self.contentView.addSubview(pagerView!)
        self.pagerView?.snp.makeConstraints({ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(150.0)
            make.top.equalTo(ivIconRecommond.snp.bottom).offset(13)
            
        })
        
        let line=UIView()
        line.backgroundColor=UIColor(red: 243/255.0, green: 243/255.0, blue: 243/255.0, alpha: 1)
        self.contentView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo((self.pagerView?.snp.bottom)!).offset(24)
            make.height.equalTo(8)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
