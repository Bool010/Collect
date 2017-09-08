//
//  UIScreen.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/22.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation
import UIKit



extension UIScreen {

    public enum WNScreenForm: String {
        case s3_5 = "{320.0, 480.0}"
        case s4_0 = "{320.0, 568.0}"
        case s4_7 = "{375.0, 667.0}"
        case s5_5 = "{414.0, 736.0}"
        case unknown = ""
    }
    
    open class var form: WNScreenForm {
        get {
            let w = UIScreen.width
            let h = UIScreen.height
            
            switch (w, h) {
            case (320, 480): return .s3_5
            case (320, 568): return .s4_0
            case (375, 667): return .s4_7
            case (414, 736): return .s5_5
            default: return .unknown
            }
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
