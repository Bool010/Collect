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
    var btns: [UIButton] = [UIButton]()
    
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
            make.left.right.top.equalToSuperview().offset(0.0)
            make.height.equalTo(30.0)
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
            let btn = UIButton.init()
            btn.setTitleColor(UIColor.textColor(), for: .normal)
            btn.backgroundColor = UIColor.randomColor()
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
