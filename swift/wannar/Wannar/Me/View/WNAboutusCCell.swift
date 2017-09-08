//
//  WNAboutusCCell.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/27.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit
import FSPagerView

class WNAboutusCCell: FSPagerViewCell {
    
    var titleLabel: UILabel!
    var contentLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func buildUI() -> Void {
        
        let title = UILabel.init(color: .textColor, fontName: WNConfig.FontName.normal, size: 20, textAlignment: .center)
        self.contentView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20.0)
        }
        self.titleLabel = title
        
        let content = UILabel.init(color: .textColor, fontName: WNConfig.FontName.normal, size: 13.0, textAlignment: .left)
        content.numberOfLines = 0
        self.contentView.addSubview(content)
        content.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15.0)
            make.right.equalToSuperview().offset(-15.0)
        }
        self.contentLabel = content
    }

}
