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
