//
//  WNDepartureAPI.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/15.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation
import SwiftyJSON
import RNCryptor

class WNDepartureAPI: WNHttpClient {
    
    class func select(success: ((WNCityGroupModel) -> Void)? = nil,
                      fail: (()-> Void)? = nil,
                      finish:(()-> Void)? = nil) {
        
        let param: Dictionary<String, Any> = ["key" : RNCryptor.encrypt(UIDevice.uuid ?? "",
                                                                        password: "5.01")]
        
        self.post(subURL: WNConfig.Path.departure, param: param, handle: { (data) -> JSON? in
            if !(data is JSON) {
                return nil
            }
            return data as? JSON
        }, success: { (json) in
            if let json = json {
                let str = json["data"].stringValue
                let data = RNCryptor.decrypt(str, password: UIDevice.uuid ?? "")
                guard let a = data else { return }
                do {
                    let dic = try JSONSerialization.jsonObject(with: a, options: .mutableLeaves)
                    let data: Array<Dictionary<String, Any>> = (dic as! Dictionary<String, Any>)["data"] as! Array<Dictionary<String, Any>>
                    let result = WNCityGroupModel.init(array: data)
                    if let success = success {
                        success(result)
                    }
                } catch {
                    print(error)
                }
            }
            
        }, fail: { (error) in
            if let fail = fail {
                fail()
            }
        }) {
            if let finish = finish {
                finish()
            }
        }
    }
}
