//
//  WNRecommendScenicsCCell.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/19.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNRecommendScenicCCell: UICollectionViewCell {
    var model: WNRecommendModel.Scenics.Scenic? {
        didSet{
            guard let model = model else { return }
            /// Image
            self.image.kf.setImage(with: URL.init(string: (model.image)))
            
            /// Title
            self.title.text = model.text.app
        }
    }
    
    private var image: UIImageView!
    private var title: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func buildUI() -> Void {
        
        /// Image View
        self.image = UIImageView.init(mode: .scaleAspectFill)
        self.image.clipsToBounds = true
        self.image.layer.cornerRadius = 3.0
        self.image.layer.shouldRasterize = true
        self.contentView.addSubview(self.image)
        self.image.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().offset(0.0)
            make.bottom.equalToSuperview().offset(-20.0)
        }
        
        /// Title Label
        self.title = UILabel.init(color: .textColor,
                                  fontName: WNConfig.FontName.normal,
                                  size: 15,
                                  textAlignment: .center)
        self.contentView.addSubview(self.title)
        self.title.snp.makeConstraints { [weak self] (make) in
            if let strongSelf = self {
                make.left.right.bottom.equalToSuperview().offset(0.0)
                make.top.equalTo(strongSelf.image.snp.bottom).offset(0.0)
            }
        }
    }
}


class WNRecommendScenicsCCell: UICollectionViewCell {
    
    var collectionView: UICollectionView!
    var model: WNRecommendModel.Scenics?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func buildUI() -> Void {
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().offset(0.0)
            make.bottom.equalToSuperview().offset(-10.0)
        }
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.registerClassOf(WNRecommendScenicCCell.self)
        self.collectionView = collectionView
        
        /// Line View
        let lineView = UIView.init()
        lineView.backgroundColor = .separatorColor
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.right.equalToSuperview().offset(-15.0)
            make.bottom.equalToSuperview().offset(0.0)
            make.height.equalTo(0.5)
        }
    }
}

extension WNRecommendScenicsCCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = self.model {
            return model.data.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: WNRecommendScenicCCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        if let data = self.model?.data[indexPath.item] {
            cell.model = data
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: UIScreen.width / 5.0 * 2.0,
                           height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 15, 0, 15);
    }
}

