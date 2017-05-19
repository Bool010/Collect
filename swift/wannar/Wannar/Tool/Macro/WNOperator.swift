//
//  WNOperator.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/19.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation

// MARK: - 模糊匹配
infix operator =~
func =~ (lhs: String, rhs: String) -> Bool {
    return WNRegexHelper(rhs).match(input: lhs)
}

// MARK: - 字符串编辑距离
infix operator >>>
func >>> (source: String, target: String) -> Int {
    let s = source.characters.count
    let t = target.characters.count
    var d = [[Int]]()
    // 矩阵初始化
    for _ in 0 ... s {
        var x = [Int]()
        for _ in 0 ... t { x.append(0) }
        d.append(x)
    }
    
    for i in 0 ... s { d[i][0] = i }
    for j in 0 ... t { d[0][j] = j }
    
    for i in 1 ... s {
        for j in 1 ... t {
            // 相同
            if source[i-1] == target[j-1] {
                d[i][j] = d[i-1][j-1]
            } else {
                let edIns = d[i][j-1] + 1   // 插入
                let edDel = d[i-1][j] + 1   // 删除
                let edRep = d[i-1][j-1] + 1 // 替换
                d[i][j] = min(min(edIns, edDel), edRep)
            }
        }
    }
    return d[s][t]
}

// 字符串相似度
infix operator >>?
func >>? (source: String, target: String) -> Double {
    return (target.length - (source >>> target)).double / target.length.double
}
