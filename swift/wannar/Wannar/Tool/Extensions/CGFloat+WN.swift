//
//  CGFloat+WN.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/24.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    
    public var double: Double {
        get {
            return (Double)(self)
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
