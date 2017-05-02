//
//  WNItemListBoard.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/28.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNItemListBoard: UIViewController {

    var data: Array<WNTourModel> = []
    var titleLabel: UILabel!
    var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.buildUI()
        self.fetchData()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

    // MARK: - Event
    fileprivate func buildUI() -> Void {
        
        /// Navigation
        self.view.addNavigation { [weak self] (leftBtn, rightBtn, titleLabel) in
            
            guard let _self = self else { return }
            
            // Title Label
            _self.titleLabel = titleLabel
            
            // Left Btn
            leftBtn.addControlEvent(.touchUpInside, closureWithControl: { (btn) in
                _ = _self.navigationController?.popViewController(animated: true)
            })
        }
        
        /// Table View
        let tableView = UITableView.init()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0.0)
            make.top.equalToSuperview().offset(64.0)
        }
        tableView.registerClassOf(WNItemListTCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView = tableView
    }
    
    fileprivate func fetchData() -> Void {
        WNItemListAPI.selectTour(query: "", sort: "", offset: 0, isNeedTitle: false, isCountOnly: false, success: { [weak self] (model) in
            guard let _self = self else { return }
            guard let _model = model else { return }
            _self.data = _model.dataArr
            _self.tableView.reloadData()
            wn_print(model)
        }, fail: { 
            
        }) { 
            
        }
    }

}

extension WNItemListBoard: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = WNItemListTCell.cellWith(tableView: tableView)
        cell.model = data[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
