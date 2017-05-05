//
//  WNItemListBoard.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/28.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit



// MARK: - Life Cycle
class WNItemListBoard: UIViewController {

    var toursModel: WNToursModel?
    var data: Array<WNTourModel> = []
    var titleLabel: UILabel!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.buildUI()
        self.fetchData()
        self.definesPresentationContext = true
        self.navigationController?.definesPresentationContext = true
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        wn_deinitMessage("列表页面")
    }
}

extension WNItemListBoard {
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        
        let a = WNHalfwayPresentation.init(presentedViewController: viewControllerToPresent, presenting: self)
        viewControllerToPresent.transitioningDelegate = a
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}

// MARK: - Function
extension WNItemListBoard {
    
    // Fetch Data
    fileprivate func fetchData() -> Void {
        
        WNItemListAPI.selectTour(query: "", sort: "", offset: 0, isNeedTitle: true, isCountOnly: false, success: { [weak self] (model) in
            guard let _self = self else { return }
            guard let _model = model else { return }
            _self.toursModel = model
            _self.titleLabel.text = _model.title
            _self.data = _model.dataArr
            _self.tableView.reloadSections([0], with: .automatic)
            }, fail: {
                
        }) {
            
        }
    }
}

// MARK: - UI
extension WNItemListBoard {
    
    fileprivate func buildUI() -> Void {
        
        /// Navigation
        self.view.addNavigation { [weak self] (leftBtn, rightBtn, titleLabel) in
            
            guard let _self = self else { return }
            
            // Title Label
            _self.titleLabel = titleLabel
            
            // Left Btn
            leftBtn.addControlEvent(.touchUpInside, closureWithControl: { [weak self] (btn) in
                guard let __self = self else { return }
                _ = __self.navigationController?.popViewController(animated: true)
            })
            
            // Right Btn
            rightBtn.addControlEvent(.touchUpInside, closureWithControl: { [weak self] (btn) in
                guard let __self = self else { return }
                let board = WNFilterBoard.init()
                board.toursModel = __self.toursModel
                __self.present(board, animated: true, completion: nil)
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
}

// MARK: - Table View Delegate
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
