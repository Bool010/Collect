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

    var model: WNFilterModel!
    var confimClick: ((_ model: WNFilterModel)->Void)?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        buildUI()
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
            
            // title
            titleLabel.text = "出发城市".ItemList
            
            // Right Btn
            rightBtn.setTitle("确定".ItemList, for: .normal)
            rightBtn.setTitleColor(.textColor, for: .normal)
            rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
            rightBtn.addControlEvent(.touchUpInside, closureWithControl: { [weak self] (btn) in
                guard let _self = self else { return }
                if let confimClick = _self.confimClick {
                    confimClick(_self.model)
                }
                _self.dismiss(animated: true, completion: nil)
            })
            
            // Left Btn
            leftBtn.setTitle("取消".ItemList, for: .normal)
            leftBtn.setTitleColor(.textColor, for: .normal)
            leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
            leftBtn.addControlEvent(.touchUpInside, closureWithControl: { [weak self] (btn) in
                guard let _self = self else { return }
                _self.dismiss(animated: true, completion: nil)
            })
        }
        
        // Table View
        let tableView = UITableView.init()
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0.0)
            make.top.equalTo(navView.snp.bottom).offset(0.0)
        }
        tableView.registerClassOf(WNListCityTCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Function
extension WNListCityBoard {
    
    fileprivate func changekeySelect(x: Int, y: Int) -> Void {
        
        for i in 0 ..< model.cityArr.count {
            for j in 0 ..< model.cityArr[i].count {
                model.cityArr[i][j].isSelected = false
            }
        }
        model.cityArr[x][y].isSelected = true
    }
}

// MARK: - Delegate
extension WNListCityBoard: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.cityArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.cityArr[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = WNListCityTCell.cellWith(tableView: tableView)
        let x = model.cityArr[indexPath.section][indexPath.row]
        cell.title = x.title
        cell.isSelect = x.isSelected
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        changekeySelect(x: indexPath.section, y: indexPath.row)
        tableView.reloadData()
    }
}
