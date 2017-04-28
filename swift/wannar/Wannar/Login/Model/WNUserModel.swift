//
//  WNUserModel.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/25.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit
import SwiftyJSON

struct WNUserModel {
    
    var id = ""
    var account: String = ""
    var name: String = ""
    var sinaID: String = ""
    var qqID: String = ""
    var wechatID: String = ""
    var credit: String = "0"
    var head: String?
    var total: String = ""
    
    init(response: JSON?) {
        
        guard let response = response else { return }
        
        id = response["uid"].stringValue
        account = response["uemail"].stringValue
        name = response["uname"].stringValue
        sinaID = response["user_weiboid"].stringValue
        qqID = response["user_qqid"].stringValue
        wechatID = response["user_weixinid"].stringValue
        credit = response["ucredit"].stringValue
        head = response["uhead"].stringValue
        total = response["utotal"].stringValue
    }
    
    static func writeToSandBox(dictionary: (Dictionary<String, Any>)?) -> Void {
        
        guard let dictionary = dictionary else { return }
        let dic = dictionary.deleteNull()
        let userDefault = UserDefaults.standard
        userDefault.set(dic, forKey: WNConfig.SandboxKey.userModel)
        userDefault.synchronize()
    }
    
    
    static func selectLocalModel() -> WNUserModel? {
        
        guard let model = UserDefaults.standard.object(forKey: WNConfig.SandboxKey.userModel) else { return nil }
        if model is Dictionary<String, Any> {
            return WNUserModel.init(response: JSON(model))
        } else {
            return nil
        }
    }
}
