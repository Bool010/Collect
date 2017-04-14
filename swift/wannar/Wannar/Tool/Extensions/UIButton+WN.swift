//
//  UIButton+Extension.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/9.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher

public enum WNButtonImagePosition {
    case top
    case left
    case bottom
    case right
}

extension UIButton {
    
    convenience init(title: String?, fontSize: Float?, color: UIColor?) {
        
        self.init()
        if let title = title {
            self.setTitle(title, for: .normal)
        }
        if let size = fontSize {
            self.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(size))
        }
        self.setTitleColor(color, for: .normal)
    }
    
    
    convenience init(image: String?) {
        
        self.init(image: image, mode: nil)
    }
    
    
    convenience init(image: String?, mode: UIViewContentMode?) {
        
        self.init()
        if let image = image {
            self.setImage(UIImage.init(imageLiteralResourceName: image), for: .normal)
        }
        if let mode = mode {
            self.contentMode = mode
        }
    }
}

extension UIButton {

    func set(image: String,
             imageSize: CGSize,
             isURL:Bool = false,
             title: String,
             type: WNButtonImagePosition,
             space: CGFloat) -> Void {
        
        self.setTitle(title, for: .normal)
        if isURL {
            let url = URL.init(string: image)
            self.kf.setImage(with: url, for: .normal)
        } else {
            self.setImage(UIImage(named: image), for: .normal)
        }
        self.imageView?.contentMode = .scaleAspectFill
        
        let imageW: CGFloat = imageSize.width
        let imageH: CGFloat = imageSize.height
        var labelW: CGFloat = 0.0
        var labelH: CGFloat = 0.0
        labelW = self.titleLabel!.intrinsicContentSize.width
        labelH = self.titleLabel!.intrinsicContentSize.height
        
        var imageEdgeInsets :UIEdgeInsets = UIEdgeInsets();
        var labelEdgeInsets :UIEdgeInsets = UIEdgeInsets();
        
        switch type {
        case .top:
//            imageEdgeInsets = UIEdgeInsetsMake(0, (self.frame.size.width - imageW) / 2.0, labelH + space, (self.frame.size.width - imageW) / 2.0)
//            labelEdgeInsets = UIEdgeInsetsMake(-imageH, 0, imageH, 0)
            
            
            imageEdgeInsets = UIEdgeInsetsMake(0,
                                               (self.frame.size.width - imageW) / 2.0,
                                               labelH + space,
                                               (self.frame.size.width - imageW) / 2.0)
            
            labelEdgeInsets = UIEdgeInsetsMake((self.frame.size.width - imageW) / 2.0,
                                               0,
                                               (self.frame.size.width - imageW) / 2.0,
                                               labelH + space)
            
//            imageEdgeInsets = UIEdgeInsetsMake(-labelH - space/2.0, 0, 0, -labelW);
//            labelEdgeInsets = UIEdgeInsetsMake(0, -imageW, -imageH-space/2.0, 0);
            break;
        case .left:
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
            break;
        case .bottom:
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelH-space/2.0, -labelW);
            labelEdgeInsets = UIEdgeInsetsMake(-imageH-space/2.0, -imageW, 0, 0);
            break;
        case .right:
            imageEdgeInsets = UIEdgeInsetsMake(0, labelW+space/2.0, 0, -labelW-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageW-space/2.0, 0, imageW+space/2.0);
            break;
        }
        
        self.titleEdgeInsets = labelEdgeInsets;
        self.imageEdgeInsets = imageEdgeInsets;
    }
    
    
//    private func positionLabelRespectToImage(title: NSString, position: UIViewContentMode, spacing: CGFloat) {
//        let imageSize = self.imageRectForContentRect(self.frame)
//        let titleFont = self.titleLabel?.font!
//        let titleSize = title.sizeWithAttributes([NSFontAttributeName: titleFont!])
//        
//        var titleInsets: UIEdgeInsets
//        var imageInsets: UIEdgeInsets
//        
//        switch (position){
//        case .Top:
//            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing), left: -(imageSize.width), bottom: 0, right: 0)
//            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
//        case .Bottom:
//            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing), left: -(imageSize.width), bottom: 0, right: 0)
//            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
//        case .Left:
//            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
//            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -(titleSize.width * 2 + spacing))
//        case .Right:
//            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
//            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        default:
//            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        }
//        
//        self.titleEdgeInsets = titleInsets
//        self.imageEdgeInsets = imageInsets
//    }

}
