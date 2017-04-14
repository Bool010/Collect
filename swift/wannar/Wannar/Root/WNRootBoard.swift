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
        
        let params = ["solr": "scenic",
                      "query": "col_scenery_id:46",
                      "facets": "col_scenery_recommand_tour",
                      "facetExtensions": "col_scenery_recommand_tour,tour,tour_id,is_discount_now|tour_main_picture|tour_id|tour_title_app|tour_display_price|tour_discount_percent_now|tour_activity|current_price"]
        let url = "list/get-list.php"
        
        WNHttpClient.post(subURL: url, param: params, handle: { (response) -> JSON? in
            return nil;
        }, success: { (json) in
            print(json)
        }, fail: { (error) in
            print(error)
        }) { () in
            
        }
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
        
        let tabBar = UITabBarItem.appearance()
        tabBar.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.textColor()], for: .normal)
        tabBar.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.themColor()], for: .selected)
        
        let navigation = UINavigationBar.appearance()
        navigation.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.textColor(),
                                          NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16.0)]
        
    }
    
    /// 初始化子控制器
    private func initChildBoard() -> Void {
        
        let boardNameArr: [String] = ["Wannar.WNRecommendBoard", "Wannar.WNDestinationBoard", "Wannar.WNPlanListBoard", "Wannar.WNMeBoard"]
        let titleArr: [String] = ["推荐", "目的地", "规划", "我的"]
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
        self.addChildViewController(UINavigationController.init(rootViewController: board))
        
    }
    
    
    // MARK: - ------------------------ Delegate ------------------------
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    
    
    // MARK: - ------------------------ Deinit ------------------------
    deinit {
        print("销毁")
    }
}
