//
//  WNUITool.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/9.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

func initNavigationToView(view: UIView,
                          closure: ((_ leftBtn: UIButton, _ rightBtn: UIButton, _ titleLabel: UILabel) -> Void)) {
    
    /// Navigation View
    let navigationView = UIView.init(frame: CGRect.init(x: 0.0,
                                                        y: 0.0,
                                                        width: UIScreen.width,
                                                        height: 64.0))
    view.addSubview(navigationView)
    
    
    /// Left Btn
    let leftBtn = UIButton.init(frame: CGRect.init(x: 0.0,
                                                   y: 20.0,
                                                   width: 50.0,
                                                   height: 44.0))
    navigationView.addSubview(leftBtn)
    

    /// Right Btn
    let rightBtn = UIButton.init(frame: CGRect.init(x: UIScreen.width - 50.0,
                                                    y: 20,
                                                    width: 50,
                                                    height: 44.0))
    navigationView.addSubview(rightBtn)
    
    
    /// Title Label
    let titleLabel = UILabel.init(frame: CGRect.init(x: 50.0,
                                                     y: 20,
                                                     width: UIScreen.width - 100,
                                                     height: 44))
    titleLabel.font = UIFont.systemFont(ofSize: 16)
    titleLabel.textColor = .textColor
    titleLabel.textAlignment = .center
    navigationView.addSubview(titleLabel)
    
    closure(leftBtn, rightBtn, titleLabel)
}
