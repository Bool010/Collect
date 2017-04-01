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

    // MARK: - <<<<<<<<<<<<<<<< Life Cycle >>>>>>>>>>>>>>>> -
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        
        let loadingView = WNLoadingView.construction()
        self.view.addSubview(loadingView)
        loadingView.handle = {
            DispatchQueue.delay(2) {
                loadingView.loadFail()
            }
        }
        loadingView.beginLoad()
        
        
        let array = ["apple", "objective-c", "swift"]
        let a = array[safe: 2]
        wn_print(a ?? "当前数组索引值不存在", file:#file, method: #function, line: #line)
        
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
    }
    
    
    // MARK: - <<<<<<<<<<<<<<<< IBoutlet >>>>>>>>>>>>>>>> -
    
    // MARK: - <<<<<<<<<<<<<<<< Get/Set >>>>>>>>>>>>>>>> -
    
    // MARK: - <<<<<<<<<<<<<<<< Dealloc >>>>>>>>>>>>>>>> -
    
}


//extension WNRecommendBoard: UICollectionViewDelegate, UICollectionViewDataSource {
//    
//}
