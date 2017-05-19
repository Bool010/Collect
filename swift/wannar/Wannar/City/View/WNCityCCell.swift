//
//  WNCityCCell.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/15.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNCityCCell: UICollectionViewCell {
    
    var model: WNCityModel? {
        didSet {
            if let model = model {
                picture.kf.setImage(with: URL.init(string: "\(WNConfig.BaseURL.website)\(model.imageS)"))
                title.text = model.nameCN
                subtitle.text = model.nameEN
            }
        }
    }
    private var picture: UIImageView!
    private var title: UILabel!
    private var subtitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func buildUI() {
                
        // Picture
        let picture = UIImageView.init(mode: .scaleAspectFill)
        picture.layer.cornerRadius = 3.0
        picture.layer.shouldRasterize = true
        picture.clipsToBounds = true
        self.contentView.addSubview(picture)
        picture.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview().offset(0.0)
        }
        self.picture = picture
        
        // Dimming View
        let dimming = UIView.init()
        dimming.backgroundColor = UIColor.init(white: 0.0, alpha: 0.3)
        self.contentView.addSubview(dimming)
        dimming.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview().offset(0.0)
        }
        
        // Subtitle
        let subtitle = UILabel.init(color: .white, font: UIFont.init(name: "SnellRoundhand-Bold", size: 13), textAlignment: .left)
        self.contentView.addSubview(subtitle)
        subtitle.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8.0)
            make.right.equalToSuperview().offset(-8.0)
            make.bottom.equalToSuperview().offset(-6.0)
        }
        self.subtitle = subtitle
        
        // Title
        let title = UILabel.init(color: .white, font: UIFont.boldSystemFont(ofSize: 15.0), textAlignment: .left)
        self.contentView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8.0)
            make.right.equalToSuperview().offset(-8.0)
            make.bottom.equalTo(subtitle.snp.top).offset(-3.0)
        }
        self.title = title
        
        // Border View
        let borderView = UIView.init()
        borderView.layer.borderWidth = 1.0
        borderView.layer.borderColor = UIColor.white.cgColor
        borderView.layer.cornerRadius = 1.0
        borderView.layer.shouldRasterize = true
        self.contentView.addSubview(borderView)
        borderView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(3.0)
            make.right.equalToSuperview().offset(-3.0)
            make.bottom.equalToSuperview().offset(-4.0)
            make.top.equalToSuperview().offset(4.0)
        }
    }
}
