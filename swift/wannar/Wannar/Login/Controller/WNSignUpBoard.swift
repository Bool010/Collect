//
//  WNSignUpBoard.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/24.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit
import SABlurImageView

class WNSignUpBoard: UIViewController {

    fileprivate var backBtn: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.buildUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

    deinit {
        wn_deinitMessage("注册页面")
    }
    
    // MARK: - Event
    fileprivate func buildUI() -> Void {
        
        /// Background
        let imageView = SABlurImageView(image: UIImage.init(named: "loginBackground.jpg"))
        imageView.addBlurEffect(50, times: 1)
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview().offset(0.0)
        }
        
        /// Table View
        let tableView = UITableView.init()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview().offset(0.0)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClassOf(WNSignUpTCell.self)
        
        /// Back Button
        let backBtn = UIButton.init()
        self.view.addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0.0)
            make.top.equalToSuperview().offset(20.0)
            make.size.equalTo(CGSize.init(width: 50.0, height: 44.0))
        }
        backBtn.addControlEvent(.touchUpInside) { [weak self] (btn) in
            guard let strongSelf = self else { return }
            _ = strongSelf.navigationController?.popViewController(animated: true)
        }
        self.backBtn = backBtn
    }
}

extension WNSignUpBoard: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = WNSignUpTCell.cellWith(tableView: tableView)
        
        
        /// 注册按钮点击
        cell.signUpBtn.addControlEvent(.touchUpInside) { [weak self] (btn) in
            
            guard let strongSelf = self else { return }

            // 检查邮箱格式
            guard let account = cell.account.text else {
                strongSelf.view.makeToast("请输入邮箱", duration: 3.0, position: .top)
                cell.account.becomeFirstResponder()
                return
            }
            if !(account.isEmail()) {
                strongSelf.view.makeToast("邮箱格式不正确", duration: 3.0, position: .top)
                cell.account.becomeFirstResponder()
                return
            }
            
            // 检查用户名
            guard let userName = cell.userName.text else {
                strongSelf.view.makeToast("请输入用户名", duration: 3.0, position: .top)
                cell.userName.becomeFirstResponder()
                return
            }
            if userName.length > 16 || userName.length <= 0 {
                strongSelf.view.makeToast("用户名长度不符", duration: 3.0, position: .top)
                cell.userName.becomeFirstResponder()
                return
            }
            
            // 检查两次密码输入的是否相同
            guard let password = cell.password.text else {
                strongSelf.view.makeToast("请输入密码", duration: 3.0, position: .top)
                cell.password.becomeFirstResponder()
                return
            }
            
            guard let passwordAgain = cell.passwordAgain.text else {
                strongSelf.view.makeToast("请再次输入密码", duration: 3.0, position: .top)
                cell.passwordAgain.becomeFirstResponder()
                return
            }
            
            guard password.length >= 8 && password.length <= 16 else {
                strongSelf.view.makeToast("密码长度不符", duration: 3.0, position: .top)
                cell.password.becomeFirstResponder()
                return
            }
            
            if password != passwordAgain {
                strongSelf.view.makeToast("两次输入密码不同", duration: 3.0, position: .top)
                cell.passwordAgain.becomeFirstResponder()
                return
            }
            
            /// 发送请求
            cell.activity.startAnimating()
            btn.isUserInteractionEnabled = false
            btn.alpha = 0.4
            strongSelf.backBtn.isUserInteractionEnabled = false
            strongSelf.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            
            WNUserAPI.signUp(account: account, userName: userName, password: password, success: { (message) in
                wn_debugMessage(message)
            }, fail: { (message) in
                wn_debugMessage(message)
            }) { () in
                cell.activity.stopAnimating()
                btn.isUserInteractionEnabled = true
                btn.alpha = 1.0
                strongSelf.backBtn.isUserInteractionEnabled = true
                strongSelf.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            }
        }
        return cell
    }
}
