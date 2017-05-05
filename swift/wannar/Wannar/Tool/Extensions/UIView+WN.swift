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
        let navigationView = UIView.init()
        navigationView.backgroundColor = UIColor.white
        self.addSubview(navigationView)
        navigationView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().offset(0.0)
            make.height.equalTo(64.0)
        }
        
        
        /// Left Btn
        let leftBtn = UIButton.init()
        navigationView.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview().offset(0.0)
            make.top.equalToSuperview().offset(20.0)
            make.width.equalTo(50.0)
        }
        
        
        /// Right Btn
        let rightBtn = UIButton.init()
        navigationView.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview().offset(0.0)
            make.top.equalToSuperview().offset(20.0)
            make.width.equalTo(50.0)
        }
        
        
        /// Title Label
        let titleLabel = UILabel.init()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .textColor
        titleLabel.textAlignment = .center
        navigationView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftBtn.snp.right).offset(0.0)
            make.right.equalTo(rightBtn.snp.left).offset(0.0)
            make.top.equalToSuperview().offset(20.0)
            make.bottom.equalToSuperview().offset(0.0)
        }
        
        
        /// Line View
        let lineView = UIView.init()
        lineView.backgroundColor = .separatorColor
        navigationView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0.0)
            make.height.equalTo(0.5)
        }
        
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
