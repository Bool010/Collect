//
//  WNColor.swift
//  Wannar
//
//  Created by 付国良 on 2016/11/22.
//  Copyright © 2016年 玩哪儿. All rights reserved.
//

import Foundation

#if os(iOS)
    import UIKit
#else
    import Cocoa
#endif


extension UIColor {
    
    /// RGB
    ///
    /// - Parameters:
    ///   - R: red
    ///   - G: green
    ///   - B: blue
    /// - Returns: UIColor
    class func RGB(R: CGFloat, G: CGFloat, B:CGFloat) -> UIColor {
        return UIColor (red: R/255.0, green: G/255.0, blue: B/255.0, alpha: 1)
    }
    
    
    /// RGBA
    ///
    /// - Parameters:
    ///   - r: red
    ///   - g: green
    ///   - b: blue
    ///   - a: alpha
    /// - Returns: UIColor
    class func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
        return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    /// 主题色
    open class var themColor: UIColor {
        get {
            return UIColor.RGB(R: 255.0, G: 53.0, B: 116.0)
        }
    }
    
    /// 普通文本色
    open class var textColor: UIColor {
        get {
            return UIColor.RGB(R: 76.0, G: 76.0, B: 76.0)
        }
    }
    
    /// 分割线颜色
    open class var separatorColor: UIColor {
        get {
            return UIColor.RGB(R: 200.0, G: 199.0, B: 204.0)
        }
    }
    
    /// 随机色
    open class var randomColor: UIColor {
        get {
            let R = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
            let G = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
            let B = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
            return UIColor.init(red: R, green: G, blue: B, alpha: 1.0)
        }
    }
    
    //// 16进制 转 RGBA
    class func rgbaFromHex(rgb:Int, alpha: CGFloat) ->UIColor {
        
        return UIColor(red: ((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(rgb & 0xFF)) / 255.0,
                       alpha: alpha)
    }
    
    /// 16进制 转 RGB
    class func rgbFromHex(rgb:Int) -> UIColor {
        
        return UIColor(red: ((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(rgb & 0xFF)) / 255.0,
                       alpha: 1.0)
    }
    
    /// Hex颜色
    ///
    /// - Parameter hexString: hexString
    public convenience init(hexString: String) {
        
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
