//
//  Bundle+WN.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/21.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation

extension Bundle {
    
    class func infoDictionary() -> [String : Any]? {
        
        return Bundle.main.infoDictionary
    }
    
    
    class func displayName() -> String? {
        if let dic = Bundle.infoDictionary() {
            return dic["CFBundleName"] as? String
        } else {
            return nil
        }
    }
    
    class func identifier() -> String? {
        if let dic = Bundle.infoDictionary() {
            return dic["CFBundleIdentifier"] as? String
        } else {
            return nil
        }
    }
    
    class func shortVersion() -> String? {
        if let dic = Bundle.infoDictionary() {
            return dic["CFBundleShortVersionString"] as? String
        } else {
            return nil
        }
    }

    class func minimumOSVersion() -> String? {
        if let dic = Bundle.infoDictionary() {
            return dic["MinimumOSVersion"] as? String
        } else {
            return nil
        }
    }
    
    class func platformVersion() -> String? {
        if let dic = Bundle.infoDictionary() {
            return dic["DTPlatformVersion"] as? String
        } else {
            return nil
        }
    }
    
}
