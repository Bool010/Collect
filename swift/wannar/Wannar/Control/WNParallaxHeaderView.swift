//
//  WNParallaxHeaderView.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/22.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNParallaxHeaderView: UIView {

    fileprivate var _heightLayout = NSLayoutConstraint()
    fileprivate var _bottomLayout = NSLayoutConstraint()
    
    fileprivate var _containerView = UIView()
    fileprivate var _containerLayout = NSLayoutConstraint()
    var _imageName: String?
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.buildUI()
    }
    
    convenience init(frame: CGRect, imageName: String) {
        
        self.init(frame: frame)
        _imageName = imageName
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func buildUI() {
        
        self.backgroundColor = UIColor.white
        
        _containerView.translatesAutoresizingMaskIntoConstraints = false
        _containerView.backgroundColor = UIColor.white
        self.addSubview(_containerView)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[containerView]|",
                                                           options: NSLayoutFormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: ["containerView" : _containerView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[containerView]|",
                                                           options: NSLayoutFormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: ["containerView" : _containerView]))
        _containerLayout = NSLayoutConstraint(item: _containerView,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .height,
                                              multiplier: 1.0,
                                              constant: 0.0)
        self.addConstraint(_containerLayout)
        
        // ImageView
        let imageView: UIImageView = UIImageView.init()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.white
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        if let _imageName = _imageName {
            imageView.image = UIImage.init(named: _imageName)
        }
        _containerView.addSubview(imageView)
        _containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|",
                                                                     options: NSLayoutFormatOptions(rawValue: 0),
                                                                     metrics: nil,
                                                                     views: ["imageView" : imageView]))
        _bottomLayout = NSLayoutConstraint(item: imageView,
                                           attribute: .bottom,
                                           relatedBy: .equal,
                                           toItem: _containerView,
                                           attribute: .bottom,
                                           multiplier: 1.0,
                                           constant: 0.0)
        _containerView.addConstraint(_bottomLayout)
        _heightLayout = NSLayoutConstraint(item: imageView,
                                           attribute: .height,
                                           relatedBy: .equal,
                                           toItem: _containerView,
                                           attribute: .height,
                                           multiplier: 1.0,
                                           constant: 0.0)
        _containerView.addConstraint(_heightLayout)
    }
    
    
    // MARK: - PUBLIC -
    public func scrollRefresh(scrollView: UIScrollView) -> Void {
        
        _containerLayout.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top);
        _containerView.clipsToBounds = offsetY <= 0
        _bottomLayout.constant = offsetY >= 0 ? 0 : -offsetY / 2
        _heightLayout.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
