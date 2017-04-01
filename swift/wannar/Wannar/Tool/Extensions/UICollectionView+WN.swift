//
//  UICollectionView+Extension.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/8.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit


extension UICollectionView {
    
    func registerClassOf<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        
        register(T.self, forCellWithReuseIdentifier: T.wn_reuseIdentifier)
    }
    
    
    func registerNibOf<T: UICollectionViewCell>(_: T.Type) where T: Reusable, T: NibLoadable {
        
        let nib = UINib(nibName: T.wn_nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.wn_reuseIdentifier)
    }
    
    
    func registerHeaderNibOf<T: UICollectionReusableView>(_: T.Type) where T: Reusable, T: NibLoadable {
        
        let nib = UINib(nibName: T.wn_nibName, bundle: nil)
        register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: T.wn_reuseIdentifier)
    }
    
    
    func registerFooterClassOf<T: UICollectionReusableView>(_: T.Type) where T: Reusable {
        
        register(T.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: T.wn_reuseIdentifier)
    }
    
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: Reusable {
        
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.wn_reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.wn_reuseIdentifier)")
        }
        return cell
    }
    
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, forIndexPath indexPath: IndexPath) -> T where T: Reusable {
        
        guard let view = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.wn_reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue supplementary view with identifier: \(T.wn_reuseIdentifier), kind: \(kind)")
        }
        return view
    }
}
