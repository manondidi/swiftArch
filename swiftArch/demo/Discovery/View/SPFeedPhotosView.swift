//
//  SPFeedPhotosView.swift
//  swiftArch
//
//  Created by aron on 2018/5/21.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import Closures

class SPFeedPhotosView: UIView {
    
    private var itemWH: CGFloat = 0
    
    private var infoLabel: UILabel = {
        var infoLabel = UILabel()
        infoLabel.backgroundColor = UIColor.black
        infoLabel.textAlignment = NSTextAlignment.center
        infoLabel.layer.cornerRadius = 7.5
        infoLabel.clipsToBounds = true
        infoLabel.layer.masksToBounds = true
        infoLabel.textColor = UIColor.white
        infoLabel.font = UIFont.systemFont(ofSize: 12)
        return infoLabel
    }()
    
    var photos: [PostImage]? {
        didSet {
            // 图片展示
            guard let photoCount = photos?.count else {
                return
            }
            let showPhotoCount = min(photoCount, 3)
            // 创建足够的SPPhotoItemCell
            while showPhotoCount > self.photoImageViews.count {
                let photoCell = SPPhotoItemCell()
                self.addSubview(photoCell)
                self.photoImageViews.append(photoCell)
            }
            // 布局SPPhotoItemCell
            for index in 0...self.photoImageViews.count-1 {
                let photoImageView = self.photoImageViews[index]
                if index < showPhotoCount {
                    let photo: PostImage = photos![index]
                    photoImageView.photo = photo
                    photoImageView.frame = CGRect(x: CGFloat(index) * (SPFeedVM.paddingV + self.itemWH), y: SPFeedVM.paddingV, width: self.itemWH, height: self.itemWH)
                    photoImageView.isHidden = false
                } else {
                    photoImageView.isHidden = true
                }
            }
            // 图片张数信息
            if let count = photos?.count {
                if count > 3 {
                    self.infoLabel.isHidden = false;
                    self.infoLabel.text = "共\((photos?.count)!)张"
                } else {
                    self.infoLabel.isHidden = true;
                }
            }
        }
    }
    
    lazy var photoImageViews = [SPPhotoItemCell]()
    
    // MARK:- 生命周期方法
    init(frame: CGRect, itemWH: CGFloat) {
        self.itemWH = itemWH
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        // SPPhotoItemCell 中的图片按钮点击
        if view is UIButton {
            return view
        }
        return nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.infoLabel.frame = CGRect(x: self.frame.width - 50, y: self.frame.height - (SPFeedVM.paddingV * 2 + 4), width: 50, height: 15)
    }
    
    private func setupUI() -> () {
        self.addSubview(self.infoLabel)
    }
    
    
    // MARK:- SPPhotoItemCell
    class SPPhotoItemCell: UIView {
        
        var photo: PostImage! {
            didSet {
                self.imageView.kf.setImage(with: URL(string: photo.thumb))
                if photo.fileType.count > 0 && photo.fileType == "gif"{
                    self.imageTypeLabel.isHidden = false
                    self.imageTypeLabel.text = photo.fileType
                } else {
                    self.imageTypeLabel.isHidden = true
                    self.imageTypeLabel.text = ""
                }
            }
        }
        
        lazy var imageView: UIImageView = UIImageView()
        lazy var backButton: UIButton = {
            var backButton = UIButton(type: UIButtonType.system)
            backButton.onTap {
                print("Image Tap \(self.photo.url)")
            }
            return backButton
        }()
        
        lazy var imageTypeLabel: UILabel = {
            var imageTypeLabel = UILabel()
            imageTypeLabel.backgroundColor = UIColor.black
            imageTypeLabel.font = UIFont.systemFont(ofSize: 10)
            imageTypeLabel.textColor = UIColor.white
            imageTypeLabel.textAlignment = .center
            imageTypeLabel.layer.cornerRadius = 6
            imageTypeLabel.layer.shouldRasterize = true
            imageTypeLabel.clipsToBounds = true
            return imageTypeLabel
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.addSubview(self.imageView)
            self.addSubview(self.imageTypeLabel)
            self.addSubview(self.backButton)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            self.imageView.frame = self.bounds
            self.imageTypeLabel.frame = CGRect(x: self.frame.width - 4 - 40, y: self.frame.height - 4 - 12, width: 40, height: 12)
            self.backButton.frame = self.bounds
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
}
