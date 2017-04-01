//
//  WNAction.swift
//  Wannar
//
//  Created by 付国良 on 2016/11/22.
//  Copyright © 2016年 玩哪儿. All rights reserved.
//

import Foundation
import UIKit


typealias WNActionVoidClosure = () -> Void
public typealias WNActionControlClosure = (UIControl) -> Void
public typealias WNActionGestureClosure = (UIGestureRecognizer) -> Void
public typealias WNActionBarBtnItemClosure = (UIBarButtonItem) -> Void


enum WNActionClosure {
    
    case noParam(WNActionVoidClosure)
    case withCotrolParam(WNActionControlClosure)
    case withGestureParam(WNActionGestureClosure)
    case withBarBtnItemParam(WNActionBarBtnItemClosure)
    
}


class WNActionSingleton {
    
    var controlAndEventDic: Dictionary<UIControl, Dictionary<UIControlEvents, WNActionClosure>> = Dictionary()
    var gestureDic: Dictionary<UIGestureRecognizer, [(String, WNActionClosure)]> = Dictionary()
    var barBtnItemDic: Dictionary<UIBarButtonItem, WNActionClosure> = Dictionary()
    
    class var sharedInstance : WNActionSingleton {
        struct WNAction {
            static let instance : WNActionSingleton = WNActionSingleton()
        }
        return WNAction.instance
    }
}


//:
//: # GESTURE ACTIONS
//:
extension WNActionSingleton {
    
    func addGestureClosure(_ gesture: UIGestureRecognizer, name: String, closure: WNActionClosure) -> Void {
        
        if var gestureArr = gestureDic[gesture] {
            gestureArr.append(name, closure)
            gestureDic[gesture] = gestureArr
        } else {
            var newGestureArr = Array<(String, WNActionClosure)>()
            newGestureArr.append(name, closure)
            gestureDic[gesture] = newGestureArr
        }
        
    }
    
    
    func canRemoveGesture(_ gesture: UIGestureRecognizer) -> Bool {
        
        if let gestureArr = gestureDic[gesture] {
            if gestureArr.count == 1 {
                return true
            } else {
                return false
            }
        }
        return false
        
    }
    
    
    func removeGesture(_ gesture: UIGestureRecognizer, name: String) -> Void {
        
        if var gestureArr = gestureDic[gesture] {
            var x: Int = 0
            for (index, gestureTuple) in gestureArr.enumerated() {
                if gestureTuple.0 == name {
                    x = index
                }
            }
            gestureArr.remove(at: x)
            gestureDic[gesture] =  gestureArr
        } else {
            gestureDic.removeValue(forKey: gesture)
        }
    }
    
    @objc(runGesture:)
    func runGesture(_ gesture: UIGestureRecognizer) {
        if let gestureArray = gestureDic[gesture] {
            for possibleClosureTuple in gestureArray {
                
                switch possibleClosureTuple.1 {
                    case .noParam(let closure):
                        closure()
                        break
                    case .withGestureParam(let closure):
                        closure(gesture)
                        break
                    default:
                        break
                }
            }
        }
    }
}

//:
//: # CLOSURE ACTIONS
//:

extension WNActionSingleton {
    
    func addAction(_ control: UIControl, controlEvent: UIControlEvents, closure: WNActionClosure)
    {
        if var innerDict = controlAndEventDic[control] {
            innerDict[controlEvent] = closure
            controlAndEventDic[control] = innerDict
        } else {
            var newDict = Dictionary<UIControlEvents, WNActionClosure>()
            newDict[controlEvent] = closure
            controlAndEventDic[control] = newDict
        }
        
    }
    
    func removeAction(_ control: UIControl, controlEvent: UIControlEvents)
    {
        if var innerDict = controlAndEventDic[control] {
            innerDict.removeValue(forKey: controlEvent);
        }
    }
    

    @objc(runClosureTouchDown:)
    func runClosureTouchDown(_ control: UIControl)
    {
        runAllClosures(control, event: .touchDown)
    }
    
    @objc(runClosureTouchDownRepeat:)
    func runClosureTouchDownRepeat(_ control: UIControl)
    {
        runAllClosures(control, event: .touchDownRepeat)
    }
    
    @objc(runClosureTouchDragInside:)
    func runClosureTouchDragInside(_ control: UIControl)
    {
        runAllClosures(control, event: .touchDragInside)
    }
    
    @objc(runClosureTouchDragOutside:)
    func runClosureTouchDragOutside(_ control: UIControl)
    {
        runAllClosures(control, event: .touchDragOutside)
    }
    
    @objc(runClosureTouchDragEnter:)
    func runClosureTouchDragEnter(_ control: UIControl)
    {
        runAllClosures(control, event: .touchDragEnter)
    }
    
    @objc(runClosureTouchDragExit:)
    func runClosureTouchDragExit(_ control: UIControl)
    {
        runAllClosures(control, event: .touchDragExit)
    }
    
    @objc(runClosureTouchUpInside:)
    func runClosureTouchUpInside(_ control: UIControl)
    {
        runAllClosures(control, event: .touchUpInside)
    }
    
    @objc(runClosureTouchUpOutside:)
    func runClosureTouchUpOutside(_ control: UIControl)
    {
        runAllClosures(control, event: .touchUpOutside)
    }
    
    @objc(runClosureTouchCancel:)
    func runClosureTouchCancel(_ control: UIControl)
    {
        runAllClosures(control, event: .touchCancel)
    }
    
    @objc(runClosureValueChanged:)
    func runClosureValueChanged(_ control: UIControl)
    {
        runAllClosures(control, event: .valueChanged)
    }
    
    @objc(runClosureEditingDidBegin:)
    func runClosureEditingDidBegin(_ control: UIControl)
    {
        runAllClosures(control, event: .editingDidBegin)
    }
    
    @objc(runClosureEditingChanged:)
    func runClosureEditingChanged(_ control: UIControl)
    {
        runAllClosures(control, event: .editingChanged)
    }
    
    @objc(runClosureEditingDidEnd:)
    func runClosureEditingDidEnd(_ control: UIControl)
    {
        runAllClosures(control, event: .editingDidEnd)
    }
    
    @objc(runClosureEditingDidEndOnExit:)
    func runClosureEditingDidEndOnExit(_ control: UIControl)
    {
        runAllClosures(control, event: .editingDidEndOnExit)
    }
    
    @objc(runClosureAllTouchEvents:)
    func runClosureAllTouchEvents(_ control: UIControl)
    {
        runAllClosures(control, event: .allTouchEvents)
    }
    
    @objc(runClosureAllEditingEvents:)
    func runClosureAllEditingEvents(_ control: UIControl)
    {
        runAllClosures(control, event: .allEditingEvents)
    }
    
    @objc(runClosureApplicationReserved:)
    func runClosureApplicationReserved(_ control: UIControl)
    {
        runAllClosures(control, event: .applicationReserved)
    }
    
    @objc(runClosureSystemReserved:)
    func runClosureSystemReserved(_ control: UIControl)
    {
        runAllClosures(control, event: .systemReserved)
    }
    
    @objc(runClosureAllEvents:)
    func runClosureAllEvents(_ control: UIControl)
    {
        runAllClosures(control, event: .allEvents)
    }
    
    
    fileprivate func runAllClosures(_ control: UIControl, event: UIControlEvents)
    {
        if let possibleClosures = controlAndEventDic[control]?.filter({ $0.0.contains(event) }).map({ $0.1 }) {
            for actionKitClosure in possibleClosures {
                switch actionKitClosure {
                case .noParam(let closure):
                    closure()
                    break
                case .withCotrolParam(let closure):
                    closure(control)
                    break
                default:
                    // It shouldn't be a ControlClosure
                    break
                }
            }
        }
    }
}


//
// # UIBARBUTTONITEM ACTIONS
//
extension WNActionSingleton {
    
    func addBarButtonItemClosure(_ barButtonItem: UIBarButtonItem, closure: WNActionClosure)
    {
        barBtnItemDic[barButtonItem] = closure
    }
    
    func removeBarButtonItemClosure(_ barButtonItem: UIBarButtonItem)
    {
        barBtnItemDic[barButtonItem] = nil
    }
    
    @objc(runBarButtonItem:)
    func runBarButtonItem(_ item: UIBarButtonItem)
    {
        guard let actionKitClosure = barBtnItemDic[item] else { return }
        switch actionKitClosure {
        case .noParam(let closure):
            closure()
        case .withBarBtnItemParam(let closure):
            closure(item)
        default:
            // Shouldn't be here
            break
        }
    }
}
