//
//  WNMeBoard.swift
//  Wannar
//
//  Created by 付国良 on 2016/11/21.
//  Copyright © 2016年 玩哪儿. All rights reserved.
//

import UIKit

class WNMeBoard: WNBaseBoard {

    var tableView : UITableView!
    var model = WNMeModel()
    var test = 1
    
    
    
    // MARK: - ------------------------ Life Cycle ------------------------
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.buildUI()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    
    // MARK: - ------------------------ Event ------------------------
    private func buildUI() -> Void {
        
        let rightBarItem: UIBarButtonItem = UIBarButtonItem.init(title: "设置") {
            let setupboard: WNSetupBoard = WNSetupBoard.init()
            self.navigationController?.pushViewController(setupboard, animated: true)
            print("设置点击")
        }
        rightBarItem.tintColor = UIColor.textColor()
        self.navigationItem.rightBarButtonItem = rightBarItem
        
        
        self.view.backgroundColor = UIColor.white
        
        self.tableView = UITableView.init()
        self.tableView.separatorStyle = .none
        self.tableView.estimatedRowHeight = 50.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        self.tableView.registerClassOf(WNMeNormalTCell.self)
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    
    
    // MARK: - ------------------------ Deinit ------------------------
    deinit {
        print("我的销毁")
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
        print("点击第\(indexPath.row)行")
    }
    
}
