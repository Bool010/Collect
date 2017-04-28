//
//  Double+WN.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/24.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    
    public var cgFloat: CGFloat {
        get {
            return (CGFloat)(self)
        }
    }
    
    public var float: Float {
        get {
            return (Float)(self)
        }
    }
    
    public var string: String {
        get {
            return "\(self)"
        }
    }
}
