//
//  WNSetupBoard.swift
//  Wannar
//
//  Created by 付国良 on 2016/11/24.
//  Copyright © 2016年 玩哪儿. All rights reserved.
//

import UIKit

class WNSetupBoard: WNBaseBoard {

    var model: Array <Array <WNSetupRowModel>> = []
    
    // MARK: - <<<<<<<<<<<<<<<< Life Cycle >>>>>>>>>>>>>>>> -
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.configModel()
        self.buildUI()
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - <<<<<<<<<<<<<<<< Event >>>>>>>>>>>>>>>> -
    private func configModel() -> Void {
        
        self.model = WNSetupModel.init().model
    }
    
    
    private func buildUI() -> Void {
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.addNavigation { (leftBtn, rightBtn, titleLabel, lineView) in
            titleLabel.text = "导航栏";
            leftBtn.addControlEvent(.touchUpInside) { (btn) in
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
        
        let tableView: UITableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView.sectionHeaderHeight = 10.0
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(64.0)
            make.left.right.bottom.equalToSuperview().offset(0.0)
        }
        tableView.registerClassOf(WNSetupTCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    // MARK: - <<<<<<<<<<<<<<<< Dealloc >>>>>>>>>>>>>>>> -
    deinit {
        wn_deinitMessage("设置界面")
    }
}



extension WNSetupBoard: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WNSetupTCell.cellWith(tableView: tableView)
        cell.loadData(model: self.model[indexPath.section][indexPath.row])
        return cell
    }

}
