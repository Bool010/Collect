//
//  UIFont+WN.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/20.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation
import UIKit
import CoreText

extension UIFont {
    
    struct Style {
        static var h1: UIFont { get { return .boldSystemFont(ofSize: 22.0) } }
        static var h2: UIFont { get { return .boldSystemFont(ofSize: 20.0) } }
        static var h3: UIFont { get { return .boldSystemFont(ofSize: 18.0) } }
        static var h4: UIFont { get { return .boldSystemFont(ofSize: 16.0) } }
        static var h5: UIFont { get { return .boldSystemFont(ofSize: 14.0) } }
        static var h6: UIFont { get { return .boldSystemFont(ofSize: 12.0) } }
        
        static var p1: UIFont { get { return .systemFont(ofSize: 22.0) } }
        static var p2: UIFont { get { return .systemFont(ofSize: 20.0) } }
        static var p3: UIFont { get { return .systemFont(ofSize: 18.0) } }
        static var p4: UIFont { get { return .systemFont(ofSize: 16.0) } }
        static var p5: UIFont { get { return .systemFont(ofSize: 14.0) } }
        static var p6: UIFont { get { return .systemFont(ofSize: 12.0) } }
        static var p7: UIFont { get { return .systemFont(ofSize: 10.0) } }
        static var p8: UIFont { get { return .systemFont(ofSize: 8.0)  } }
    }
}


extension UIFont {
    
    class func creatFontDescriptor(fontName: String) -> NSMutableArray {
        
        let attrs = NSMutableDictionary.init(dictionary: [kCTFontNameAttribute : fontName])
        let desc:CTFontDescriptor? = CTFontDescriptorCreateWithAttributes(attrs)
        let descs = NSMutableArray.init(capacity: 0)
        descs.add(desc!)
        return descs
    }
    
    class func download(fontName: String) {

        let descs = creatFontDescriptor(fontName: fontName)
        CTFontDescriptorMatchFontDescriptorsWithProgressHandler(descs, nil) { (state, progress) -> Bool in
            return true;
        }
    }
    
    class func set(fontName: String, control: AnyObject, size: CGFloat) {
        
        let descs = creatFontDescriptor(fontName: fontName)
        CTFontDescriptorMatchFontDescriptorsWithProgressHandler(descs, nil) { (state, progress) -> Bool in
            if (state == CTFontDescriptorMatchingState.didMatch) {
                DispatchQueue.main.sync {
                    if control is UILabel {
                        (control as! UILabel).font = UIFont.init(name: fontName, size: size)
                    }
                    else if control is UITextField {
                        (control as! UITextField).font = UIFont.init(name: fontName, size: size)
                    }
                    else if control is UIButton {
                        (control as! UIButton).titleLabel?.font = UIFont.init(name: fontName, size: size)
                    }
                    else {
                        wn_debugMessage("Set Font 出现未处理的类型")
                    }
                }
            }
            return true;
        }
    }
    
    class func didMatch(fontName: String, handle: (() -> Void)?) {
        let descs = creatFontDescriptor(fontName: fontName)
        CTFontDescriptorMatchFontDescriptorsWithProgressHandler(descs, nil) { (state, progress) -> Bool in
            if (state == CTFontDescriptorMatchingState.didMatch) {
                DispatchQueue.main.sync {
                    if let handle = handle {
                        handle()
                    }
                }
            }
            return true;
        }
    }
}
