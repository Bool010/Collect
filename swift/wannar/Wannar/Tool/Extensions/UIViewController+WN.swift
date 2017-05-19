//
//  UIViewController+WN.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/15.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    @discardableResult
    func popViewController() -> UIViewController? {
        return self.navigationController?.popViewController(animated: true)
    }
    
    func push(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
