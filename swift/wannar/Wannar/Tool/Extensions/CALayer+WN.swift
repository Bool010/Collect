//
//  CALayer+WN.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/28.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation
import UIKit

enum WNGradientDirection {
    case right
    case left
    case bottom
    case top
    case topLeftToBottomRight
    case topRightToBottomLeft
    case bottomLeftToTopRight
    case bottomRightToTopLeft
}

extension CAGradientLayer {

    func set(direction: WNGradientDirection) {
        switch direction {
        case .right:
            self.startPoint = CGPoint.init(x: 0.0, y: 0.5)
            self.endPoint = CGPoint.init(x: 1.0, y: 0.5)
            
        case .left:
            self.startPoint = CGPoint.init(x: 1.0, y: 0.5)
            self.endPoint = CGPoint.init(x: 0.0, y: 0.5)
            
        case .bottom:
            self.startPoint = CGPoint.init(x: 0.5, y: 0.0)
            self.endPoint = CGPoint.init(x: 0.5, y: 1.0)
            
        case .top:
            self.startPoint = CGPoint.init(x: 0.5, y: 1.0)
            self.endPoint = CGPoint.init(x: 0.5, y: 0.0)
            
        case .topLeftToBottomRight:
            self.startPoint = CGPoint.init(x: 0.0, y: 0.0)
            self.endPoint = CGPoint.init(x: 1.0, y: 1.0)
            
        case .topRightToBottomLeft:
            self.startPoint = CGPoint.init(x: 1.0, y: 0.0)
            self.endPoint = CGPoint.init(x: 0.0, y: 1.0)
            
        case .bottomLeftToTopRight:
            self.startPoint = CGPoint.init(x: 0.0, y: 1.0)
            self.endPoint = CGPoint.init(x: 1.0, y: 0.0)
            
        case .bottomRightToTopLeft:
            self.startPoint = CGPoint.init(x: 1.0, y: 1.0)
            self.endPoint = CGPoint.init(x: 0.0, y: 0.0)
        }
    }
}
