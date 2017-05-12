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

extension BidirectionalCollection where Iterator.Element == String, SubSequence.Iterator.Element == String {
    
    func pinyinSort() -> Array<String> {
        let x = self.sorted { (a, b) -> Bool in
            return a.toPinyin() < b.toPinyin()
        }
        return x
    }
    
    func pinyinGroup() -> Array<Array<String>> {
        
        let pinyinSort = self.pinyinSort()
        var initial = ""
        var arr: Array<String> = []
        var result: Array<Array<String>> = []
        
        for a in pinyinSort {
            if a.length >= 1 {
                let x = a.toPinyin().substring(to: a.index(a.startIndex, offsetBy: 1))
                if initial != x {
                    if !arr.isEmpty {
                        result.append(arr)
                    }
                    arr.removeAll()
                    initial = x
                }
                arr.append(a)
            }
        }
        result.append(arr)
        
        print(result)
        return result
    }
}
