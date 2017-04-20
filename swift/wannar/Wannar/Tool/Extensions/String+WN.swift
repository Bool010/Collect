//
//  WNString.swift
//  Wannar
//
//  Created by 付国良 on 2017/1/3.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
#else
    import Cocoa
#endif

extension String {
    
    /// 将字符串转换为日期
    ///
    /// - Returns: 字符串转换过后的日期
    @discardableResult
    func date() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
    
    
    /// 转换为Float类型
    ///
    /// - Returns: Float
    @discardableResult
    func float() -> Float? {
        return Float(self)
    }
    
    
    /// 转换为Double类型
    ///
    /// - Returns: Double
    @discardableResult
    func double() -> Double? {
        return Double(self)
    }
    
    
    /// 获取APP标题
    ///
    /// - Returns: 去掉'【' \ '】'中间的字符串
    @discardableResult
    func app() -> String {
        let string = self
        if string.isEmpty {
            return ""
        }
        if string.contains("【") && string.contains("】") {
            let range1 = string.range(of: "【")
            let range2 = string.range(of: "】")
            var str = string.substring(with: (range1?.upperBound)! ..< (range2?.lowerBound)!)
            str = "【\(str)】"
            str = string.replacingOccurrences(of: str, with: "")
            return str
        }
        return string;
    }
    
    
    /// 将日期字符串旧的Formatter变为新的Formatter
    ///
    /// - Parameters:
    ///   - oldFormat: 原本的Formatter
    ///   - newFormat: 要转换成的Formatter
    /// - Returns: 新Formatter样式的日期字符串
    func date(oldFormat: String, newFormat: String) -> String {
        let date = Date.init(str: self, format: oldFormat)
        return date.string(format: newFormat)
    }
}
