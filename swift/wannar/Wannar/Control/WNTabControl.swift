//
//  WNTabControl.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/16.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol WNTabControlDelegate: NSObjectProtocol {
    
    @objc optional func tabControlDidSelected(index: Int)
}

class WNTabControl: UIView {
    
    var data: Array<String> = [] {
        didSet {
            self.buildUI()
        }
    }
    var selectedIndexPath = IndexPath.init(item: 0, section: 0)
    var itemWidth: Double = UIScreen.width / 5.0
    weak open var delegate: WNTabControlDelegate?
    fileprivate var collectionView: UICollectionView!
    fileprivate var slideView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
extension WNTabControl {
    
    fileprivate func buildUI() {
        
        // Line View
        let lineHeight = 2.0
        let lineView = UIView.init()
        lineView.backgroundColor = UIColor.separatorColor
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0.0)
            make.height.equalTo(lineHeight)
        }
        
        // Slide View
        let slideView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: itemWidth, height: lineHeight))
        slideView.backgroundColor = UIColor.themColor
        lineView.addSubview(slideView)
        self.slideView = slideView
        
        // Collection View
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        layout.itemSize = CGSize.init(width: itemWidth, height: 30.0)
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().offset(0.0)
            make.bottom.equalTo(lineView.snp.top).offset(0.0)
        }
        collectionView.registerClassOf(WNTabControlCCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView = collectionView
    }
}


// MARK: - Function
extension WNTabControl {
    
    fileprivate func getSelectedCellPosition() -> CGRect? {
        let cell = self.collectionView.cellForItem(at: selectedIndexPath)
        if let cell = cell {
            return collectionView.convert(cell.frame, to: self)
        } else {
            return nil
        }
    }
    
    fileprivate func changeSliderViewPosition(animated: Bool = false) {
        let rect = getSelectedCellPosition()
        if let rect = rect {
            if animated {
                UIView.animate(withDuration: 0.3, animations: { [weak self] in
                    guard let _self = self else { return }
                    _self.slideView.center.x = (rect.origin.x.double + _self.itemWidth/2.0).cgFloat
                })
            } else {
                slideView.center.x = (rect.origin.x.double + itemWidth/2.0).cgFloat
            }
            
        }
    }
    
}


// MARK: - Delegate
extension WNTabControl: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WNTabControlCCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.title = data[indexPath.item]
        cell.isSelect = indexPath == self.selectedIndexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            if let tabControl = delegate.tabControlDidSelected {
                tabControl(indexPath.item)
            }
        }
        
        
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        if indexPath != self.selectedIndexPath {
            collectionView.deselectItem(at: self.selectedIndexPath, animated: true)
        }
        self.selectedIndexPath = indexPath
        self.changeSliderViewPosition(animated: true)
        collectionView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.changeSliderViewPosition()
    }
}

// MARK: - Cell
class WNTabControlCCell: UICollectionViewCell {
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var isSelect: Bool = false {
        didSet {
            titleLabel.textColor = isSelect ? .themColor : .textColor
        }
    }
    private var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        let titleLabel = UILabel.init(color: .textColor, size: 15.0, textAlignment: .center)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview().offset(0.0)
        }
        self.titleLabel = titleLabel
    }
}
