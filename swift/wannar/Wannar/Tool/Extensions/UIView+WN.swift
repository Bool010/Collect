//
//  UIView+WN.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/9.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit


// MARK: - UI
extension UIView {
    
    /// 添加导航栏
    ///
    /// - Parameter closure: 返回左右Button和标题Label
    func addNavigation(closure: ((_ leftBtn: UIButton, _ rightBtn: UIButton, _ titleLabel: UILabel) -> Void)) {
        
        /// Navigation View
        let navigationView = UIView.init(frame: CGRect.init(x: 0.0,
                                                            y: 0.0,
                                                            width: UIScreen.width,
                                                            height: 64.0))
        navigationView.backgroundColor = UIColor.white
        self.addSubview(navigationView)
        
        
        /// Left Btn
        let leftBtn = UIButton.init(frame: CGRect.init(x: 0.0,
                                                       y: 20.0,
                                                       width: 50.0,
                                                       height: 44.0))
        navigationView.addSubview(leftBtn)
        
        
        /// Right Btn
        let rightBtn = UIButton.init(frame: CGRect.init(x: UIScreen.width - 50.0,
                                                        y: 20,
                                                        width: 50,
                                                        height: 44.0))
        navigationView.addSubview(rightBtn)
        
        
        /// Title Label
        let titleLabel = UILabel.init(frame: CGRect.init(x: 50.0,
                                                         y: 20,
                                                         width: UIScreen.width - 100,
                                                         height: 44))
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = UIColor.textColor()
        titleLabel.textAlignment = .center
        navigationView.addSubview(titleLabel)
        
        
        /// Line View
        let lineView = UIView.init(frame: CGRect.init(x: 0.0, y: 63.5, width: UIScreen.width, height: 0.5))
        lineView.backgroundColor = UIColor.separatorColor()
        navigationView.addSubview(lineView)
        
        closure(leftBtn, rightBtn, titleLabel)
    }
}




// MARK: - Common
extension UIView {

    /// 快照
    ///
    /// - Parameters:
    ///   - frame: CGRect
    ///   - opaque: 是否透明, DEFAULT = false
    /// - Returns: 快照image
    func snapshot(frame: CGRect, opaque: Bool = false) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(frame.size, opaque, 0.0)
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: frame.origin.x * -1, y: frame.origin.y * -1)
        
        guard let currentContext = UIGraphicsGetCurrentContext() else { return nil }
        self.layer.render(in: currentContext)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    
    /// 移除所有子控件
    func removeAllSubview() -> Void {
        
        while (self.subviews.count > 0) {
            self.subviews.last?.removeFromSuperview()
        }
    }
}
