//
//  NSNotification+WN.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/14.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation


extension NotificationCenter {
    
    class func post(name: String) -> Void {
        
        NotificationCenter.post(name: name,
                                object: nil)
    }
    
    
    class func post(name: String,
                    object: Any?) -> Void {
        
        NotificationCenter.default.post(name: Foundation.Notification.Name(rawValue: name),
                                        object: object)
    }
    
    
    class func addObserver(_ observer: Any,
                           selector aSelector: Selector,
                           name aName: String) -> Void {
        
        NotificationCenter.addObserver(observer,
                                       selector: aSelector,
                                       name: aName,
                                       object: nil)
    }
    
    
    class func addObserver(_ observer: Any,
                           selector aSelector: Selector,
                           name aName: String,
                           object anObject: Any?) -> Void {
        
        NotificationCenter.default.addObserver(observer,
                                               selector: aSelector,
                                               name: NSNotification.Name(rawValue: aName),
                                               object: anObject)
    }
    
    
    class func addObserver(name aName: String,
                           object anObject: Any?,
                           closure anClosure: @escaping ((Notification) -> Void)) {
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: aName),
                                               object: anObject,
                                               queue: nil,
                                               using: anClosure)
    }
    
    
    class func addObserver(name aName: String,
                           closure anClosure: @escaping ((Notification) -> Void)) {
        
        NotificationCenter.addObserver(name: aName,
                                       object: nil,
                                       closure: anClosure)
    }
}
