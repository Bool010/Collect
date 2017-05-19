//
//  WNRegexHelper.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/17.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation

struct WNRegexHelper {
    
    let regex: NSRegularExpression?
    init(_ pattern: String) {
        do {
            try regex = NSRegularExpression.init(pattern: pattern, options: .caseInsensitive)
        } catch _ {
            regex = nil
        }
    }
    
    public func match(input: String) -> Bool {
        
        if let regex = regex {
            return regex.matches(in: input, options: .reportProgress, range: NSMakeRange(0, input.characters.count)).count > 0
        } else {
            return false
        }
    }
    
}
