//
//  WNCityBoard.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/15.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

// MARK: - Life Cycle
class WNCityBoard: UIViewController {

    fileprivate var index: Int = 0
    fileprivate var groupModel: WNCityGroupModel = WNCityGroupModel.init()
    fileprivate var model: Array<WNCityAreaModel> = []
    fileprivate var collectionView: UICollectionView!
    fileprivate var searchBar: UISearchBar!
    fileprivate var areaMatchArr = [["美国", "america", "usa", "us", "meiguo"], ["欧洲", "europe", "ouzhou"], ["加拿大", "canada", "jianada"], ["南美", "southamerica", "nanmei"]]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        buildUI()
        fetchData()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        wn_deinitMessage("切换城市")
    }
}

// MARK: - UI
extension WNCityBoard {
    fileprivate func buildUI() -> Void {
        
        view.backgroundColor = .white
        
        /// Navigation
        let navView = UIView.init()
        view.addSubview(navView)
        navView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().offset(0.0)
            make.height.equalTo(64.0)
        }
        
        let leftBtn = UIButton.init()
        navView.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview().offset(0.0)
            make.top.equalToSuperview().offset(20.0)
            make.width.equalTo(50.0)
        }
        leftBtn.addControlEvent(.touchUpInside) { [weak self] (btn) in
            guard let __self = self else { return }
            __self.popViewController()
        }
        
        let lineView = UIView.init()
        lineView.backgroundColor = UIColor.separatorColor
        navView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        let searchBar = UISearchBar.init()
        searchBar.backgroundColor = UIColor.white
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "可以输入您想查找的城市"
        navView.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.left.equalTo(leftBtn.snp.right).offset(0.0)
            make.top.equalToSuperview().offset(20.0)
            make.bottom.equalToSuperview().offset(-1.0)
            make.right.equalToSuperview().offset(-15.0)
        }
        searchBar.delegate = self
        self.searchBar = searchBar
        
        /// Collection
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 10.0
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 15, right: 0)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0.0)
            make.top.equalTo(navView.snp.bottom).offset(0.0)
        }
        collectionView.registerClassOf(WNCityCCell.self)
        collectionView.registerHeaderClassOf(WNCityReusableView.self)
        self.collectionView = collectionView
    }
}

// MARK: - Function
extension WNCityBoard {
    
    fileprivate func fetchData() {
        
        WNDepartureAPI.select(success: { [weak self] (groupModel) in
            guard let _self = self else { return }
            _self.groupModel = groupModel
            _self.model = _self.groupModel.group
            _self.collectionView.delegate = _self
            _self.collectionView.dataSource = _self
        })
    }
}


// MARK: - Delegate
extension WNCityBoard: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, WNTabControlDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model[section].data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let x = model[indexPath.section].data[indexPath.item]
        let cell: WNCityCCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.model = x
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: UIScreen.width, height: model[section].data.count > 0 ? 60 : 0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: WNCityReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, forIndexPath: indexPath)
        header.title = model[indexPath.section].area
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (UIScreen.width - 50.0) / 3.0
        return CGSize.init(width: width, height: width * 1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 15, 0, 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = model[indexPath.section].data[indexPath.item]
        print(x.nameCN)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.searchBar.isFirstResponder {
            self.searchBar.resignFirstResponder()
        }
    }
}

extension WNCityBoard: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        var isAreaMatch = false
        var index = 0
        for i in 0 ..< areaMatchArr.count {
            for str in areaMatchArr[i] {
                if str == searchText.lowercased().replacingOccurrences(of: " ", with: "") {
                    isAreaMatch = true
                    index = i
                    break
                }
            }
        }
        
        if searchText == "" {
            model = groupModel.group
        } else if isAreaMatch {
            model = [groupModel.group[index]]
        } else {
            var result: Array<WNCityAreaModel> = []
            for areaModel in groupModel.group {
                let x = areaModel.data.filter({ (model) -> Bool in
                    let input = searchText.lowercased().replacingOccurrences(of: " ", with: "")
                    let pinyin = model.pinyin.lowercased().replacingOccurrences(of: " ", with: "")
                    let initialPinyin = model.initialPinyin.lowercased().replacingOccurrences(of: " ", with: "")
                    let en = model.nameEN.lowercased().replacingOccurrences(of: " ", with: "")
                    let ch = model.nameCN.replacingOccurrences(of: " ", with: "")
                    
                    return (pinyin =~ "\(input)+")
                        || (initialPinyin =~ "\(input)+")
                        || (en =~ "\(input)+")
                        || (ch =~ "\(input)+")
                })
                result.append(WNCityAreaModel.init(areaModel.area, x))
            }
        
            model = result
        }
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
