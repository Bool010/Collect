//
//  WNRecommendWeekCCell.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/18.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNRecommendWeekCCell: UICollectionViewCell {
    
    var model: WNRecommendModel.RecommendTour? {
        didSet {
            guard let model = model else { return }
            // Image
            self.image.kf.setImage(with: URL.init(string: "\(WNConfig.BaseURL.website)\(model.mainPic)"))
            
            // Title
            self.titleLabel.text = model.title.app()
            
            // Discount
            if model.isDiscountNow {
                self.discountLabel.text = "\(((Double)(model.discountPercentNow)) / 10.0)折"
                self.discountLabel.isHidden = false
                self.discountLabel.snp.updateConstraints({ (make) in
                    make.width.equalTo(45.0)
                })
                self.cityLabel.snp.updateConstraints({ (make) in
                    make.left.equalToSuperview().offset(50.0)
                })
            } else {
                self.discountLabel.isHidden = true
                self.discountLabel.snp.updateConstraints({ (make) in
                    make.width.equalTo(0.0)
                })
                self.cityLabel.snp.updateConstraints({ (make) in
                    make.left.equalToSuperview().offset(3.0)
                })
            }
            
            // City
            let chineseCity = model.departure.components(separatedBy: "|").last
            if let chineseCity = chineseCity {
                self.cityLabel.text = model.isActivity ? "\(chineseCity)活动" : "\(chineseCity)出发"
            }
            
            // EndDate
            self.endDateLabel.text = "结束日期：\(model.discountEnd.date(oldFormat: "yyyy-MM-dd'T'HH:mm:ssZ", newFormat: "yyyy.MM.dd"))"
            
            // Price
            self.priceLabel.text = String.init(format: "%.1f/人起", (Double)(model.currentPrice) / 100.0)
        }
    }
    var containerView: UIView!
    private var image: UIImageView!
    private var titleLabel: UILabel!
    private var discountLabel: UILabel!
    private var cityLabel: UILabel!
    private var endDateLabel: UILabel!
    private var priceLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func buildUI() -> Void {

        /// Container View
        let containerView = UIView.init()
        self.contentView.addSubview(containerView)
        containerView.backgroundColor = UIColor.white
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize.init(width: 0, height: 1)
        containerView.layer.shadowOpacity = 0.35
        containerView.layer.cornerRadius = 3.0
        containerView.layer.shadowRadius = 3.0
        containerView.layer.shouldRasterize = true
        containerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(3.0)
            make.right.equalToSuperview().offset(-3.0)
            make.top.equalToSuperview().offset(3.0)
            make.bottom.equalToSuperview().offset(-3.0)
        }
        self.containerView = containerView
        
        /// Image View
        self.image = UIImageView.init(mode: .scaleAspectFill)
        self.image.clipsToBounds = true
        containerView.addSubview(self.image)
        self.image.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().offset(0.0)
            make.bottom.equalToSuperview().offset(-70.0)
        }
        
        /// Title
        let titleView: UIView = UIView.init()
        titleView.backgroundColor = UIColor.init(white: 0.0, alpha: 0.5)
        containerView.addSubview(titleView)
        titleView.snp.makeConstraints { [weak self] (make) in
            if let strongSelf = self {
                make.left.right.equalToSuperview().offset(0.0)
                make.bottom.equalTo(strongSelf.image.snp.bottom).offset(0.0)
            }
        }
        
        self.titleLabel = UILabel.init(color: UIColor.white,
                                       fontName: WNConfig.FontName.kaitiRegular,
                                       size: 13,
                                       textAlignment: .left)
        self.titleLabel.numberOfLines = 2
        titleView.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(3.0)
            make.right.equalToSuperview().offset(-3.0)
            make.top.equalToSuperview().offset(5.0)
            make.bottom.equalToSuperview().offset(-5.0)
        }
        
        /// Discount
        self.discountLabel = UILabel.init(color: .textColor,
                                          fontName: WNConfig.FontName.kaitiBlack,
                                          size: 17,
                                          textAlignment: .left)
        containerView.addSubview(self.discountLabel)
        self.discountLabel.snp.makeConstraints { [weak self] (make) in
            if let strongSelf = self {
                make.left.equalToSuperview().offset(3.0)
                make.top.equalTo(strongSelf.image.snp.bottom).offset(3.0)
                make.width.equalTo(50.0)
            }
        }
        
        /// City
        self.cityLabel = UILabel.init(color: .textColor,
                                      fontName: WNConfig.FontName.kaitiRegular,
                                      size: 10,
                                      textAlignment: .left)
        containerView.addSubview(self.cityLabel)
        self.cityLabel.snp.makeConstraints { [weak self] (make) in
            if let strongSelf = self {
                make.left.equalToSuperview().offset(55.0)
                make.bottom.equalTo(strongSelf.discountLabel.snp.bottom).offset(0.0)
            }
        }
        
        /// End Date
        self.endDateLabel = UILabel.init(color: .textColor,
                                         fontName: WNConfig.FontName.kaitiRegular,
                                         size: 10,
                                         textAlignment: .left)
        containerView.addSubview(self.endDateLabel)
        self.endDateLabel.snp.makeConstraints { [weak self] (make) in
            if let strongSelf = self {
                make.left.equalToSuperview().offset(3.0)
                make.top.equalTo(strongSelf.cityLabel.snp.bottom).offset(3.0)
            }
        }
        
        /// Price
        self.priceLabel = UILabel.init(color: .themColor,
                                       fontName: WNConfig.FontName.kaitiBold,
                                       size: 16,
                                       textAlignment: .left)
        containerView.addSubview(self.priceLabel)
        self.priceLabel.snp.makeConstraints { [weak self] (make) in
            if let strongSelf = self {
                make.left.equalToSuperview().offset(3.0)
                make.top.equalTo(strongSelf.endDateLabel.snp.bottom).offset(5.0)
            }
        }
    }
}

class WNRecommendWeeksCCell: UICollectionViewCell {
    
    var collectionView: UICollectionView!
    var model: WNRecommendModel.Weeklys?
    var isScrolling = false
    
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
        collectionView.registerClassOf(WNRecommendWeekCCell.self)
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

extension WNRecommendWeeksCCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = self.model {
            return model.data.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: WNRecommendWeekCCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        if let data = self.model?.data[indexPath.item] {
            cell.model = data
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: UIScreen.width / 5.0 * 3.0,
                           height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12);
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if cell is WNRecommendWeekCCell {
            let x: WNRecommendWeekCCell = cell as! WNRecommendWeekCCell
            x.containerView.layer.shouldRasterize = isScrolling
        }
    }
    
    func visibleCellsShouldRasterize(aBool:Bool){
        for cell in collectionView.visibleCells as! [WNRecommendWeekCCell]{
            cell.containerView.layer.shouldRasterize = aBool;
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isScrolling = false
        self.visibleCellsShouldRasterize(aBool: isScrolling)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity == CGPoint.zero{
            isScrolling = false
            self.visibleCellsShouldRasterize(aBool: isScrolling)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isScrolling = true
        self.visibleCellsShouldRasterize(aBool: isScrolling)
        
    }
}
