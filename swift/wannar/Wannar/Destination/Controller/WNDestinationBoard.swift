//
//  WNDestinationBoard.swift
//  Wannar
//
//  Created by 付国良 on 2016/11/21.
//  Copyright © 2016年 玩哪儿. All rights reserved.
//

import UIKit

class WNDestinationBoard: WNBaseBoard {

    fileprivate var tableView : UITableView!
    
    
    // MARK: - ================== Life Cycle ================== -
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        WNDepartureAPI.select()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - ================== Event ================== -
    fileprivate func buildUI() {
        
        self.view.backgroundColor = UIColor.yellow
        
        // Table View
        self.tableView = UITableView.init()
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
    }
    
    
    // MARK: - ================== IBoutlet ================== -
    
    // MARK: - ================== Delegate ================== -
    
    // MARK: - ================== Get/Set ================== -
    
    // MARK: - ================== Dealloc ================== -

}
