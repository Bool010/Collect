//
//  WNFilterBoard.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/3.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNFilterBoard: UIViewController {

    var toursModel: WNToursModel?
    fileprivate var model: WNFilterModel!
    fileprivate var keyTableView: UITableView!
    fileprivate var valueTabelView: UITableView!
    fileprivate var selectIndex = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.buildUI()
        self.fetchData()
        self.updatePreferredContentSize(traitCollection: self.traitCollection)
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        wn_deinitMessage("筛选页面")
    }
}

// MARK: - Method
extension WNFilterBoard {
    
    fileprivate func fetchData() -> Void {
        guard let tour = self.toursModel else { return }
        guard let extend = tour.facetExtend else { return }
        guard let detail = tour.facetDetail else { return }
        self.model = WNFilterModel.init(facetExtend: extend, facetDetail: detail)
        self.changekeySelect(index: selectIndex)
        
        keyTableView.delegate = self
        keyTableView.dataSource = self
        valueTabelView.delegate = self
        valueTabelView.dataSource = self
        reloadTableView()
    }
    
    fileprivate func changekeySelect(index: Int) -> Void {
        for i in 0 ..< self.model.keyArr.count {
            self.model.keyArr[i].isSelected = false
        }
        self.model.keyArr[index].isSelected = true
    }
    
    fileprivate func changeValueSelect(index: Int) -> Void {
        self.model.valueArr[selectIndex][index].isSelected = !(self.model.valueArr[selectIndex][index].isSelected)
    }
    
    fileprivate func reloadTableView() -> Void {
        keyTableView.reloadData()
        valueTabelView.reloadData()
    }
}

// MARK: - Layout
extension WNFilterBoard {
    
    fileprivate func updatePreferredContentSize(traitCollection: UITraitCollection) {
        self.preferredContentSize = CGSize.init(width: self.view.bounds.width.double,
                                                height: UIScreen.height / 2.0)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.willTransition(to: newCollection, with: coordinator)
        self.updatePreferredContentSize(traitCollection: newCollection)
    }
}

// MARK: - UI
extension WNFilterBoard {
    
    fileprivate func buildUI() -> Void {
        
        /// Navigation View
        self.view.addNavigation { [weak self] (leftBtn, rightBtn, titleLabel) in
            titleLabel.text = "筛选"
            leftBtn.addControlEvent(.touchUpInside, closureWithControl: { (btn) in
                guard let _self = self else { return }
                _self.dismiss(animated: true, completion: nil)
            })
        }
        
        /// Key Table View
        let keyTableView = UITableView.init()
        keyTableView.separatorStyle = .none
        keyTableView.estimatedRowHeight = 44.0
        keyTableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(keyTableView)
        keyTableView.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview().offset(0.0)
            make.top.equalToSuperview().offset(64.0)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        keyTableView.registerClassOf(WNFilterTCell.self)
        self.keyTableView = keyTableView
        
        /// Value Table View
        let valueTabelView = UITableView.init()
        valueTabelView.separatorStyle = .none
        valueTabelView.estimatedRowHeight = 44.0
        valueTabelView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(valueTabelView)
        valueTabelView.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview().offset(0.0)
            make.top.equalToSuperview().offset(64.0)
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        valueTabelView.registerClassOf(WNFilterTCell.self)
        self.valueTabelView = valueTabelView
        
        let separator = UIView.init()
        separator.backgroundColor = .separatorColor
        self.view.addSubview(separator)
        separator.snp.makeConstraints { (make) in
            make.left.equalTo(keyTableView.snp.right).offset(0.0)
            make.top.equalTo(keyTableView.snp.top).offset(0.0)
            make.bottom.equalTo(keyTableView.snp.bottom).offset(0.0)
            make.width.equalTo(0.5)
        }
    }
}

// MARK: - Delegate
extension WNFilterBoard: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == keyTableView {
            return self.model.keyArr.count
        } else {
            return self.model.valueArr[selectIndex].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == keyTableView {
            let cell = WNFilterTCell.cellWith(tableView: tableView)
            let x = self.model.keyArr[indexPath.row]
            cell.titleLabel.text = x.title
            cell.titleLabel.textColor = x.isSelected ? .themColor : .textColor
            return cell
        } else {
            let cell = WNFilterTCell.cellWith(tableView: tableView)
            let x = self.model.valueArr[selectIndex][indexPath.row]
            cell.titleLabel.text = x.title
            cell.titleLabel.textColor = x.isSelected ? .themColor : .textColor
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == keyTableView {
            selectIndex = indexPath.row
            changekeySelect(index: indexPath.row)
        } else {
            changeValueSelect(index: indexPath.row)
        }
        reloadTableView()
    }
}

