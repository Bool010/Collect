//
//  Reusable.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/8.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

protocol Reusable: class {
    
    static var wn_reuseIdentifier: String { get }
}

extension UITableViewCell: Reusable {
    
    static var wn_reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView: Reusable {
    
    static var wn_reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: Reusable {
    
    static var wn_reuseIdentifier: String {
        return String(describing: self)
    }
}
