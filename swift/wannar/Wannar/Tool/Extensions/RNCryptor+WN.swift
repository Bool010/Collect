//
//  RNCryptor+WN.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/15.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation
import RNCryptor

extension RNCryptor {
    
    static func encrypt(_ string: String, password: String) -> String {
        
        let data = string.data(using: .utf8)
        if var data = data {
            data = RNCryptor.encrypt(data: data, withPassword: password)
            return data.base64EncodedString(options: .lineLength64Characters)
        } else {
            return string
        }
    }
    
    static func decrypt(_ string: String, password: String) -> Data? {
        
        let data = Data.init(base64Encoded: string, options: .ignoreUnknownCharacters)
        if let data = data {
            do {
                let originalData = try RNCryptor.decrypt(data: data, withPassword: password)
                return originalData
            } catch {
                print(error)
                return nil
            }
        } else {
            return nil
        }
    }
}
