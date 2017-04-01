//
//  WNBarButtonItem.swift
//  Wannar
//
//  Created by 付国良 on 2016/11/24.
//  Copyright © 2016年 玩哪儿. All rights reserved.
//

import Foundation
import UIKit

private extension Selector {
    
    static let runBarButtonItem = #selector(WNActionSingleton.runBarButtonItem(_:))
    
}

public extension UIBarButtonItem {
    
    convenience init(image: UIImage, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItemStyle = .plain, actionClosure: @escaping () -> Void) {
        self.init(image: image,
                  landscapeImagePhone: landscapeImagePhone,
                  style: style,
                  target: WNActionSingleton.sharedInstance,
                  action: .runBarButtonItem)
        addActionClosure(actionClosure)
    }
    
    
    convenience init(title: String, style: UIBarButtonItemStyle = .plain, actionClosure: @escaping () -> Void) {
        self.init(title: title,
                  style: style,
                  target: WNActionSingleton.sharedInstance,
                  action: .runBarButtonItem)
        addActionClosure(actionClosure)
    }
    
    
    convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, actionClosure: @escaping () -> Void) {
        self.init(barButtonSystemItem: systemItem,
                  target: WNActionSingleton.sharedInstance,
                  action: .runBarButtonItem)
        addActionClosure(actionClosure)
    }
    
    
    fileprivate func addActionClosure(_ actionClosure: @escaping () -> Void) {
        WNActionSingleton.sharedInstance.addBarButtonItemClosure(self, closure: .noParam(actionClosure))
    }
    
    
    
    
    
    
    convenience init(image: UIImage, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItemStyle = .plain, closureWithItem: @escaping (UIBarButtonItem) -> Void) {
        self.init(image: image,
                  landscapeImagePhone: landscapeImagePhone,
                  style: style,
                  target: WNActionSingleton.sharedInstance,
                  action: .runBarButtonItem)
        
        addActionClosure(closureWithItem)
    }
    
    convenience init(title: String, style: UIBarButtonItemStyle = .plain, closureWithItem: @escaping (UIBarButtonItem) -> Void) {
        self.init(title: title,
                  style: style,
                  target: WNActionSingleton.sharedInstance,
                  action: .runBarButtonItem)
        addActionClosure(closureWithItem)
    }
    
    
    convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, closureWithItem: @escaping (UIBarButtonItem) -> Void) {
        self.init(barButtonSystemItem: systemItem,
                  target: WNActionSingleton.sharedInstance,
                  action: .runBarButtonItem)
        addActionClosure(closureWithItem)
    }
    
    
    fileprivate func addActionClosure(_ actionClosure: @escaping (UIBarButtonItem) -> Void) {
        WNActionSingleton.sharedInstance.addBarButtonItemClosure(self, closure: .withBarBtnItemParam(actionClosure))
    }
    
    func removeActionClosure() {
        WNActionSingleton.sharedInstance.removeBarButtonItemClosure(self)
    }
}
