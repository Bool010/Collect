//
//  WNLoginPlatformTCell.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/24.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNLoginPlatformTCell: UITableViewCell {

    class func cellWith(tableView: UITableView) -> WNLoginPlatformTCell {
        
        let cell: WNLoginPlatformTCell = tableView.dequeueReusableCell()
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
        
        self.backgroundColor = .clear
        
        /// Separator
        let separator = UIView.init()
        separator.backgroundColor = .white
        self.contentView.addSubview(separator)
        separator.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.right.equalToSuperview().offset(-15.0)
            make.top.equalToSuperview().offset(0.0)
            make.height.equalTo(0.5)
        }
        
        /// Platform
        let images = ["wechat", "qq", "weibo"]
        let titles = ["微信", "QQ", "微博"]
        let size: CGSize = CGSize.init(width: 80, height: 80)
        let space: CGFloat = ((CGFloat)(UIScreen.width) - 3 * size.width) / 4.0
        
        for i in 0 ..< images.count {
            
            let btn = WNButton.init(imagePosition: .top, imageSize: CGSize.init(width: 60, height: 60))
            btn.layer.cornerRadius = size.width / 2.0
            btn.imageView.image = UIImage.init(named: images[i])
            btn.titleLabel.text = titles[i]
            btn.titleLabel.set(color: .white,
                               fontName: WNConfig.FontName.normal,
                               size: 15.0,
                               textAlignment: .center)
            self.contentView.addSubview(btn)
            btn.snp.makeConstraints({ (make) in
                make.left.equalToSuperview().offset(i.cgFloat * size.width + (i + 1).cgFloat * space)
                make.centerY.equalToSuperview()
                make.size.equalTo(size)
            })
        }
        
    }
}
