//
//  WNRecommendMeauCCell.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/14.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNRecommendMeauCCell: UICollectionViewCell {
    
    var slogan: UILabel!
    var btns: [WNButton] = [WNButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func buildUI() -> Void {
        
        /// Slogan
        let slogan = UILabel.init(color: UIColor.textColor(), size: 15, textAlignment: .center)
        self.contentView.addSubview(slogan)
        slogan.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15.0)
            make.left.right.equalToSuperview().offset(0.0)
            make.height.equalTo(25.0)
        }
        self.slogan = slogan
        
        /// Meau Btn Container
        let container = UIView.init()
        self.contentView.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0.0)
            make.top.equalTo(slogan.snp.bottom).offset(0.0)
        }
        
        /// Meau Button
        for i in 0...4 {
            let btn: WNButton = WNButton.init(imagePosition: .top, imageSize: CGSize.init(width: 35, height: 35))
            btn.titleLabel.textColor = UIColor.textColor()
            btn.titleLabel.font = UIFont.systemFont(ofSize: 15.0)
            btn.space = 5
            container.addSubview(btn)
            btn.snp.makeConstraints({ (make) in
                make.left.equalToSuperview().offset(Double(i) * (UIScreen.width / 5.0))
                make.top.equalToSuperview().offset(15.0)
                make.bottom.equalToSuperview().offset(-15.0)
                make.width.equalTo((UIScreen.width / 5.0))
            })
            self.btns.append(btn)
        }
    }
}
