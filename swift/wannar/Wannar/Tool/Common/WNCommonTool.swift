//
//  WNCommonTool.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/9.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit
import Alamofire


/// 开始监测网络状态
func startMonitoringNetwork() -> Void {
    
    let net = NetworkReachabilityManager()
    net?.startListening()
    
    net?.listener = { status in
        WNGlobalVar.shared.isNetworkValid = (net?.isReachable)!
        WNGlobalVar.shared.networkChange?(WNGlobalVar.shared.isNetworkValid)
        wn_debugMessage("网络连接状态:\(String(WNGlobalVar.shared.isNetworkValid))")
    }    
}


/// 当前iOS系统版本是否大于某个版本
///
/// - Parameter version: 版本号
func iOSLater(version: Double) -> Bool {
    
    let systemVersion = UIDevice.current.systemVersion.double()

    if let systemVersion = systemVersion {
        return systemVersion >= version
    } else {
        wn_debugMessage("发生一个#### 错误 ####需要处理, 获取系统版本号转换Double时候出错")
        return false
    }
}

/// 获取当前控制器
func topBoard() -> UIViewController? {
    
    return topBoard(root: UIApplication.shared.keyWindow?.rootViewController)
}

fileprivate func topBoard(root: UIViewController?) -> UIViewController? {
    
    if root is UITabBarController {
        
        return topBoard(root: (root as! UITabBarController).selectedViewController!)
        
    } else if root is UINavigationController {
        
        return topBoard(root: (root as! UINavigationController).visibleViewController)
        
    } else if (root?.presentedViewController != nil) {
        
        return topBoard(root: root?.presentedViewController)
        
    } else {
        
        return root
    }
}


func toJSONString(dict: Dictionary<String, Any>) -> String {

    if (!JSONSerialization.isValidJSONObject(dict)) {
        print("无法解析出JSONString")
        return ""
    }
    let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
    guard data != nil else {
        return ""
    }
    let str = String.init(data: data!, encoding: String.Encoding.utf8)
    guard str != nil else {
        return ""
    }
    return str!
}
