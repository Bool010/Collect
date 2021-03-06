//
//  UIButton+Extension.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/9.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(title: String?, fontSize: Float?, color: UIColor?) {
        
        self.init()
        if let title = title {
            self.setTitle(title, for: .normal)
        }
        if let size = fontSize {
            self.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(size))
        }
        self.setTitleColor(color, for: .normal)
    }
    
    
    convenience init(image: String?) {
        
        self.init(image: image, mode: nil)
    }
    
    
    convenience init(image: String?, mode: UIViewContentMode?) {
        
        self.init()
        if let image = image {
            self.setImage(UIImage.init(imageLiteralResourceName: image), for: .normal)
        }
        if let mode = mode {
            self.contentMode = mode
        }
    }
}

