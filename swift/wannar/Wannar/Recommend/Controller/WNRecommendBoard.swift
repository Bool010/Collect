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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.buildUI()
        self.fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Event
    fileprivate func buildUI() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        /// CollectionView
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        if #available(iOS 10.0, *) {
            layout.itemSize = UICollectionViewFlowLayoutAutomaticSize
        } else {
            // Fallback on earlier versions
        }
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview().offset(0.0)
        }
        collectionView.registerClassOf(WNRecommendBannerCCell.self)
        collectionView.registerClassOf(WNRecommendMeauCCell.self)
        collectionView.registerClassOf(WNRecommendWeeksCCell.self)
        collectionView.registerClassOf(WNRecommendThemsCCell.self)
        collectionView.registerClassOf(WNRecommendScenicsCCell.self)
        collectionView.registerClassOf(WNRecommendCoverCCell.self)
        collectionView.registerClassOf(WNRecommendSeasonsCCell.self)
        collectionView.registerClassOf(WNRecommendMinisCCell.self)
        collectionView.registerClassOf(WNRecommendHotCCell.self)
        collectionView.registerHeaderClassOf(WNRecommendHeaderView.self)
        self.collectionView = collectionView;
    }
    
    
    fileprivate func fetchData() -> Void {
        
        WNRecommendAPI.fetch { [weak self] (model) in
            if let strongSelf = self {
                strongSelf.model = model
                strongSelf.collectionView?.delegate = strongSelf
                strongSelf.collectionView?.dataSource = strongSelf
                strongSelf.collectionView?.reloadData()
            }
        }
    }
    
    // MARK: - Dealloc
    deinit {
        wn_deinitMessage("推荐页")
    }
}


extension WNRecommendBoard: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let model = self.model {
            return model.data.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var num = 0
        let a = self.model?.data[section]
        if a is WNRecommendModel.Seasons {
            let x: WNRecommendModel.Seasons = a as! WNRecommendModel.Seasons
            num = x.isHaveCover ? 1 + x.data.count : x.data.count
        } else if a is WNRecommendModel.Hots {
            let x: WNRecommendModel.Hots = a as! WNRecommendModel.Hots
            num = x.data.count
        } else {
            num = 1
        }
        print(num)
        return num
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let a = self.model?.data[section]
        if a is WNRecommendModel.Banners || a is WNRecommendModel.Meaus {
           return CGSize.zero
        } else {
            return CGSize.init(width: UIScreen.width, height: 70.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let a = self.model?.data[indexPath.section]
        let reusableView: WNRecommendHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, forIndexPath: indexPath)
        
        if a is WNRecommendModel.Weeklys {
            let x: WNRecommendModel.Weeklys = a as! WNRecommendModel.Weeklys
            reusableView.icon.kf.setImage(with: URL.init(string: x.icon))
            reusableView.title.text = x.title.app()
            reusableView.subtitle.text = x.subtitle.app()
        }
        
        if a is WNRecommendModel.Thems {
            let x: WNRecommendModel.Thems = a as! WNRecommendModel.Thems
            reusableView.icon.kf.setImage(with: URL.init(string: x.icon))
            reusableView.title.text = x.title.app()
            reusableView.subtitle.text = x.subtitle.app()
        }
        
        if a is WNRecommendModel.Scenics {
            let x: WNRecommendModel.Scenics = a as! WNRecommendModel.Scenics
            reusableView.icon.kf.setImage(with: URL.init(string: x.icon))
            reusableView.title.text = x.title.app()
            reusableView.subtitle.text = x.subtitle.app()
        }
        
        if a is WNRecommendModel.Seasons {
            let x: WNRecommendModel.Seasons = a as! WNRecommendModel.Seasons
            reusableView.icon.kf.setImage(with: URL.init(string: x.icon))
            reusableView.title.text = x.title.app()
            reusableView.subtitle.text = x.subtitle.app()
        }
        
        if a is WNRecommendModel.MiniTours {
            let x: WNRecommendModel.MiniTours = a as! WNRecommendModel.MiniTours
            reusableView.icon.kf.setImage(with: URL.init(string: x.icon))
            reusableView.title.text = x.title.app()
            reusableView.subtitle.text = x.subtitle.app()
        }
        
        if a is WNRecommendModel.Hots {
            let x: WNRecommendModel.Hots = a as! WNRecommendModel.Hots
            reusableView.icon.kf.setImage(with: URL.init(string: x.icon))
            reusableView.title.text = x.title.app()
            reusableView.subtitle.text = x.subtitle.app()
        }
        return reusableView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let a = self.model?.data[indexPath.section]
        
        /// Banners
        if a is WNRecommendModel.Banners {
            let cell: WNRecommendBannerCCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            let x: WNRecommendModel.Banners = a as! WNRecommendModel.Banners
            cell.model = x
            return cell
        }
        
        /// 菜单按钮
        if a is WNRecommendModel.Meaus {
            let cell: WNRecommendMeauCCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            let x: WNRecommendModel.Meaus = a as! WNRecommendModel.Meaus
            cell.slogan.text = x.slogan
            for i in 0 ..< x.data.count {
                let meau = x.data[i]
                let btn = cell.btns[i]
                btn.imageView.kf.setImage(with: URL.init(string: meau.image))
                btn.titleLabel.text = meau.text
                btn.click = { (btn) in
                    wn_print("按钮点击成功")
                }
            }
            return cell
        }
        
        /// 本周特卖
        if a is WNRecommendModel.Weeklys {
            let cell: WNRecommendWeeksCCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            let x: WNRecommendModel.Weeklys = a as! WNRecommendModel.Weeklys
            cell.model = x
            return cell
        }
        
        /// 主题玩法
        if a is WNRecommendModel.Thems {
            let cell: WNRecommendThemsCCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            let x: WNRecommendModel.Thems = a as! WNRecommendModel.Thems
            cell.model = x
            return cell
        }
        
        /// 必玩景点
        if a is WNRecommendModel.Scenics {
            let cell: WNRecommendScenicsCCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            let x: WNRecommendModel.Scenics = a as! WNRecommendModel.Scenics
            cell.model = x
            return cell
        }
        
        /// 当季热推
        if a is WNRecommendModel.Seasons {
            let x: WNRecommendModel.Seasons = a as! WNRecommendModel.Seasons
            if x.isHaveCover && indexPath.item == 0 {
                let cell: WNRecommendCoverCCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.model = x
                return cell
            } else {
                let cell: WNRecommendSeasonsCCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.model = x.isHaveCover ? x.data[indexPath.item - 1] : x.data[indexPath.item]
                return cell
            }
        }
        
        /// 舒适小团
        if a is WNRecommendModel.MiniTours {
            let cell: WNRecommendMinisCCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            let x: WNRecommendModel.MiniTours = a as! WNRecommendModel.MiniTours
            cell.model = x
            return cell
        }
        
        /// 爆款热销
        if a is WNRecommendModel.Hots {
            let cell: WNRecommendHotCCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            let x: WNRecommendModel.Hots = a as! WNRecommendModel.Hots
            cell.model = x.data[indexPath.item]
            return cell
        }
        let cell: WNRecommendMeauCCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let a = self.model?.data[indexPath.section]
        if a is WNRecommendModel.Banners {
            return CGSize.init(width: UIScreen.width, height: 200)
        }
        if a is WNRecommendModel.Meaus {
            return CGSize.init(width: UIScreen.width, height: 120)
        }
        if a is WNRecommendModel.Weeklys {
            return CGSize.init(width: UIScreen.width, height: 220)
        }
        if a is WNRecommendModel.Thems {
            return CGSize.init(width: UIScreen.width, height: 90)
        }
        if a is WNRecommendModel.Scenics {
            return CGSize.init(width: UIScreen.width, height: 240)
        }
        if a is WNRecommendModel.Seasons {
            let x: WNRecommendModel.Seasons = a as! WNRecommendModel.Seasons
            if x.isHaveCover && indexPath.item == 0 {
                return CGSize.init(width: UIScreen.width, height: 180)
            } else {
                return CGSize.init(width: UIScreen.width, height: 80)
            }
        }
        if a is WNRecommendModel.MiniTours {
            return CGSize.init(width: UIScreen.width, height: 220)
        }
        return CGSize.init(width: UIScreen.width, height: 180)
        
    }
}
