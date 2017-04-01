//
//  UITextField+Extension.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/9.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

extension UITextField {
    
    convenience init(text: String?, size: Float?, textColor: UIColor?, backgroundColor: UIColor?, placeholder: String?) {
        self.init()
        if let text = text {
            self.text = text
        }
        if let placeholder = placeholder {
            self.placeholder = placeholder
        }
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let textColor = textColor {
            self.textColor = textColor
        }
        if let size = size {
            self.font = UIFont.systemFont(ofSize: CGFloat(size))
        }
    }
    
    
    convenience init(text: String?, size: Float?, textColor: UIColor?, placeholder: String?) {
        self.init(text: text, size: size, textColor: textColor, backgroundColor: nil, placeholder: placeholder)
    }
}
