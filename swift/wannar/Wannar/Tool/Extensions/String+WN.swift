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
    
}
