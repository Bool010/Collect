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

    
    /// 获取字符串的第几个字符
    ///
    /// - Parameter index: 从0开始的索引
    public subscript(_ index: Int) -> String? {
        return self.substring(WNRange.init(index, 1))
    }
    
    func substring(_ range: WNRange) -> String? {
        if self.length > range.start {
            let startIndex = self.index(self.startIndex, offsetBy: range.start)
            let endIndex = self.index(self.startIndex, offsetBy: range.start+range.length)
            return self[startIndex..<endIndex]
        } else {
            return nil
        }
    }
    
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
    
    
    /// 邮箱验证
    func isEmail() -> Bool {
        return validateText(type: "Email", text: self)
    }
    
    
    /// 手机号码验证
    func isPhone() -> Bool {
        return validateText(type: "Phone", text: self)
    }
    
    
    /// 私有方法：根据正则表达式验证内容
    ///
    /// - Parameters:
    ///   - type: 待验证类型
    ///   - text: 待验证文本
    /// - Returns: Bool
    fileprivate func validateText(type: String, text: String) -> Bool {
        do {
            var pattern: String = ""
            if type == "Email" {
                pattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            }
            if type == "Phone" {
                pattern = "^1[0-9]{10}$"
            }
            let regex: NSRegularExpression = try NSRegularExpression.init(pattern: pattern, options: .caseInsensitive)
            let matches = regex.matches(in: text, options: .reportProgress, range: NSMakeRange(0, text.characters.count))
            return matches.count > 0
        } catch {
            return false
        }
    }
    
    
    /// 一个字符串的第一个字符
    ///
    /// - Returns: 第一个字符
    func first() -> String? {
        if self.length > 1 {
            return self.substring(to: self.index(self.startIndex, offsetBy: 1))
        } else {
            return nil
        }
    }
    
    
    /// 将字符串转换为拼音
    ///
    /// - Parameter transform: 转换方式
    /// - Returns: 转换过后的字符串
    func toPinyin() -> String {
        
        let stringRef = NSMutableString(string: self) as CFMutableString
        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false);
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false);
        let pinyin = stringRef as String;
        return pinyin
    }
}
