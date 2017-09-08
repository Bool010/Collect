//
//  WNButton.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/17.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

public enum WNButtonImagePosition {
    case top
    case left
    case bottom
    case right
}

class WNButton: UIView {
    
    var click: (() -> Void)?
    var titleLabel: UILabel!
    var imageView: UIImageView!
    var imageSize: CGSize = CGSize.init(width: 30.0, height: 30.0)
    var space = 5.0
    fileprivate var tap: UITapGestureRecognizer!
    var isEnable: Bool = true {
        didSet {
            tap.isEnabled = isEnable
        }
    }

    var position: WNButtonImagePosition {
        get {
            return pos
        } set {
            switch position {
            case .top:
                self.setTop()
            case .left:
                self.setLeft()
            case .bottom:
                self.setBottom()
            case .right:
                self.setRight()
            }
        }
    }
    var pos: WNButtonImagePosition = .top
    
    private var containerView: UIView!
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(imagePosition: WNButtonImagePosition, imageSize: CGSize) {
        self.init()
        self.buildUI()
        self.imageSize = imageSize
        pos = imagePosition
        position = imagePosition
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Method
    fileprivate func buildUI() -> Void {
        
        /// Container View
        self.containerView = UIView.init()
        self.addSubview(containerView)
        self.containerView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        /// Title Label
        self.titleLabel = UILabel.init()
        self.titleLabel.textAlignment = .center
        self.containerView.addSubview(titleLabel)
        
        /// Image View
        self.imageView = UIImageView.init()
        self.containerView.addSubview(imageView)
        
        tap = UITapGestureRecognizer.init(target: self, action: #selector(buttonClick(tap:)))
        self.addGestureRecognizer(tap)
    }

    @objc fileprivate func buttonClick(tap: UITapGestureRecognizer) -> Void {
        
        if let click = click {
            click()
        }
        tap.isEnabled = false
        DispatchQueue.delay(2.5) { 
            tap.isEnabled = true
        }
        print("------")
    }
    
    fileprivate func setTop() -> Void {
        self.titleLabel.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalToSuperview().offset(0.0)
            make.left.right.bottom.equalToSuperview().offset(0.0)
        })
        self.imageView.snp.makeConstraints { [weak self] (make) in
            if let strongSelf = self {
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(0.0)
                make.size.equalTo(strongSelf.imageSize)
                make.bottom.equalTo(strongSelf.titleLabel.snp.top).offset(-strongSelf.space)
            }
        }
    }
    
    fileprivate func setBottom() -> Void {
        self.titleLabel.snp.makeConstraints({ (make) in
            make.left.right.top.equalToSuperview().offset(0.0)
        })
        self.imageView.snp.makeConstraints { [weak self] (make) in
            if let strongSelf = self {
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().offset(0.0)
                make.size.equalTo(strongSelf.imageSize)
                make.top.equalTo(strongSelf.titleLabel.snp.bottom).offset(strongSelf.space)
            }
        }
    }
    
    fileprivate func setRight() -> Void {
        self.titleLabel.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(0.0)
            make.centerY.equalToSuperview()
        })
        self.imageView.snp.makeConstraints { [weak self] (make) in
            if let strongSelf = self {
                make.right.equalToSuperview().offset(0.0)
                make.left.equalTo(strongSelf.titleLabel.snp.right).offset(strongSelf.space)
                make.size.equalTo(strongSelf.imageSize)
                make.top.bottom.equalToSuperview().offset(0.0)
            }
        }
    }
    
    fileprivate func setLeft() -> Void {
        self.titleLabel.snp.makeConstraints({ (make) in
            make.right.equalToSuperview().offset(0.0)
            make.centerY.equalToSuperview()
        })
        self.imageView.snp.makeConstraints { [weak self] (make) in
            if let strongSelf = self {
                make.left.equalToSuperview().offset(0.0)
                make.right.equalTo(strongSelf.titleLabel.snp.right).offset(strongSelf.space)
                make.size.equalTo(strongSelf.imageSize)
                make.top.bottom.equalToSuperview().offset(0.0)
            }
        }
    }
}
