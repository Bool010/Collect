//
//  WNItemListBoard.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/28.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNItemListBoard: UIViewController {

    var titleLabel: UILabel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
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
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0.0)
            make.top.equalToSuperview().offset(64.0)
        }
        
    }

}

extension WNItemListBoard {
    
}
