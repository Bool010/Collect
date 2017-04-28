//
//  Dictionary+WN.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/26.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation
import UIKit

extension Dictionary {
    
    func deleteNull() -> Dictionary<AnyHashable, Any> {
        
        var dictionary: Dictionary<AnyHashable, Any> = self
        
        dictionary.forEach { (key, value) in
            /// Null
            if value is NSNull {
                dictionary.removeValue(forKey: key)
            }
            
            /// 字典
            if value is Dictionary {
                let subdic: Dictionary = value as! Dictionary
                let result = subdic.deleteNull()
                dictionary[key] = result
            }
            
            /// 数组
            if value is Array<Any> {
                
                let array: Array = value as! Array<Any>
                var result: Array<Any> = []
                
                for arrayValue in array {
                    
                    if !(arrayValue is NSNull) {
                        
                        if arrayValue is Dictionary {
                            
                            let subdic: Dictionary = arrayValue as! Dictionary
                            let x = subdic.deleteNull()
                            result.append(x)
                        }
                        result.append(arrayValue)
                    }
                }
                dictionary[key] = result
            }
        }
        
        return dictionary
    }

}
