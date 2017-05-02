//
//  WNItemListTCell.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/2.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNItemListTCell: UITableViewCell {

    var picture: UIImageView!
    var title: UILabel!
    var discount: UILabel!
    var price: UILabel!
    var date: UILabel!
    var model: WNTourModel? {
        didSet {
            guard let model = model else { return }
            self.picture.kf.setImage(with: URL.init(string: "\(WNConfig.BaseURL.website)\(model.mainPicture)"))
            self.title.text = model.title
            self.discount.text = String.init(format: "%.1f折", model.discountPercent.float / 10.0)
            self.price.text = String.init(format: "$%.1f起", model.currentPrice.float / 100.0)
            var dateStr = ""
            for json in model.week {
                dateStr += (json.stringValue + "  ")
            }
            self.date.text = dateStr
        }
    }
    
    class func cellWith(tableView: UITableView) -> WNItemListTCell {
        
        let cell: WNItemListTCell = tableView.dequeueReusableCell()
        cell.selectionStyle = .none
        return cell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }

    fileprivate func buildUI() -> Void {
        
        /// Picture
        let picture = UIImageView.init(mode: .scaleAspectFill)
        picture.clipsToBounds = true
        self.contentView.addSubview(picture)
        picture.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.top.equalToSuperview().offset(15.0)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 120.0, height: 90.0))
        }
        self.picture = picture
        
        
        /// Title
        let title = UILabel.init(color: .textColor, fontName: WNConfig.FontName.kaitiRegular, size: 13.0, textAlignment: .left)
        title.numberOfLines = 2
        self.contentView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.left.equalTo(picture.snp.right).offset(15.0)
            make.top.equalTo(picture.snp.top)
            make.right.equalToSuperview().offset(-15.0)
        }
        self.title = title
        
        
        /// Discount
        let discount = UILabel.init(color: .white, fontName: WNConfig.FontName.kaitiBlack, size: 16.0, textAlignment: .center)
        discount.backgroundColor = .themColor
        discount.layer.cornerRadius = 3.0
        discount.layer.shouldRasterize = true
        discount.clipsToBounds = true
        self.contentView.addSubview(discount)
        discount.snp.makeConstraints { (make) in
            make.left.equalTo(picture.snp.right).offset(15.0)
            make.size.equalTo(CGSize.init(width: 50.0, height: 25.0))
            make.top.equalTo(title.snp.bottom).offset(10.0)
        }
        self.discount = discount
        
        
        /// Price
        let price = UILabel.init(color: .themColor, fontName: WNConfig.FontName.kaitiBold, size: 16.0, textAlignment: .left)
        self.contentView.addSubview(price)
        price.snp.makeConstraints { (make) in
            make.left.equalTo(discount.snp.right).offset(10.0)
            make.centerY.equalTo(discount.snp.centerY)
        }
        self.price = price
        
        
        /// Date
        let date = UILabel.init(color: .textColor, fontName: WNConfig.FontName.kaitiRegular, size: 13.0, textAlignment: .left)
        self.contentView.addSubview(date)
        date.snp.makeConstraints { (make) in
            make.left.equalTo(picture.snp.right).offset(15.0)
            make.bottom.equalTo(picture.snp.bottom)
        }
        self.date = date
    }
}
