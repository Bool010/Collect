//
//  WNMeHeaderView.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/26.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit
import Spring

class WNMeHeaderView: UIView {

    var userIcon: UIImageView!
    var userHeaderBtn: UIButton!
    var userNameLabel: UILabel!
    var creditLabel: UILabel!
    var accountLabel: UILabel!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func buildUI() -> Void {
        
        // Layer
        let layer: CAGradientLayer = CAGradientLayer.init()
        layer.frame = CGRect.init(x: 0.0, y: 0.0, width: UIScreen.width, height: 100.0)
        layer.colors = [UIColor.themColor.cgColor, UIColor.red.cgColor, UIColor.themColor.cgColor]
        layer.locations = [0.0, 0.5, 1.0]
        layer.set(direction: .right)
        self.layer.addSublayer(layer)

        
        /// User Header Image
        let userIcon = UIImageView.init(mode: .scaleToFill)
        userIcon.image = UIImage.init(named: "qq")
        userIcon.layer.cornerRadius = 35
        userIcon.layer.borderWidth = 1.0
        userIcon.layer.borderColor = UIColor.white.cgColor
        userIcon.clipsToBounds = true
        self.addSubview(userIcon)
        userIcon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.centerY.equalToSuperview()
            make.width.equalTo(70.0)
            make.height.equalTo(70.0)
        }
        self.userIcon = userIcon
        
        /// User Header Button
        let userHeaderBtn = UIButton.init()
        userHeaderBtn.imageView?.contentMode = .scaleAspectFill
        self.addSubview(userHeaderBtn)
        userHeaderBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.centerY.equalToSuperview()
            make.width.equalTo(70.0)
            make.height.equalTo(70.0)
        }
        self.userHeaderBtn = userHeaderBtn
        
        /// Container
        let containerView = UIView.init()
        self.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.left.equalTo(userHeaderBtn.snp.right).offset(20.0)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15.0)
        }
        
        /// User Name
        let userNameLabel = UILabel.init(color: .white, fontName: WNConfig.FontName.normal, size: 16, textAlignment: .left)
        containerView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().offset(0.0)
        }
        self.userNameLabel = userNameLabel
        
        /// Credit
        let creditLabel = UILabel.init(color: .white, fontName: WNConfig.FontName.normal, size: 13, textAlignment: .left)
        containerView.addSubview(creditLabel)
        creditLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(0.0)
            make.top.equalTo(userNameLabel.snp.bottom).offset(2.0)
        }
        self.creditLabel = creditLabel
        
        /// Account
        let accountLabel = UILabel.init(color: .white, fontName: WNConfig.FontName.normal, size: 13, textAlignment: .left)
        containerView.addSubview(accountLabel)
        accountLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0.0)
            make.top.equalTo(creditLabel.snp.bottom).offset(2.0)
        }
        self.accountLabel = accountLabel
    }

}
