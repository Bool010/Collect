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
    
    class func set(fontName: String, label: UILabel, size: CGFloat) {
        
        let descs = creatFontDescriptor(fontName: fontName)
        CTFontDescriptorMatchFontDescriptorsWithProgressHandler(descs, nil) { (state, progress) -> Bool in
            if (state == CTFontDescriptorMatchingState.didMatch) {
                DispatchQueue.main.sync {
                    label.font = UIFont.init(name: fontName, size: size)
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
