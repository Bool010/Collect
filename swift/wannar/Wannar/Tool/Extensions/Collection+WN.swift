//
//  Collection+WN.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/23.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    
    
    /// 安全下标
    ///
    /// - Parameter index: 索引
    subscript (safe index: Index) -> Generator.Element? {
        
        return indices.contains(index) ? self[index] : nil
    }
    
}
