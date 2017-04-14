//
//  Array+WN.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/21.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation

extension Array {
    
    /// 洗牌
    mutating func shuffle() {
        for index in 0 ..< self.count {
            let random: Int = Int(arc4random_uniform(UInt32(self.count)))
            if random != index {
                swap(&self[index], &self[random])
            }
        }
    }
    
}
