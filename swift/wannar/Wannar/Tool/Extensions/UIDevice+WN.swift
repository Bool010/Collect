//
//  UIDevice+WN.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/15.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    
    /// 获取UIID
    ///
    /// - Returns: uuid String
    static func uuidString() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
}
