//
//  DispatchQueue+WN.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/13.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    typealias Task = (_ cancel: Bool) -> Void
    
    
    /// 延迟执行
    ///
    /// - Parameters:
    ///   - time: 延迟时间
    ///   - task: 闭包函数
    /// - Returns: 返回闭包，用于取消
    @discardableResult
    class func delay(_ time: TimeInterval, task: @escaping () -> ()) -> Task? {
        
        func dispatch_later(block: @escaping () -> ()) {
            let t = DispatchTime.now() + time
            DispatchQueue.main.asyncAfter(deadline: t, execute: block)
        }
        
        var closure: (() -> Void)? = task
        var result: Task?
        
        let delayedClosure: Task = { cancel in
            if let internalClosure = closure {
                if cancel == false {
                    DispatchQueue.main.async(execute: internalClosure)
                }
            }
            closure = nil
            result = nil
        }
        
        result = delayedClosure
        
        dispatch_later {
            if let delayedClosure = result {
                delayedClosure(false)
            }
        }
        
        return result
    }
    
    
    
    /// 取消执行
    ///
    /// - Parameter task: 闭包，用于取消
    func cancel(_ task: Task?) -> Void {
        task?(true)
    }
}
