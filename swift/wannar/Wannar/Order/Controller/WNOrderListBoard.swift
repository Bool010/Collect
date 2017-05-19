//
//  WNOrderListBoard.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/8.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

// MARK: - Life Cycle
class WNOrderListBoard: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        wn_deinitMessage("订单列表")
    }
}


// MARK: - UI
extension WNOrderListBoard {
    
    fileprivate func buildUI() -> Void {
        
        // Navigation
        view.addNavigation { [weak self] (leftBtn, rightBtn, titleLabel, lineView) in
            leftBtn.addControlEvent(.touchUpInside, closureWithControl: { [weak self] (btn) in
                if let _self = self {
                    _self.popViewController()
                }
            })
        }
        
        // Table View
        let tableView = UITableView.init()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0.0)
        }
        tableView.registerClassOf(WNOrderListTCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension WNOrderListBoard: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = WNOrderListTCell.cellWith(tableView: tableView)
        return cell
    }
}
