//
//  WNLoginEmailTCell.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/24.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit
import TextFieldEffects

class WNLoginEmailTCell: UITableViewCell {

    var account: HoshiTextField!
    var password: HoshiTextField!
    var loginBtn: UIButton!
    var activity: UIActivityIndicatorView!
    public var signUpClick: (() -> Void)?
    private var isShowPassword = false
    
    class func cellWith(tableView: UITableView) -> WNLoginEmailTCell {
        
        let cell: WNLoginEmailTCell = tableView.dequeueReusableCell()
        cell.selectionStyle = .none
        return cell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.buildUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }

    fileprivate func buildUI() -> Void {
        
        self.backgroundColor = .clear
        /// Logo
        let logo = UIImageView.init(image: UIImage.init(named: "logo")?.imageBy(tintColor: .white))
        logo.contentMode = .scaleAspectFill
        self.contentView.addSubview(logo)
        logo.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30.0)
            make.size.equalTo(CGSize.init(width: 100, height: 100))
        }
        
        /// Account
        let account = HoshiTextField.init()
        self.set(textField: account, placeholder: "邮箱地址")
        self.contentView.addSubview(account)
        account.snp.makeConstraints { (make) in
            make.top.equalTo(logo.snp.bottom).offset(40.0)
            make.left.equalToSuperview().offset(15.0)
            make.right.equalToSuperview().offset(-15.0)
            make.height.equalTo(55.0)
        }
        self.account = account
        
        /// Password
        let password = HoshiTextField.init()
        password.isSecureTextEntry = true
        self.set(textField: password, placeholder: "密码")
        self.contentView.addSubview(password)
        password.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.right.equalToSuperview().offset(-15.0)
            make.top.equalTo(account.snp.bottom).offset(20.0)
            make.height.equalTo(55.0)
        }
        self.password = password
        
        let eyes = UIButton.init()
        eyes.backgroundColor = .white
        self.contentView.addSubview(eyes)
        eyes.snp.makeConstraints { (make) in
            make.bottom.equalTo(password.snp.bottom).offset(0.0)
            make.right.equalTo(password.snp.right).offset(-15.0)
            make.size.equalTo(CGSize.init(width: 40.0, height: 40.0))
        }
        eyes.addControlEvent(.touchUpInside) { [weak self] (btn) in
            guard let strongSelf = self else { return }
            strongSelf.isShowPassword = !strongSelf.isShowPassword
            if strongSelf.isShowPassword {
                password.isSecureTextEntry = false
            } else {
                password.isSecureTextEntry = true
            }
        }
        
        /// Login Btn
        let loginBtn = UIButton.init()
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.titleLabel?.set(color: UIColor.white, fontName: WNConfig.FontName.kaitiRegular, size: 17, textAlignment: .center)
        loginBtn.backgroundColor = .themColor
        loginBtn.layer.cornerRadius = 5.0
        self.contentView.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.right.equalToSuperview().offset(-15.0)
            make.top.equalTo(password.snp.bottom).offset(60.0)
            make.height.equalTo(40.0)
        }
        self.loginBtn = loginBtn
        
        /// Activity Indicator
        let activity = UIActivityIndicatorView.init()
        activity.tintColor = .white
        self.contentView.addSubview(activity)
        activity.snp.makeConstraints { (make) in
            make.centerY.equalTo(loginBtn)
            make.right.equalTo(loginBtn.snp.right).offset(-30.0)
            make.size.equalTo(CGSize.init(width: 25.0, height: 25.0))
        }
        self.activity = activity
        
        /// Sign Up
        let signUp = UIButton.init(title: "尚无账号？去注册 >", fontSize: 15, color: .white)
        signUp.addControlEvent(.touchUpInside) { [weak self] (btn) in
            if let strongSelf = self {
                if let click = strongSelf.signUpClick {
                    click()
                }
            }
        }
        UIFont.set(fontName: WNConfig.FontName.kaitiRegular, control: signUp, size: 15)
        self.contentView.addSubview(signUp)
        signUp.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15.0)
            make.top.equalTo(loginBtn.snp.bottom).offset(15.0)
            make.height.equalTo(30.0)
        }
    }
    
    fileprivate func set(textField: HoshiTextField, placeholder: String) -> Void {
        textField.set(fontName: WNConfig.FontName.kaitiBlack, size: 17)
        textField.placeholderLabel.set(color: .white, fontName: WNConfig.FontName.kaitiRegular, size: 13, textAlignment: .left)
        textField.placeholderColor = .white
        textField.textColor = .white
        textField.placeholderFontScale = 0.8
        textField.borderInactiveColor = .white
        textField.borderActiveColor = .themColor
        textField.placeholder = placeholder
        textField.animateViewsForTextDisplay()
    }
}
