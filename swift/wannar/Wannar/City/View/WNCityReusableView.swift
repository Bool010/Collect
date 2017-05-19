//
//  WNCityReusableView.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/17.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNCityReusableView: UICollectionReusableView {
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    private var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func buildUI() {
        
        let titleLabel = UILabel.init(color: .textColor, font: UIFont.boldSystemFont(ofSize: 15.0), textAlignment: .left)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.centerY.equalToSuperview()
        }
        self.titleLabel = titleLabel
    }
}
