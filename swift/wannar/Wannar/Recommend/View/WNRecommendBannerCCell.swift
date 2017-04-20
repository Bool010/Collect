//
//  WNRecommendBannerCell.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/14.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit
import FSPagerView


class WNRecommendBannerCCell: UICollectionViewCell {
    
    var model: WNRecommendModel.Banners! {
        didSet {
            self.pageControl.numberOfPages = model.data.count
        }
    }
    private var pageView: FSPagerView!
    fileprivate var pageControl: FSPageControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func buildUI() -> Void {
        
        let pageView = FSPagerView.init()
        self.contentView.addSubview(pageView)
        pageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview().offset(0.0)
        }
        pageView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "FSPagerViewCell")
        pageView.automaticSlidingInterval = 5.0
        pageView.isInfinite = true
        pageView.delegate = self
        pageView.dataSource = self
        self.pageView = pageView
        
        let pageControl = FSPageControl.init()
        pageControl.contentHorizontalAlignment = .center
        pageControl.setFillColor(.white, for: .normal)
        pageControl.setFillColor(UIColor.themColor(), for: .selected)
        pageView.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(0.0)
            make.bottom.equalToSuperview().offset(-15.0)
            make.height.equalTo(20.0)
        }
        self.pageControl = pageControl
        
    }
}

extension WNRecommendBannerCCell: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return model.data.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "FSPagerViewCell", at: index)
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.imageView?.kf.setImage(with: URL.init(string: model.data[index].image))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        self.pageControl.currentPage = index
    }
}
