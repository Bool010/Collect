//
//  UIScreen.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/22.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation
import UIKit

enum WNScreenSize: String {
    
    case _3_5 = "{320.0, 480.0}"
    case _4_0 = "{320.0, 568.0}"
    case _4_7 = "{375.0, 667.0}"
    case _5_5 = "{414.0, 736.0}"
    case unknown = ""
}

extension UIScreen {

    class func currentForm() -> WNScreenSize {
        
        let aWidth = UIScreen.width
        let aHeight = UIScreen.height
        
        if aWidth == 320 && aHeight == 480 {
            return ._3_5
        } else if aWidth == 320 && aHeight == 568 {
            return ._4_0
        } else if aWidth == 375 && aHeight == 667 {
            return ._4_7
        } else if aWidth == 414 && aHeight == 736 {
            return ._5_5
        } else {
            return .unknown
        }
    }
    
    open class var width: Double {
        get {
            return Double(UIScreen.main.bounds.size.width)
        }
    }
    
    open class var height: Double {
        get {
            return Double(UIScreen.main.bounds.size.height)
        }
    }
    
    open class var radio320: Double {
        get {
            return UIScreen.width / 320.0
        }
    }
}
