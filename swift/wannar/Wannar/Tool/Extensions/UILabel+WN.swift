//
//  UILabel+Extension.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/9.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(color: UIColor?, fontName: String?, size: CGFloat, textAlignment: NSTextAlignment?) {
        self.init()
        self.textColor = color
        if let textAlignment = textAlignment {
            self.textAlignment = textAlignment
        }
        if let fontName = fontName {
            UIFont.set(fontName: fontName, label: self, size: size)
        } else {
            self.font = UIFont.systemFont(ofSize: size)
        }
    }
    
    func set(color: UIColor?, fontName: String?, size: CGFloat, textAlignment: NSTextAlignment?) {
        self.textColor = color
        if let textAlignment = textAlignment {
            self.textAlignment = textAlignment
        }
        if let fontName = fontName {
            UIFont.set(fontName: fontName, label: self, size: size)
        } else {
            self.font = UIFont.systemFont(ofSize: size)
        }
    }
    
    convenience init(color: UIColor?, font: UIFont?, textAlignment: NSTextAlignment?) {
        
        self.init()
        self.textColor = color
        if let textAlignment = textAlignment {
            self.textAlignment = textAlignment
        }
        if let font = font {
            self.font = font
        }
    }
    
    
    convenience init(color: UIColor?, size: Float?, textAlignment: NSTextAlignment?) {
        
        self.init()
        self.textColor = color
        if let size = size {
            self.font = UIFont.systemFont(ofSize: CGFloat(size))
        }
        if let textAlignment = textAlignment {
            self.textAlignment = textAlignment
        }
    }
    
    
    convenience init(color: UIColor?, size: Float) {
        
        self.init(color: color, size: size, textAlignment:nil)
    }
    
}
