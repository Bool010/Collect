//
//  UIImageView+Extension.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/9.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit


extension UIImageView {
    
    convenience init(mode: UIViewContentMode) {
        
        self.init()
        self.contentMode = mode
    }
}
