//
//  WNUserAPI.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/25.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit
import SwiftyJSON

class WNUserAPI: WNHttpClient {
    
    class func getRegisterMessage(status: Int) -> String {
        switch status {
        case 10000:
            return "恭喜您,注册成功"
        case 10001:
            return "该邮箱已被注册"
        case 10002:
            return "注册时参数错误"
        default:
            return "注册失败"
        }
    }
    
    class func getLoginMessage(status: Int) -> String {
        switch status {
        case 10000:
            return "登录成功"
        default:
            return "登录失败"
        }
    }
    
    
    /// 注册账号
    ///
    /// - Parameters:
    ///   - account: 邮箱
    ///   - userName: 用户名
    ///   - password: 密码
    ///   - openId: 第三方openId
    ///   - type: 第三方平台类型
    ///   - head: 头像
    ///   - success: 成功
    ///   - fail: 失败
    class func signUp(account: String,
                      userName: String,
                      password: String,
                      openId: String? = nil,
                      type: String? = nil,
                      head: String? = nil,
                      success: ((_ message: String) -> Void)?,
                      fail: ((_ message: String)-> Void)?,
                      finish:(()-> Void)?) -> Void {
        
        var param = ["email" : account,
                     "nickname" : userName,
                     "password" : password]
        if let openId = openId {
            param["openid"] = openId
        }
        if let type = type {
            param["type"] = type
        }
        if let head = head {
            param["head"] = head
        }
        
        self.post(subURL: WNConfig.Path.register, param: param, handle: { (data) -> JSON? in
            if !(data is JSON) {
                return nil
            }
            return data as? JSON
        }, success: { (json) in
            guard let json = json else {
                if let fail = fail {
                    fail(WNUserAPI.getRegisterMessage(status: -1))
                    return
                }
                return
            }
            
            let msg: Int = json["msg"].intValue
            let message: String = WNUserAPI.getRegisterMessage(status: msg)
            if msg == 10000 {
                if let success = success {
                    success(message)
                }
            } else if msg == 10001 || msg == 10002 {
                if let fail = fail {
                    fail(message)
                }
            } else {
                if let fail = fail {
                    fail(message)
                }
            }
            
        }, fail: { (error) in
            if let fail = fail {
                fail(WNUserAPI.getRegisterMessage(status: -1))
            }
        }) { () in
            if let finish = finish {
                finish()
            }
        }
    }
    
    
    /// 邮箱登录
    ///
    /// - Parameters:
    ///   - account: 账号
    ///   - password: 密码
    ///   - success: 成功
    ///   - fail: 失败
    ///   - finish: 完成
    class func signIn(account: String,
                      password: String,
                      success: ((_ message: String, _ model: WNUserModel) -> Void)?,
                      fail: ((_ message: String)-> Void)?,
                      finish:(()-> Void)?) -> Void {
        
        guard let emailValue = account.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let passwordValue = password.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        
        let param = ["email": emailValue,
                     "password": passwordValue]
        
        self.post(subURL: WNConfig.Path.signIn, param: param, handle: { (data) -> JSON? in
            
            if !(data is JSON) {
                return nil
            }
            return data as? JSON
            
        }, success: { (json) in
            
            guard let json = json else {
                if let fail = fail {
                    fail("登录失败")
                    return
                }
                return
            }
            
            let msg: Int = json["msg"].intValue
            let message: String = WNUserAPI.getLoginMessage(status: msg)
            if msg == 10000 {
                
                // 成功之后构建模型,并且向沙盒中存储
                let userModel = WNUserModel.init(response: json)
                WNUserModel.writeToSandBox(dictionary: json.dictionaryObject)
                
                if let success = success {
                    success(message, userModel)
                }
            } else {
                if let fail = fail {
                    fail(WNUserAPI.getLoginMessage(status: -1))
                }
            }
            
        }, fail: { (error) in
            if let fail = fail {
                fail(WNUserAPI.getLoginMessage(status: -1))
            }
        }) { () in
            if let finish = finish {
                finish()
            }
        }
        
    }
}
