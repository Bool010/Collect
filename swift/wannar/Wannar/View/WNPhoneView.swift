//
//  WNPhoneView.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/27.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit
import Spring

class WNPhoneView: UIView {
    
    var model: Array<Array<String>>!
    var phoneClick: ((_ phoneNum: String) -> Void)?
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.configModel()
        self.buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Event
    fileprivate func configModel() -> Void {
        
        self.model = [["美国", "888-928-2988"],
                      ["中国", "400-000-2930"],
                      ["香港", "3008-5867"],
                      ["台湾", "02-5592-4871"]]
    }
    
    fileprivate func buildUI() -> Void {
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 8.0
        
        /// Title
        let title = UILabel.init(color: .textColor, fontName: WNConfig.FontName.normal, size: 25.0, textAlignment: .center)
        title.text = "需要帮助？"
        self.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(0.0)
            make.top.equalToSuperview().offset(15.0)
        }
        
        let height = 40.0
        
        /// Phone Number
        for i in 0 ..< self.model.count {
            
            // Text Label
            let textLabel = UILabel.init(color: .textColor, fontName: WNConfig.FontName.normal, size: 20.0, textAlignment: .left)
            self.addSubview(textLabel)
            textLabel.text = self.model[i][0] + ": " + self.model[i][1]
            textLabel.snp.makeConstraints({ (make) in
                make.left.equalToSuperview().offset(30)
                make.right.equalToSuperview().offset(-50.0)
                make.top.equalToSuperview().offset(i.double * height + 60.0)
                make.height.equalTo(height)
            })
            
            // Button
            let btn = UIButton.init()
            self.addSubview(btn)
            btn.snp.makeConstraints({ (make) in
                make.left.right.equalToSuperview().offset(0.0)
                make.top.equalToSuperview().offset(i.double * height + 60.0)
                make.height.equalTo(height)
                if i == self.model.count - 1 {
                    make.bottom.equalToSuperview().offset(-10.0)
                }
            })
            btn.addControlEvent(.touchUpInside, closureWithControl: { [weak self] (btn) in
                guard let _self = self else { return }
                if let phoneClick = _self.phoneClick {
                    phoneClick(_self.model[i][1])
                }
            })
        }
    }
    
    class func show() -> Void {
        
        /// Effect View
        let effectView = UIVisualEffectView(effect: UIBlurEffect.init(style: .dark))
        UIApplication.shared.keyWindow?.addSubview(effectView)
        effectView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview().offset(0.0)
        }
        
        /// Phone View
        let phoneView = WNPhoneView.init()
        phoneView.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        effectView.addSubview(phoneView)
        phoneView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(180.0)
            make.centerX.equalToSuperview()
        }
        
        /// Dismiss Function
        func dismiss(_ completion: (() -> ())? = nil) {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
                phoneView.alpha = 0.0;
                phoneView.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
                effectView.alpha = 0.0
            }, completion: { (isCompletion) in
                if isCompletion {
                    phoneView.removeFromSuperview()
                    effectView.removeFromSuperview()
                    if let completion = completion {
                        completion()
                    }
                }
            })
        }
        
        /// Gesture Recognizer
        effectView.addGestureRecognizer(UITapGestureRecognizer.init(closure: {
            dismiss()
        }))
        
        /// Phone View Click
        phoneView.phoneClick = { (phoneNumber) in
            dismiss({ 
                UIApplication.shared.openURL(URL.init(string: "tel://\(phoneNumber)")!)
            })
        }
        
        /// Animate
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.4, options: [.beginFromCurrentState, .curveEaseIn], animations: {
            phoneView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
}
