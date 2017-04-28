//
//  WNMeBoard.swift
//  Wannar
//
//  Created by 付国良 on 2016/11/21.
//  Copyright © 2016年 玩哪儿. All rights reserved.
//

import UIKit

class WNMeBoard: WNBaseBoard {

    weak var tableView : UITableView!
    var model = WNMeModel()
    var userModel: WNUserModel?
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.fetchUserModel()
        self.buildUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    deinit {
        print("我的销毁")
    }
    
    
    
    // MARK: - Event
    private func fetchUserModel() -> Void {
        
        let userModel = WNUserModel.selectLocalModel()
        self.userModel = userModel
    }
    
    private func buildUI() -> Void {
        
        self.view.backgroundColor = .white
        
        /// Right Bar Item
        let rightBarItem: UIBarButtonItem = UIBarButtonItem.init(title: "设置") {
            let setupboard: WNSetupBoard = WNSetupBoard.init()
            self.navigationController?.pushViewController(setupboard, animated: true)
            print("设置点击")
        }
        rightBarItem.tintColor = .textColor
        self.navigationItem.rightBarButtonItem = rightBarItem
        
        /// Tabel View
        let tableView = UITableView.init()
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        tableView.registerClassOf(WNMeNormalTCell.self)
        tableView.delegate = self;
        tableView.dataSource = self;
        self.tableView = tableView
        
        
        /// Table Header View
        let tableHeader = WNMeHeaderView.init()
        tableView.tableHeaderView = tableHeader
        tableHeader.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0.0)
            make.height.equalTo(100.0)
            make.width.equalToSuperview()
        }
        tableHeader.layoutIfNeeded()
        
        guard let userModel = self.userModel else { return }
        tableHeader.accountLabel.text = userModel.account
        tableHeader.creditLabel.text = "积分：\(userModel.credit)"
        tableHeader.userNameLabel.text = userModel.name
        guard let head = userModel.head else { return }
        tableHeader.userIcon.kf.setImage(with: URL.init(string: head))
    }
}


extension WNMeBoard: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = WNMeNormalTCell.cellWith(tableView: tableView)
        cell.loadData(model: self.model.dataArr[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let board = WNLoginBoard.init()
            self.navigationController?.pushViewController(board, animated: true)
        } else if indexPath.row == 1 {
            WNPhoneView.show()
        } else {
            let board = WNAboutusBoard.init()
            self.navigationController?.pushViewController(board, animated: true)
        }

        print("点击第\(indexPath.row)行")
    }
    
}
