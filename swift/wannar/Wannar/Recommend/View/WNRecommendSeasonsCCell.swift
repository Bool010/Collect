//
//  WNRecommendSeasonsCCell.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/19.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNRecommendSeasonsCCell: UICollectionViewCell {
    var model: WNRecommendModel.RecommendTour? {
        didSet{
            guard let model = model else { return }
            
            self.image.kf.setImage(with: URL.init(string: ("\(WNConfig.BaseURL.website)\(model.mainPic)")))
            self.title.text = model.title.app
            self.price.text = String.init(format: "$%.1f/人起", (Double)(model.currentPrice) / 100.0)
        }
    }
    
    var image: UIImageView!
    var title: UILabel!
    var price: UILabel!
    
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
        self.image.snp.makeConstraints { [weak self] (make) in
            if let strongSelf = self {
                make.left.equalToSuperview().offset(15.0)
                make.top.equalToSuperview().offset(8.0)
                make.bottom.equalToSuperview().offset(-8.0)
                make.width.equalTo(strongSelf.image.snp.height)
            }
        }
        
        /// Title Label
        self.title = UILabel.init(color: .textColor,
                                  fontName: WNConfig.FontName.normal,
                                  size: 13,
                                  textAlignment: .left)
        self.title.numberOfLines = 2
        self.contentView.addSubview(self.title)
        self.title.snp.makeConstraints { [weak self] (make) in
            if let strongSelf = self {
                make.left.equalTo(strongSelf.image.snp.right).offset(5.0)
                make.top.equalTo(strongSelf.image.snp.top).offset(0.0)
                make.right.equalToSuperview().offset(-15.0)
            }
        }
        
        /// Price Label
        self.price = UILabel.init(color: .themColor,
                                  fontName: WNConfig.FontName.normal,
                                  size: 13,
                                  textAlignment: .left)
        self.contentView.addSubview(self.price)
        self.price.snp.makeConstraints { [weak self] (make) in
            if let strongSelf = self {
                make.left.equalTo(strongSelf.image.snp.right).offset(5.0)
                make.bottom.equalTo(strongSelf.image.snp.bottom).offset(0.0)
            }
        }
        
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
