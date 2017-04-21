//
//  WNRecommendHotCCell.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/19.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNRecommendHotCCell: UICollectionViewCell {
    
    var model: WNRecommendModel.RecommendTour? {
        didSet {
            guard let model = model else { return }
            
            // Image
            self.image.kf.setImage(with: URL.init(string: "\(WNConfig.BaseURL.website)\(model.mainPic)"))
            
            // Title
            self.title.text = model.title.app()
            
            // City
            let chineseCity = model.departure.components(separatedBy: "|").last
            if let chineseCity = chineseCity {
                self.departure.text = model.isActivity ? "\(chineseCity)活动" : "\(chineseCity)出发"
            }
            
            // Discount
            if model.isDiscountNow {
                self.discount.text = "\(((Double)(model.discountPercentNow)) / 10.0)折"
                self.discount.isHidden = false
                self.discount.snp.updateConstraints({ (make) in
                    make.width.equalTo(40.0)
                })
                self.price.snp.updateConstraints({ (make) in
                    make.left.equalToSuperview().offset(43.0)
                })
            } else {
                self.discount.isHidden = true
                self.discount.snp.updateConstraints({ (make) in
                    make.width.equalTo(0.0)
                })
                self.price.snp.updateConstraints({ (make) in
                    make.left.equalToSuperview().offset(3.0)
                })
            }
            
            // Price
            self.price.text = String.init(format: "%.1f/人起", (Double)(model.currentPrice) / 100.0)
        }
    }
    
    private var image: UIImageView!
    private var iconImage: UIImageView!
    private var departure: UILabel!
    private var title: UILabel!
    private var discount: UILabel!
    private var price: UILabel!
    
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
        self.contentView.addSubview(self.image)
        self.image.snp.makeConstraints { [weak self] (make) in
            if let strongSelf = self {
                make.top.equalToSuperview().offset(10.0)
                make.left.right.equalToSuperview().offset(0.0)
                make.height.equalTo(strongSelf.image.snp.width).multipliedBy(3.0 / 4.0)
            }
        }
        
        /// Icon
        self.iconImage = UIImageView.init(mode: .scaleAspectFill)
        self.contentView.addSubview(self.iconImage)
        self.iconImage.snp.makeConstraints { [weak self] (make) in
            if let strongSelf = self {
                make.left.equalTo(strongSelf.image.snp.left).offset(0.0)
                make.top.equalTo(strongSelf.image.snp.bottom).offset(3.0)
                make.size.equalTo(CGSize.init(width: 10, height: 10))
            }
        }
        
        /// Departure
        self.departure = UILabel.init(color: UIColor.textColor(),
                                      fontName: WNConfig.FontName.kaitiRegular,
                                      size: 10,
                                      textAlignment: .left)
        self.contentView.addSubview(self.departure)
        self.departure.snp.makeConstraints { [weak self] (make) in
            if let strongSelf = self {
                make.left.equalTo(strongSelf.iconImage.snp.right).offset(3.0)
                make.centerY.equalTo(strongSelf.iconImage)
            }
        }
        
        /// Title Label 
        self.title = UILabel.init(color: UIColor.textColor(),
                                  fontName: WNConfig.FontName.kaitiRegular,
                                  size: 13,
                                  textAlignment: .left)
        self.contentView.addSubview(self.title)
        self.title.snp.makeConstraints { [weak self] (make) in
            if let strongSelf = self {
                make.left.right.equalToSuperview().offset(0.0)
                make.top.equalTo(strongSelf.iconImage.snp.bottom).offset(3.0)
            }
        }
        
        /// Discount
        self.discount = UILabel.init(color: UIColor.textColor(),
                                     fontName: WNConfig.FontName.kaitiBold,
                                     size: 13,
                                     textAlignment: .center)
        self.discount.backgroundColor = UIColor.themColor()
        self.discount.layer.cornerRadius = 3.0
        self.discount.layer.masksToBounds = true
        self.discount.layer.shouldRasterize = true
        self.contentView.addSubview(self.discount)
        self.discount.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0.0)
            make.bottom.equalToSuperview().offset(-10.0)
            make.size.equalTo(CGSize.init(width: 40.0, height: 20.0))
        }
        
        /// Price
        self.price = UILabel.init(color: UIColor.themColor(),
                                  fontName: WNConfig.FontName.kaitiBold,
                                  size: 15,
                                  textAlignment: .left)
        self.contentView.addSubview(self.price)
        self.price.snp.makeConstraints { [weak self] (make) in
            if let strongSelf = self {
                make.left.equalToSuperview().offset(43.0)
                make.centerY.equalTo(strongSelf.discount)
            }
        }
    }
}
