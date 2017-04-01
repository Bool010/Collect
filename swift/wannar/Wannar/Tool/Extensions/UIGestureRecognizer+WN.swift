//
//  WNGestureRecognizer.swift
//  Wannar
//
//  Created by 付国良 on 2016/11/24.
//  Copyright © 2016年 玩哪儿. All rights reserved.
//

import Foundation
import UIKit

private extension Selector {
    
    static let runGesture = #selector(WNActionSingleton.runGesture(_:))
    
}

public protocol WNActionGestureRecognizer {}

public extension WNActionGestureRecognizer where Self: UIGestureRecognizer {
    
    typealias SpecificGestureClosure = (Self) -> ()
    
    
    internal func castedActionKitGestureClosure(_ gesture: Self, closure: @escaping SpecificGestureClosure) -> WNActionClosure {
        return WNActionClosure.withGestureParam( { (gestr: UIGestureRecognizer) in
            closure(gesture)
        })
    }
    
    
    init(name: String = "", closureWithGesture: @escaping SpecificGestureClosure) {
        
        self.init(target: WNActionSingleton.sharedInstance, action: .runGesture)
        let akClosure = castedActionKitGestureClosure(self, closure: closureWithGesture)
        WNActionSingleton.sharedInstance.addGestureClosure(self, name: name, closure: akClosure)
        
    }
    
    
    func addClosure(_ name: String, closureWithGesture: @escaping SpecificGestureClosure) {
        
        let akClosure = castedActionKitGestureClosure(self, closure: closureWithGesture)
        WNActionSingleton.sharedInstance.addGestureClosure(self, name: name, closure: akClosure)
        
    }
}

extension UIGestureRecognizer: WNActionGestureRecognizer {}

public extension UIGestureRecognizer {
    
    convenience init(name: String = "", closure: @escaping () -> ()) {
        
        self.init(target: WNActionSingleton.sharedInstance, action: .runGesture)
        WNActionSingleton.sharedInstance.addGestureClosure(self, name: name, closure: .noParam(closure))
        
    }
    
    
    func addClosure(_ name: String, closure: @escaping () -> ()) {
        
        WNActionSingleton.sharedInstance.addGestureClosure(self, name: name, closure: .noParam(closure))
        
    }
    
    func removeClosure(_ name: String) {
        
        if !WNActionSingleton.sharedInstance.canRemoveGesture(self) {
            print("can remove a gesture closure")
            WNActionSingleton.sharedInstance.removeGesture(self, name: name)
        } else {
            WNActionSingleton.sharedInstance.removeGesture(self, name: name)
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runGesture)
        }
        
    }
}
