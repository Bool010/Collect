//
//  WNItemListConditionView.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/11.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNItemListConditionView: UIView {

    var click: ((_ btn: UIButton, _ event: String) -> Void)?
    private var data: Array<Array<String>> = [["筛选".ItemList, "", "filter"],
                                              ["排序".ItemList, "", "sort"]]
    private var btns: Array<WNButton> = []
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    convenience init(isNeedCity: Bool) {
        
        self.init()
        if isNeedCity {
            data.insert(["城市".ItemList, "", "city"], at: 0)
        }
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        self.backgroundColor = .white
        for i in 0 ..< data.count {
            let x = data[i]
            let btn = WNButton.init(imagePosition: .right, imageSize: CGSize.init(width: 18, height: 18))
            btn.titleLabel.text = x.first
            btn.titleLabel.font = UIFont.systemFont(ofSize: 14)
            btn.titleLabel.textColor = .textColor
            btn.imageView.image = UIImage.init(named: x[1])
            self.addSubview(btn)
            btns.append(btn)
            btn.snp.makeConstraints({ (make) in
                make.top.bottom.equalToSuperview().offset(0.0)
                make.width.equalToSuperview().multipliedBy(1.double/data.count.double)
                if i == 0 {
                    make.left.equalToSuperview().offset(0.0)
                } else {
                    make.left.equalTo(btns[i - 1].snp.right).offset(0.0)
                }
            })
            btn.click = { [weak self] (btn) in
                guard let _self = self else { return }
                if let click = _self.click {
                    click(btn, x[2])
                }
            }
            if i != 0 {
                let line = UIView.init()
                self.addSubview(line)
                line.backgroundColor = UIColor.separatorColor
                line.snp.makeConstraints({ (make) in
                    make.right.equalTo(btn.snp.left).offset(0.0)
                    make.centerY.equalTo(btn)
                    make.width.equalTo(0.5)
                    make.height.equalTo(18.0)
                })
            }
        }
        
        let sep = UIView.init()
        sep.backgroundColor = UIColor.separatorColor
        self.addSubview(sep)
        sep.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0.0)
            make.height.equalTo(0.5)
        }
    }
}
