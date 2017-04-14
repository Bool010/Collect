//
//  WNRecommendBoard.swift
//  Wannar
//
//  Created by 付国良 on 2016/11/21.
//  Copyright © 2016年 玩哪儿. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import Dispatch
import SnapKit

class WNRecommendBoard: WNBaseBoard {
    
    var model: WNRecommendModel?
    var collectionView: UICollectionView?
    
    // MARK: - <<<<<<<<<<<<<<<< Life Cycle >>>>>>>>>>>>>>>> -
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.buildUI()
        WNRecommendAPI.fetch { [weak self] (model) in
            if let _self = self {
                _self.model = model
                _self.collectionView?.delegate = self
                _self.collectionView?.dataSource = self
                _self.collectionView?.reloadData()
            }
        }
//        let loadingView = WNLoadingView.construction()
//        self.view.addSubview(loadingView)
//        loadingView.handle = {
//            DispatchQueue.delay(2) {
//                loadingView.loadFail()
//            }
//        }
//        loadingView.beginLoad()
        
        
//        let array = ["apple", "objective-c", "swift"]
//        let a = array[safe: 2]
//        wn_print(a ?? "当前数组索引值不存在", file:#file, method: #function, line: #line)
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - <<<<<<<<<<<<<<<< Nofifaction Action >>>>>>>>>>>>>>>> -
    
    
    // MARK: - <<<<<<<<<<<<<<<< Event >>>>>>>>>>>>>>>> -
    fileprivate func buildUI() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        /// CollectionView
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview().offset(0.0)
        }
//        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.registerClassOf(WNRecommendMeauCCell.self)
        self.collectionView = collectionView;
    }
    
    
    // MARK: - <<<<<<<<<<<<<<<< Dealloc >>>>>>>>>>>>>>>> -
    deinit {
        wn_deinitMessage("推荐页")
    }
}


extension WNRecommendBoard: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (self.model?.data.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let a = self.model?.data[section]
        
        if a is WNRecommendModel.Banners {
            let x: WNRecommendModel.Banners = a as! WNRecommendModel.Banners
            return x.data.count
        }
        if a is WNRecommendModel.Meaus {
            let x: WNRecommendModel.Meaus = a as! WNRecommendModel.Meaus
            return x.data.count
        }
        if a is WNRecommendModel.Weeklys {
            let x: WNRecommendModel.Weeklys = a as! WNRecommendModel.Weeklys
            return x.data.count
        }
        if a is WNRecommendModel.Thems {
            let x: WNRecommendModel.Thems = a as! WNRecommendModel.Thems
            return x.data.count
        }
        if a is WNRecommendModel.Scenics {
            let x: WNRecommendModel.Scenics = a as! WNRecommendModel.Scenics
            return x.data.count
        }
        if a is WNRecommendModel.Seasons {
            let x: WNRecommendModel.Seasons = a as! WNRecommendModel.Seasons
            return x.data.count
        }
        if a is WNRecommendModel.MiniTours {
            let x: WNRecommendModel.MiniTours = a as! WNRecommendModel.MiniTours
            return x.data.count
        }
        if a is WNRecommendModel.Hots {
            let x: WNRecommendModel.Hots = a as! WNRecommendModel.Hots
            return x.data.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WNRecommendMeauCCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        
        let a = self.model?.data[indexPath.section]
        if a is WNRecommendModel.Meaus {
            let x: WNRecommendModel.Meaus = a as! WNRecommendModel.Meaus
            for i in 0 ..< x.data.count {
                let meau = x.data[i]
                let btn = cell.btns[i]
                btn.set(image: meau.image,
                        imageSize:CGSize.init(width: 35, height: 35),
                        isURL: true,
                        title: meau.text,
                        type: .top,
                        space: 5.0)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: UIScreen.width, height: 130)
    }
}
