//
//  NibLoadable.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/8.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

protocol NibLoadable {
    
    static var wn_nibName: String { get }
    
}


/// UITabelViewCell
extension UITableViewCell: NibLoadable {
    
    static var wn_nibName: String {
        return String(describing: self)
    }
    
}



/// UICollectionReusableView
extension UICollectionReusableView: NibLoadable {

    static var wn_nibName: String {
        return String(describing: self)
    }
    
}
