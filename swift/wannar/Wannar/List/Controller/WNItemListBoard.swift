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

    // 初始query
    var inceptionQuery = "tag:yellowstone;tour_leave_single_en_cn:Big Island"
    
    var toursModel: WNToursModel?
    var filterModel: WNFilterModel?
    var sortModel: WNSortModel = WNSortModel.init(type: "tour")
    var data: Array<WNTourModel> = []
    var titleLabel: UILabel!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.buildUI()
        self.fetchData(isResetFilter: true, inceptionQuery: inceptionQuery)
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
        
        let a = WNHalfwayPresentation.init(presentedViewController: viewControllerToPresent,
                                           presenting: self,
                                           heightRatio: 4.0 / 5.0)
        viewControllerToPresent.transitioningDelegate = a
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}

// MARK: - Function
extension WNItemListBoard {
    
    // Fetch Data
    fileprivate func fetchData(isResetFilter: Bool,
                               query: String = "",
                               inceptionQuery: String = "") -> Void {
        
        WNItemListAPI.selectTour(query: query, sort: self.sortModel.getSortParam(), offset: 0, isNeedTitle: true, isCountOnly: false, success: { [weak self] (model) in
            
            // Tours Model
            guard let _self = self else { return }
            guard let _model = model else { return }
            _self.toursModel = _model
            _self.titleLabel.text = _model.title
            _self.data = _model.dataArr
            _self.tableView.reloadData()
            
            // Filter Model
            if isResetFilter {
                guard let extend = _model.facetExtend else { return }
                guard let detail = _model.facetDetail else { return }
                _self.filterModel = WNFilterModel.init(facetExtend: extend,
                                                       facetDetail: detail,
                                                       query: query,
                                                       inceptionQuery: inceptionQuery)
            }
            
        }, fail: {
                
        }) {
            
        }
    }
}

// MARK: - UI
extension WNItemListBoard {
    
    fileprivate func buildUI() -> Void {
        
        /// Navigation
        let navView = self.view.addNavigation { [weak self] (leftBtn, rightBtn, titleLabel, lineView) in
            
            guard let _self = self else { return }
            
            // Title Label
            _self.titleLabel = titleLabel
            
            // Left Btn
            leftBtn.addControlEvent(.touchUpInside, closureWithControl: { [weak self] (btn) in
                guard let __self = self else { return }
                _ = __self.navigationController?.popViewController(animated: true)
            })
        }
        
        /// Condition
        let condition = WNItemListConditionView.init(isNeedCity: true)
        view.addSubview(condition)
        condition.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(0.0)
            make.height.equalTo(40.0)
            make.top.equalTo(navView.snp.bottom).offset(0.0)
        }
        condition.click = { [weak self] (btn, event) in
            guard let _self = self else { return }
            
            // City
            if event == "city" {
                print("城市点击")
            }
            
            // Filter
            if event == "filter" {
                let board = WNFilterBoard.init()
                board.toursModel = _self.toursModel
                board.model = _self.filterModel
                board.confimClick = { [weak self ] (model) in
                    guard let __self = self else { return }
                    __self.filterModel = model
                    __self.fetchData(isResetFilter: false,
                                     query: model.queryString(),
                                     inceptionQuery: __self.inceptionQuery)
                }
                _self.present(board, animated: true, completion: nil)
            }
            
            // Sort
            if event == "sort" {
                let board = WNSortBoard.init()
                board.model = _self.sortModel
                board.confirmClick = { [weak self] (model) in
                    guard let __self = self else { return }
                    __self.sortModel = model
                    if let filterModel = __self.filterModel {
                        __self.fetchData(isResetFilter: false,
                                         query: filterModel.queryString(),
                                         inceptionQuery: __self.inceptionQuery)
                    }
                }
                _self.present(board, animated: true)
            }
        }
        
        /// Table View
        let tableView = UITableView.init()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0.0)
            make.top.equalTo(condition.snp.bottom).offset(0.0)
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
