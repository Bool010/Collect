//
//  UITableView+Extension.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/8.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerClassOf<T: UITableViewCell>(_: T.Type) where T: Reusable {
        
        register(T.self, forCellReuseIdentifier: T.wn_reuseIdentifier)
    }
    
    func registerNibOf<T: UITableViewCell>(_: T.Type) where T: Reusable, T: NibLoadable {
        
        let nib = UINib(nibName: T.wn_nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.wn_reuseIdentifier)
    }
    
    func registerHeaderFooterClassOf<T: UITableViewHeaderFooterView>(_: T.Type) where T: Reusable {
        
        register(T.self, forHeaderFooterViewReuseIdentifier: T.wn_reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T where T: Reusable {
        
        guard let cell = self.dequeueReusableCell(withIdentifier: T.wn_reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.wn_reuseIdentifier)")
        }
        
        return cell
    }
    
    func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>() -> T where T: Reusable {
        
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.wn_reuseIdentifier) as? T else {
            fatalError("Could not dequeue HeaderFooter with identifier: \(T.wn_reuseIdentifier)")
        }
        
        return view
    }
    
}
