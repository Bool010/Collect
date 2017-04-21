//
//  WNRecommendMinisCCell.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/19.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNRecommendMinisCCell: UICollectionViewCell {
    
    var collectionView: UICollectionView!
    var model: WNRecommendModel.MiniTours?
    var isScrolling = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func buildUI() -> Void {
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().offset(0.0)
            make.bottom.equalToSuperview().offset(-10.0)
        }
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.registerClassOf(WNRecommendWeekCCell.self)
        self.collectionView = collectionView
        
        /// Line View
        let lineView = UIView.init()
        lineView.backgroundColor = UIColor.separatorColor()
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.right.equalToSuperview().offset(-15.0)
            make.bottom.equalToSuperview().offset(0.0)
            make.height.equalTo(0.5)
        }
    }
}

extension WNRecommendMinisCCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = self.model {
            return model.data.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: WNRecommendWeekCCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        if let data = self.model?.data[indexPath.item] {
            cell.model = data
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: UIScreen.width / 5.0 * 3.0,
                           height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 12, 0, 12);
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if cell is WNRecommendWeekCCell {
            let x: WNRecommendWeekCCell = cell as! WNRecommendWeekCCell
            x.containerView.layer.shouldRasterize = isScrolling
        }
    }
    
    func visibleCellsShouldRasterize(aBool:Bool){
        for cell in collectionView.visibleCells as! [WNRecommendWeekCCell]{
            cell.containerView.layer.shouldRasterize = aBool;
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isScrolling = false
        self.visibleCellsShouldRasterize(aBool: isScrolling)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity == CGPoint.zero{
            isScrolling = false
            self.visibleCellsShouldRasterize(aBool: isScrolling)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isScrolling = true
        self.visibleCellsShouldRasterize(aBool: isScrolling)
        
    }
}
