//
//  WNNavigationBoard.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/24.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNNavigationBoard: UINavigationController {

    var currentShowVC: UIViewController?
    
    override init(rootViewController: UIViewController) {
        
        super.init(rootViewController: rootViewController)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
        self.delegate = self
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        viewController.hidesBottomBarWhenPushed = self.childViewControllers.count > 0
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: animated)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        return super.popToViewController(viewController, animated: animated)
    }

}

/// Note: 写以下方法为解决自定义NavigationController系统侧滑返回失效问题
extension WNNavigationBoard: UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {

    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        if (navigationController.viewControllers.count == 1) {
            self.currentShowVC = nil
        } else {
            self.currentShowVC = viewController
        }
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if (gestureRecognizer == self.interactivePopGestureRecognizer) {
            return (self.currentShowVC == self.topViewController);
        }
        return true
    }
}
