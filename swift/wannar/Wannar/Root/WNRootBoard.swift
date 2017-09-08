//
//  WNRootBoard.swift
//  Wannar
//
//  Created by 付国良 on 2016/11/21.
//  Copyright © 2016年 玩哪儿. All rights reserved.
//

import UIKit
import SwiftyJSON

class WNRootBoard: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - ------------------------ Life Cycle ------------------------
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setAppearance()
        self.initChildBoard()
        
        // 监测网络连接状态
        startMonitoringNetwork()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        // 显示FPS
        wn_showFPS()
        let fpsLabel = WNFPSLabel.init(frame: CGRect.init(x: 15, y: UIScreen.main.bounds.size.height - 80.0, width: 60.0, height: 25.0))
        self.view.addSubview(fpsLabel)
        let tap = UITapGestureRecognizer.init()
        tap.addClosure("fps") { 
            wn_print("成功")
        }
        fpsLabel.addGestureRecognizer(tap)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    
    // MARK: - ------------------------ Event ------------------------
    /// Set Appearance
    private func setAppearance() -> Void {
        
        let tabBarItem = UITabBarItem.appearance()
        tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.textColor], for: .normal)
        tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.themColor], for: .selected)
        tabBar.isTranslucent = false
        
        let navigation = UINavigationBar.appearance()
        navigation.isTranslucent = false
        navigation.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.textColor,
                                          NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16.0)]
        
    }
    
    /// 初始化子控制器
    private func initChildBoard() -> Void {
        
        let boardNameArr: [String] = ["Wannar.WNRecommendBoard", "Wannar.WNDestinationBoard", "Wannar.WNPlanListBoard", "Wannar.WNMeBoard"]
        let titleArr: [String] = ["推荐".Root, "目的地".Root, "规划".Root, "我的".Root]
        let imageNameArr: [String] = ["", "", "", ""]
        let selectImageNameArr: [String] = ["", "", "", ""]
        
        for i in 0 ..< boardNameArr.count {
            
            let board = NSClassFromString(boardNameArr[i]) as? UIViewController.Type
            self.setChildBoard(board: board!.init(),
                               title: titleArr[i],
                               imageName: imageNameArr[i],
                               selectImageName: selectImageNameArr[i])            
        }
    }
    
    /// 设置子控制器
    private func setChildBoard(board: UIViewController, title: String, imageName: String, selectImageName: String) -> Void {
        
        board.title = title
        board.tabBarItem.titlePositionAdjustment = UIOffsetMake(0.0, -15.0)
        board.tabBarItem.image = UIImage.init(named: imageName)?.withRenderingMode(.alwaysOriginal)
        board.tabBarItem.selectedImage = UIImage.init(named: selectImageName)?.withRenderingMode(.alwaysOriginal)
        let nav: WNNavigationBoard = WNNavigationBoard.init(rootViewController: board)
        self.addChildViewController(nav)
        
    }
    
    
    // MARK: - ------------------------ Delegate ------------------------
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    
    
    // MARK: - ------------------------ Deinit ------------------------
    deinit {
        print("销毁")
    }
}
