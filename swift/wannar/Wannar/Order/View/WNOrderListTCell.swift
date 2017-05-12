//
//  WNOrderListTCell.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/8.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNOrderListTCell: UITableViewCell {

    var orderDate: UILabel!
    var status: UILabel!
    var picture: UIImageView!
    var title: UILabel!
    var code: UILabel!
    var price: UILabel!
    var departureDate: UILabel!
    var btn: UIButton!
    
    class func cellWith(tableView: UITableView) -> WNOrderListTCell {
        
        let cell: WNOrderListTCell = tableView.dequeueReusableCell()
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
    
    private func buildUI() -> Void {
        
        // Container View
        let containerView = UIView.init()
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.right.equalToSuperview().offset(-15.0)
            make.top.equalToSuperview().offset(15.0)
            make.bottom.equalToSuperview().offset(-15.0)
        }
        
        // Top View
        let topView = UIView.init()
        containerView.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().offset(0.0)
            make.height.equalTo(50.0)
        }
        
        let orderDate = UILabel.init(color: .textColor, size: 13.0, textAlignment: .left)
        topView.addSubview(orderDate)
        orderDate.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5.0)
            make.centerY.equalToSuperview()
        }
        self.orderDate = orderDate
        
        let status = UILabel.init(color: .themColor, size: 14, textAlignment: .right)
        topView.addSubview(status)
        status.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15.0)
        }
        self.status = status
        
        // Bottom View
        let bottomView = UIView.init()
        containerView.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0.0)
            make.height.equalTo(35.0)
        }
        
        let priceText = UILabel.init(color: .textColor, size: 13.0, textAlignment: .left)
        priceText.text = "总计："
        bottomView.addSubview(priceText)
        priceText.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5.0)
            make.centerY.equalToSuperview()
        }
        
        let price = UILabel.init(color: .themColor, size: 15.0, textAlignment: .left)
        bottomView.addSubview(price)
        price.snp.makeConstraints { (make) in
            make.left.equalTo(priceText.snp.right).offset(2.0)
            make.centerY.equalToSuperview()
        }
        self.price = price
        
        
        let departureDate = UILabel.init(color: .textColor, size: 13.0, textAlignment: .left)
        bottomView.addSubview(departureDate)
        departureDate.snp.makeConstraints { (make) in
            make.left.equalTo(price.snp.right).offset(10.0)
            make.centerY.equalToSuperview()
        }
        self.departureDate = departureDate
        
        let btn = UIButton.init()
        btn.layer.cornerRadius = 3.0
        btn.layer.shouldRasterize = true
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.themColor.cgColor
        bottomView.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5.0)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 60.0, height: 25.0))
        }
        btn.addControlEvent(.touchUpInside) { (btn) in
            
        }
        self.btn = btn
        
        
        // Center View
        let centerView = UIView.init()
        containerView.addSubview(centerView)
        centerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(0.0)
            make.top.equalTo(topView.snp.bottom).offset(0.0)
            make.bottom.equalTo(bottomView.snp.top).offset(0.0)
        }
        
        let picture = UIImageView.init(mode: .scaleAspectFill)
        centerView.addSubview(picture)
        picture.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5.0)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: UIScreen.width / 6.0, height: UIScreen.width / 6.0))
            make.top.equalToSuperview().offset(12.0)
        }
        self.picture = picture
        
        let title = UILabel.init(color: .textColor, font: UIFont.boldSystemFont(ofSize: 14.0), textAlignment: .left)
        title.numberOfLines = 2
        centerView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.left.equalTo(picture.snp.right).offset(5.0)
            make.right.equalToSuperview().offset(-5.0)
            make.top.equalTo(picture.snp.top).offset(0.0)
        }
        self.title = title
        
        let code = UILabel.init(color: .textColor, size: 11.0, textAlignment: .left)
        centerView.addSubview(code)
        code.snp.makeConstraints { (make) in
            make.left.equalTo(picture.snp.right).offset(5.0)
            make.bottom.equalTo(picture.snp.bottom).offset(0.0)
        }
        self.code = code
    }
}
