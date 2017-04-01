//
//  WNGlobalVar.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/10.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNGlobalVar: NSObject {
    
    typealias networkChangeHandle = (_ isValid: Bool) -> Void
    
    public class var shared : WNGlobalVar {
        struct Static {
            static let instance : WNGlobalVar = WNGlobalVar()
        }
        return Static.instance
    }
    
    public var networkChange: networkChangeHandle?
    
    public var isNetworkValid: Bool = true
    
}
