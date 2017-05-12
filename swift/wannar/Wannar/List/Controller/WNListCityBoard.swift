//
//  WNListCityBoard.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/12.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

// MARK: - Life Cycle
class WNListCityBoard: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UI
extension WNListCityBoard {
    
    fileprivate func buildUI() -> Void {
        
        // Navigation
        let navView = view.addNavigation(height: 50, isTop: false) { (leftBtn, rightBtn, titleLabel, lineView) in
            
        }
        
        // Table View
        let tableView = UITableView.init()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0.0)
            make.top.equalTo(navView.snp.bottom).offset(0.0)
        }
        tableView.registerClassOf(WNListCityTCell.self)
//        tableView.delegate = self
//        tableView.dataSource = self
    }
}

// MARK: - Function

// MARK: - Delegate
//extension WNListCityBoard: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//}
