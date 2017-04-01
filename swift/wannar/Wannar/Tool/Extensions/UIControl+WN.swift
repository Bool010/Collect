//
//  WNControl.swift
//  Wannar
//
//  Created by 付国良 on 2016/11/22.
//  Copyright © 2016年 玩哪儿. All rights reserved.
//

import Foundation
import UIKit

extension UIControlEvents: Hashable {
    public var hashValue: Int {
        return Int(rawValue)
    }
}

private extension Selector {
    
    // All 19 UIControlEvents
    static let runClosureTouchDown              = #selector(WNActionSingleton.runClosureTouchDown(_:))
    static let runClosureTouchDownRepeat        = #selector(WNActionSingleton.runClosureTouchDownRepeat(_:))
    static let runClosureTouchDragInside        = #selector(WNActionSingleton.runClosureTouchDragInside(_:))
    static let runClosureTouchDragOutside       = #selector(WNActionSingleton.runClosureTouchDragOutside(_:))
    static let runClosureTouchDragEnter         = #selector(WNActionSingleton.runClosureTouchDragEnter(_:))
    static let runClosureTouchDragExit          = #selector(WNActionSingleton.runClosureTouchDragExit(_:))
    static let runClosureTouchUpInside          = #selector(WNActionSingleton.runClosureTouchUpInside(_:))
    static let runClosureTouchUpOutside         = #selector(WNActionSingleton.runClosureTouchUpOutside(_:))
    static let runClosureTouchCancel            = #selector(WNActionSingleton.runClosureTouchCancel(_:))
    static let runClosureValueChanged           = #selector(WNActionSingleton.runClosureValueChanged(_:))
    static let runClosureEditingDidBegin        = #selector(WNActionSingleton.runClosureEditingDidBegin(_:))
    static let runClosureEditingChanged         = #selector(WNActionSingleton.runClosureEditingChanged(_:))
    static let runClosureEditingDidEnd          = #selector(WNActionSingleton.runClosureEditingDidEnd(_:))
    static let runClosureEditingDidEndOnExit    = #selector(WNActionSingleton.runClosureEditingDidEndOnExit(_:))
    static let runClosureAllTouchEvents         = #selector(WNActionSingleton.runClosureAllTouchEvents(_:))
    static let runClosureAllEditingEvents       = #selector(WNActionSingleton.runClosureAllEditingEvents(_:))
    static let runClosureApplicationReserved    = #selector(WNActionSingleton.runClosureApplicationReserved(_:))
    static let runClosureSystemReserved         = #selector(WNActionSingleton.runClosureSystemReserved(_:))
    static let runClosureAllEvents              = #selector(WNActionSingleton.runClosureAllEvents(_:))
    
}

public protocol WNActionControl {}

public extension WNActionControl where Self: UIControl {
    
    typealias SpecificControlClosure = (Self) -> ()
    
    internal func castedActionControlClosure(_ control: Self, closure: @escaping SpecificControlClosure) -> WNActionClosure {
        return WNActionClosure.withCotrolParam( { (ctrl: UIControl) in
            closure(control)
        })
    }
    
    func addControlEvent(_ controlEvents: UIControlEvents, closureWithControl: @escaping SpecificControlClosure) {
        let akClosure = castedActionControlClosure(self, closure: closureWithControl)
        self.addControlEvent(controlEvents, actionKitClosure: akClosure)
    }

}

extension UIControl: WNActionControl {}

public extension UIControl {
    
    func removeControlEvent(_ controlEvents: UIControlEvents) {
        
        switch controlEvents {
            
        case let x where x.contains(.touchDown):
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchDown, for: controlEvents)
            
        case let x where x.contains(.touchDownRepeat):
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchDownRepeat, for: controlEvents)
            
        case let x where x.contains(.touchDragInside):
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchDragInside, for: controlEvents)
            
        case let x where x.contains(.touchDragOutside):
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchDragOutside, for: controlEvents)
            
        case let x where x.contains(.touchDragEnter):
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchDragEnter, for: controlEvents)
            
        case let x where x.contains(.touchDragExit):
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchDragExit, for: controlEvents)
            
        case let x where x.contains(.touchUpInside):
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchUpInside, for: controlEvents)
            
        case let x where x.contains(.touchUpOutside):
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchUpOutside, for: controlEvents)
            
        case let x where x.contains(.touchCancel):
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchCancel, for: controlEvents)
            
        case let x where x.contains(.valueChanged):
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureValueChanged, for: controlEvents)
            
        case let x where x.contains(.editingDidBegin):
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureEditingDidBegin, for: controlEvents)
            
        case let x where x.contains(.editingChanged):
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureEditingChanged, for: controlEvents)
            
        case let x where x.contains(.editingDidEnd):
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureEditingDidEnd, for: controlEvents)
            
        case let x where x.contains(.editingDidEndOnExit):
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureEditingDidEndOnExit, for: controlEvents)
            
        case let x where x.contains(.allTouchEvents):
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureAllTouchEvents, for: controlEvents)
            
        case let x where x.contains(.allEditingEvents):
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureAllEditingEvents, for: controlEvents)
            
        case let x where x.contains(.applicationReserved):
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureApplicationReserved, for: controlEvents)
            
        case let x where x.contains(.systemReserved):
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureSystemReserved, for: controlEvents)
            
        case let x where x.contains(.allEvents):
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureAllEvents, for: controlEvents)
            
        default:
            self.removeTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchUpInside, for: controlEvents)
        }
        
        WNActionSingleton.sharedInstance.removeAction(self, controlEvent: controlEvents)
        
    }
    
    func handleEvent(_ controlEvents: UIControlEvents, closure: @escaping () -> ()) {
        self.addControlEvent(controlEvents, actionKitClosure: .noParam(closure))
    }
    
    fileprivate func addControlEvent(_ controlEvents: UIControlEvents, actionKitClosure: WNActionClosure) {
        
        switch controlEvents {
            
        case let x where x.contains(.touchDown):
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchDown, for: controlEvents)
            
        case let x where x.contains(.touchDownRepeat):
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchDownRepeat, for: controlEvents)
            
        case let x where x.contains(.touchDragInside):
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchDragInside, for: controlEvents)
            
        case let x where x.contains(.touchDragOutside):
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchDragOutside, for: controlEvents)
            
        case let x where x.contains(.touchDragEnter):
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchDragEnter, for: controlEvents)
            
        case let x where x.contains(.touchDragExit):
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchDragExit, for: controlEvents)
            
        case let x where x.contains(.touchUpInside):
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchUpInside, for: controlEvents)
            
        case let x where x.contains(.touchUpOutside):
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchUpOutside, for: controlEvents)
            
        case let x where x.contains(.touchCancel):
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchCancel, for: controlEvents)
            
        case let x where x.contains(.valueChanged):
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureValueChanged, for: controlEvents)
            
        case let x where x.contains(.editingDidBegin):
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureEditingDidBegin, for: controlEvents)
            
        case let x where x.contains(.editingChanged):
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureEditingChanged, for: controlEvents)
            
        case let x where x.contains(.editingDidEnd):
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureEditingDidEnd, for: controlEvents)
            
        case let x where x.contains(.editingDidEndOnExit):
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureEditingDidEndOnExit, for: controlEvents)
            
        case let x where x.contains(.allTouchEvents):
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureAllTouchEvents, for: controlEvents)
            
        case let x where x.contains(.allEditingEvents):
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureAllEditingEvents, for: controlEvents)
            
        case let x where x.contains(.applicationReserved):
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureApplicationReserved, for: controlEvents)
            
        case let x where x.contains(.systemReserved):
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureSystemReserved, for: controlEvents)
            
        case let x where x.contains(.allEvents):
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureAllEvents, for: controlEvents)
            
        default:
            self.addTarget(WNActionSingleton.sharedInstance, action: .runClosureTouchUpInside, for: controlEvents)
        }
        
        WNActionSingleton.sharedInstance.addAction(self, controlEvent: controlEvents, closure: actionKitClosure)
    }
}
