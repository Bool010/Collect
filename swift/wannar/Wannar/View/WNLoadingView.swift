//
//  WNLoadingView.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/9.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit
import Dispatch

class WNLoadingView: UIView {

    typealias LoadingHandle = ()->()
    public var handle: LoadingHandle?
    
    /// 底部图片
    lazy var bottomImage: UIImageView = {
        let view = UIImageView.init(mode: .scaleToFill)
        return view
    }()
    
    
    /// 提示图片
    lazy var hintImage: UIImageView = {
        let view = UIImageView.init(mode: .scaleAspectFit)
        return view
    }()
    
    
    /// 提示文本框
    lazy var hintLabel: UILabel = {
        let label = UILabel.init(color: UIColor.textColor(),
                                 size: 13.0,
                                 textAlignment: .center)
        return label
    }()
    
    
    /// 标题文本
    lazy var titleLabel: UILabel = {
        let label = UILabel.init(color: UIColor.textColor(),
                                 font: UIFont.boldSystemFont(ofSize: 16.0),
                                 textAlignment: .center)
        return label
    }()
    
    
    /// 重试按钮
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.themColor()
        btn.layer.cornerRadius = 3.0
        btn.setTitle("重试", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    
    class func construction() -> WNLoadingView{
        let loadingView = WNLoadingView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height))
        loadingView.backgroundColor = UIColor.white
        return loadingView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
        addRAC()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// RAC
    fileprivate func addRAC() -> Void {
        
        WNGlobalVar.shared.networkChange = { [weak self] isValid in
            if !isValid {
                if let _self = self {
                    _self.networkNoAvailable()
                }
            }
        }
    
    }
    
    
    /// 构建UI
    fileprivate func buildUI() -> Void {
        
        // 底部Image
        addSubview(self.bottomImage)
        self.bottomImage.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview().offset(0.0)
            make.height.equalTo(UIScreen.width * 210.0 / 743.0)
        }
        
        // 提示图片
        addSubview(self.hintImage)
        self.hintImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(90 * UIScreen.radio320)
            make.top.equalToSuperview().offset(120 * UIScreen.radio320)
        }
        
        // 提示文本
        addSubview(self.hintLabel)
        self.hintLabel.snp.makeConstraints { [weak self] (make) in
            
            if let _self = self {
                make.centerX.equalToSuperview()
                make.left.equalToSuperview().offset(15.0)
                make.top.equalTo(_self.hintImage.snp.bottom).offset(35.0 * UIScreen.radio320)
            }
        }
        
        // 标题
        addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { [weak self] (make) in
            
            if let _self = self {
                make.centerX.equalToSuperview()
                make.top.equalTo(_self.hintLabel.snp.bottom).offset(25.0 * UIScreen.radio320)
                make.left.equalToSuperview().offset(15.0)
            }
        }
        
        // 按钮
        addSubview(self.button)
        self.button.snp.makeConstraints { [weak self] (make) in
            
            if let _self = self {
                make.centerX.equalToSuperview()
                make.top.equalTo(_self.titleLabel.snp.bottom).offset(35.0 * UIScreen.radio320)
                make.width.equalTo(85.0 * UIScreen.radio320)
                make.height.equalTo(30.0 * UIScreen.radio320)
            }
        }
    }
    
    
    /// 开始加载
    public func beginLoad() -> Void {
        
        self.isHidden = false
        setControlOpacity(opacity: 0.0)
        if WNGlobalVar.shared.isNetworkValid {
            showLoading()
            setControlOpacity(opacity: 0.0)
        } else {
            networkNoAvailable()
            return
        }
        
        if let handle = handle {
            handle()
        }
    }
    
    
    /// 加载成功, 移除控件
    func loadSuccess() -> Void {
        
        self.removeAllSubview()
        self.removeFromSuperview()
    }
    
    
    /// 加载成功，隐藏控件
    func loadSuccessHidden() -> Void {
        self.isHidden = true
    }
    
    
    /// 加载失败
    func loadFail() -> Void {
        hideLoading()
        DispatchQueue.delay(0.4) { [weak self] in
            if let _self = self {
                _self.setControlContent(image: "WN_loadFail",
                                       hintText: "加载失败",
                                       title: "点击按钮重新加载",
                                       btnText: "重新加载")
                _self.button.addControlEvent(.touchUpInside) { (btn) in
                    _self.beginLoad()
                }
                _self.setControlOpacity(opacity: 1.0, duration: 0.3)
            }
        }
    }
    
    
    /// 没有网络
    fileprivate func networkNoAvailable() -> Void {
        hideLoading()
        setControlContent(image: "WN_noNetwork",
                          hintText: "无网络连接",
                          title: "请检查网络设置",
                          btnText: "重新加载")
        self.button.addControlEvent(.touchUpInside) { (btn) in
            self.beginLoad()
        }
        setControlOpacity(opacity: 1.0)
    }
    
    
    
    /// 设置控件的文本内容
    ///
    /// - Parameters:
    ///   - image: 图片名
    ///   - hintText: 提示文本
    ///   - title: 标题文本
    ///   - btnText: 按钮文本
    fileprivate func setControlContent(image: String?,
                                       hintText: String?,
                                       title: String?,
                                       btnText: String?) -> Void {
        if let image = image {
            self.hintImage.image = UIImage.init(named: image)
        }
        
        self.hintLabel.text = hintText
        self.titleLabel.text = title
        self.button.setTitle(btnText, for: .normal)
    }
    
    
    
    /// 设置控件的隐藏与显示
    ///
    /// - Parameter opacity: 透明度
    fileprivate func setControlOpacity(opacity: Float) -> Void {
        
        self.setControlOpacity(opacity: opacity, duration: 0.0)
    }
    
    
    fileprivate func setControlOpacity(opacity: Float, duration: TimeInterval) -> (Void) {

        UIView.animate(withDuration: duration) { [weak self] in
            if let _self = self {
                _self.hintImage.layer.opacity = opacity
                _self.hintLabel.layer.opacity = opacity
                _self.titleLabel.layer.opacity = opacity
                _self.button.layer.opacity = opacity
            }
        }
    }
    
    
    deinit {
        
        wn_deinitMessage("Loading")
    }
}
