//
//  WNRange.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/12.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation

public struct WNRange {
    
    public var start: Int = 0
    public var length: Int = 0
    init(_ start: Int, _ length: Int) {
        self.start = start
        self.length = length
    }
}
