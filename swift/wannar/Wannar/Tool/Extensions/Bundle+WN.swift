//
//  Bundle+WN.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/21.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation

extension Bundle {
    
    open class var displayName: String? {
        if let dic = Bundle.main.infoDictionary {
            return dic["CFBundleName"] as? String
        } else {
            return nil
        }
    }
    
    open class var identifier: String? {
        if let dic = Bundle.main.infoDictionary {
            return dic["CFBundleIdentifier"] as? String
        } else {
            return nil
        }
    }
    
    open class var shortVersion: String? {
        if let dic = Bundle.main.infoDictionary {
            return dic["CFBundleShortVersionString"] as? String
        } else {
            return nil
        }
    }

    open class var minimumOSVersion: String? {
        if let dic = Bundle.main.infoDictionary {
            return dic["MinimumOSVersion"] as? String
        } else {
            return nil
        }
    }
    
    open class var platformVersion: String? {
        if let dic = Bundle.main.infoDictionary {
            return dic["DTPlatformVersion"] as? String
        } else {
            return nil
        }
    }
    
}
