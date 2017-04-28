//
//  WNLoginBoard.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/24.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit
import SABlurImageView

class WNLoginBoard: UIViewController {

    private var tableView: UITableView!
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
        wn_deinitMessage("登录界面")
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
        let tableView: UITableView = UITableView.init()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview().offset(0.0)
        }
        tableView.registerClassOf(WNLoginEmailTCell.self)
        tableView.registerClassOf(WNLoginPlatformTCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView = tableView
        
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

extension WNLoginBoard: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = WNLoginEmailTCell.cellWith(tableView: tableView)
            
            /// 注册点击
            cell.signUpClick = { [weak self] (btn) in
                if let strongSelf = self {
                    let board = WNSignUpBoard.init()
                    strongSelf.navigationController?.pushViewController(board, animated: true)
                }
            }
            
            /// 登录点击
            cell.loginBtn.addControlEvent(.touchUpInside, closureWithControl: { [weak self] (btn) in
                
                guard let strongSelf = self else { return }
                
                // 邮箱
                guard let account = cell.account.text else {
                    strongSelf.view.makeToast("请输入邮箱", duration: 3.0, position: .top)
                    cell.account.becomeFirstResponder()
                    return
                }
                if account.length <= 0 {
                    strongSelf.view.makeToast("请输入邮箱", duration: 3.0, position: .top)
                    cell.account.becomeFirstResponder()
                    return
                }
                
                // 密码
                guard let password = cell.password.text else {
                    strongSelf.view.makeToast("请输入密码", duration: 3.0, position: .top)
                    cell.account.becomeFirstResponder()
                    return
                }
                if password.length <= 0 {
                    strongSelf.view.makeToast("请输入密码", duration: 3.0, position: .top)
                    cell.account.becomeFirstResponder()
                    return
                }
                
                cell.activity.startAnimating()
                btn.isUserInteractionEnabled = false
                btn.alpha = 0.4
                strongSelf.backBtn.isUserInteractionEnabled = false
                strongSelf.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                
                WNUserAPI.signIn(account: account, password: password, success: { (message, model) in
                    wn_debugMessage(message)
                }, fail: { (message) in
                    wn_debugMessage(message)
                }, finish: { 
                    cell.activity.stopAnimating()
                    btn.isUserInteractionEnabled = true
                    btn.alpha = 1.0
                    strongSelf.backBtn.isUserInteractionEnabled = true
                    strongSelf.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
                })
                
            })
            return cell
        } else {
            let cell = WNLoginPlatformTCell.cellWith(tableView: tableView)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return UIScreen.height.cgFloat / 7.0 * 5.0
        } else {
            return UIScreen.height.cgFloat / 7.0 * 2.0
        }
        
    }
}
