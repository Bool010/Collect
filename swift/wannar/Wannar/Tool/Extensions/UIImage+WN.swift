//
//  UIImage+WN.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/24.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation
import UIKit
extension UIImage {
    
    func imageBy(tintColor: UIColor) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let rect = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        tintColor.set()
        UIRectFill(rect)
        self.draw(at: CGPoint.init(x: 0, y: 0), blendMode: .destinationIn, alpha: 1)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
