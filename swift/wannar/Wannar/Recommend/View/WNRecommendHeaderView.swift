//
//  WNRecommendHeaderView.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/20.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNRecommendHeaderView: UICollectionReusableView {
    
    var title: UILabel!
    var subtitle: UILabel!
    var icon: UIImageView!
    
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
        self.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.right.equalToSuperview().offset(-15.0)
            make.centerY.equalToSuperview()
        }
        
        /// Icon
        let icon = UIImageView.init()
        containerView.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(0.0)
            make.size.equalTo(CGSize.init(width: 20.0, height: 20.0))
        }
        self.icon = icon
        
        /// Title
        let title = UILabel.init(color: UIColor.textColor(), font: UIFont.boldSystemFont(ofSize: 18.0), textAlignment: .left)
        containerView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(2.0)
            make.centerY.equalTo(icon)
        }
        self.title = title;
        
        /// Subtitle
        let subtitle = UILabel.init(color: UIColor.textColor(), size: 12.0, textAlignment: .left)
        containerView.addSubview(subtitle)
        subtitle.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(0.0)
            make.top.equalTo(icon.snp.bottom).offset(2.0)
            make.bottom.equalToSuperview().offset(0.0)
        }
        self.subtitle = subtitle
    }
}
