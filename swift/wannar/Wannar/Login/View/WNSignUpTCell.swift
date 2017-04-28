//
//  WNSignUpTCell.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/24.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit
import TextFieldEffects

class WNSignUpTCell: UITableViewCell {

    var account: HoshiTextField!
    var userName: HoshiTextField!
    var password: HoshiTextField!
    var passwordAgain: HoshiTextField!
    var signUpBtn: UIButton!
    var activity: UIActivityIndicatorView!
    
    class func cellWith(tableView: UITableView) -> WNSignUpTCell {
        
        let cell: WNSignUpTCell = tableView.dequeueReusableCell()
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
        self.contentView.backgroundColor = .clear
        
        /// Logo
        let logo = UIImageView.init(image: UIImage.init(named: "logo")?.imageBy(tintColor: .white))
        logo.contentMode = .scaleAspectFill
        self.contentView.addSubview(logo)
        logo.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30.0)
            make.height.equalTo(100)
            make.width.equalTo(100)
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
        
        
        /// User Name
        let userName = HoshiTextField.init()
        self.set(textField: userName, placeholder: "请输入用户名")
        self.contentView.addSubview(userName)
        userName.snp.makeConstraints { (make) in
            make.top.equalTo(account.snp.bottom).offset(20.0)
            make.left.equalToSuperview().offset(15.0)
            make.right.equalToSuperview().offset(-15.0)
            make.height.equalTo(55.0)
        }
        self.userName = userName
        
        
        /// Password
        let password = HoshiTextField.init()
        self.set(textField: password, placeholder: "请输入密码")
        self.contentView.addSubview(password)
        password.snp.makeConstraints { (make) in
            make.top.equalTo(userName.snp.bottom).offset(20.0)
            make.left.equalToSuperview().offset(15.0)
            make.right.equalToSuperview().offset(-15.0)
            make.height.equalTo(55.0)
        }
        self.password = password
        
        
        /// Password Again
        let passwordAgain = HoshiTextField.init()
        self.set(textField: passwordAgain, placeholder: "请再次输入密码")
        self.contentView.addSubview(passwordAgain)
        passwordAgain.snp.makeConstraints { (make) in
            make.top.equalTo(password.snp.bottom).offset(20.0)
            make.left.equalToSuperview().offset(15.0)
            make.right.equalToSuperview().offset(-15.0)
            make.height.equalTo(55.0)
        }
        self.passwordAgain = passwordAgain

        
        /// Sign Up Button
        let signUpBtn = UIButton.init()
        signUpBtn.setTitle("注册", for: .normal)
        signUpBtn.titleLabel?.set(color: UIColor.white, fontName: WNConfig.FontName.kaitiRegular, size: 17, textAlignment: .center)
        signUpBtn.backgroundColor = .themColor
        signUpBtn.layer.cornerRadius = 5.0
        self.contentView.addSubview(signUpBtn)
        signUpBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.right.equalToSuperview().offset(-15.0)
            make.top.equalTo(passwordAgain.snp.bottom).offset(60.0)
            make.height.equalTo(40.0)
            make.bottom.equalToSuperview().offset(0.0)
        }
        self.signUpBtn = signUpBtn
        
        
        /// Activity Indicator
        let activity = UIActivityIndicatorView.init()
        activity.tintColor = .white
        self.contentView.addSubview(activity)
        activity.snp.makeConstraints { (make) in
            make.centerY.equalTo(signUpBtn)
            make.right.equalTo(signUpBtn.snp.right).offset(-30.0)
            make.size.equalTo(CGSize.init(width: 25.0, height: 25.0))
        }
        self.activity = activity
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
