//
//  WNSortBoard.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/3.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

// MARK: - Life Cycle
class WNSortBoard: UIViewController {
    
    var model: WNSortModel!
    var confirmClick: ((_ model: WNSortModel) -> Void)?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.buildUI()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
}


// MARK: - UI
extension WNSortBoard {
    
    fileprivate func buildUI() -> Void {
        
        /// Navigation View
        let navView = self.view.addNavigation(height:50.0, isTop: false) { [weak self] (leftBtn, rightBtn, titleLabel, lineView) in
            
            // title
            titleLabel.text = "排序".ItemList
            
            // Right Btn
            rightBtn.setTitle("确定".ItemList, for: .normal)
            rightBtn.setTitleColor(.textColor, for: .normal)
            rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
            rightBtn.addControlEvent(.touchUpInside, closureWithControl: { [weak self] (btn) in
                guard let _self = self else { return }
                if let confirmClick = _self.confirmClick {
                    confirmClick(_self.model)
                }
                _self.dismiss(animated: true)
            })
            
            // Left Btn
            leftBtn.setTitle("取消".ItemList, for: .normal)
            leftBtn.setTitleColor(.textColor, for: .normal)
            leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
            leftBtn.addControlEvent(.touchUpInside, closureWithControl: { [weak self] (btn) in
                guard let _self = self else { return }
                _self.dismiss(animated: true)
            })
        }
        
        // Table View
        let tableView = UITableView.init()
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0.0)
            make.top.equalTo(navView.snp.bottom).offset(0.0)
        }
        tableView.registerClassOf(WNSortTCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
}


// MARK: - Function
extension WNSortBoard {
    
    fileprivate func changekeySelect(index: Int) -> Void {
        
        for i in 0 ..< self.model.data.count {
            self.model.data[i].isSelected = false
        }
        self.model.data[index].isSelected = true
    }
}


// MARK: - Delegate
extension WNSortBoard: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let x = model.data[indexPath.row]
        
        let cell = WNSortTCell.cellWith(tableView: tableView)
        cell.imageName = x.image
        cell.title = x.title
        cell.isSelect = x.isSelected
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        changekeySelect(index: indexPath.row)
        tableView.reloadData()
    }
}
