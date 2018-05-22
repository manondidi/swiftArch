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

class SPFeedPhotosView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var itemWH: CGFloat = 0

    private lazy var photoCollectionView: UICollectionView? = {
        [weak self] in
        
        guard let weakSelf = self else {
            return nil
        }
        
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self?.itemWH)!, height: (self?.itemWH)!)
        layout.minimumLineSpacing = SPFeedVM.paddingV
        layout.minimumInteritemSpacing = SPFeedVM.paddingH
        
        var imageCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        imageCollectionView.backgroundColor = UIColor.clear
        imageCollectionView.delegate = weakSelf
        imageCollectionView.dataSource = weakSelf
        imageCollectionView.register(SPPhotoItemCell.self, forCellWithReuseIdentifier: String(describing: SPPhotoItemCell.self))
        return imageCollectionView
    }()
    
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
            self.photoCollectionView?.reloadData()
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
    
    // MARK:- 生命周期方法
    init(frame: CGRect, itemWH: CGFloat) {
        self.itemWH = itemWH
        super.init(frame: frame)
        self.setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() -> () {
        if let photoCollectionView = self.photoCollectionView {
            self.addSubview(photoCollectionView)
            photoCollectionView.snp.makeConstraints({ (make) in
                make.left.right.bottom.equalToSuperview()
                make.top.equalToSuperview().offset(SPFeedVM.paddingV)
            })
        }
        self.addSubview(self.infoLabel)
        
        self.infoLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-(SPFeedVM.paddingV + 4))
            make.width.equalTo(50)
            make.height.equalTo(15)
        }
    }
    
    // MARK:- UICollectionViewDelegate, UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = self.photos?.count {
            return min(3, count)
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let images = self.photos else {
            return UICollectionViewCell()
        }
        let photo = images[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SPPhotoItemCell.self), for: indexPath) as! SPPhotoItemCell
        cell.imageView.kf.setImage(with: URL(string: photo.thumb))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         print("didSelectItemAt\(indexPath)")
    }
    
    
    // MARK:- SPPhotoItemCell
    class SPPhotoItemCell: UICollectionViewCell {
        var imageView: UIImageView = UIImageView()
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.addSubview(self.imageView)
            self.imageView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
}
