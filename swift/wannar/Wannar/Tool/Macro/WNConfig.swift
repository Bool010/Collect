//
//  MacroURL.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/14.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation

enum WNItemType {
    
    case other, scenic, activity, yelp, airport, oneDayTour, tour, hotel, car, note
    
    static func planInt(type: WNItemType) -> Int32 {
        switch type {
        case .scenic:       return 1
        case .activity:     return 2
        case .yelp:         return 4
        case .oneDayTour:   return 8
        case .tour:         return 16
        case .airport:      return 64
        case .note:         return 128
        case .hotel:        return 512
        default: return 0
        }
    }
    
    static func planType(number: Int32) -> WNItemType {
        switch number {
        case 1:     return .scenic
        case 2:     return .activity
        case 4:     return .yelp
        case 8:     return .oneDayTour
        case 16:    return .tour
        case 64:    return .airport
        case 128:   return .note
        case 512:   return .hotel
        default:    return .other
        }
    }
    
    static func isShowInMap(type: WNItemType) -> Bool {
        switch type {
        case .scenic, .activity, .yelp, .hotel, .oneDayTour, .airport:
            return true
        default:
            return false
        }
    }
}

final public class WNConfig {
    
    /// Base URL
    public struct BaseURL {
        
        public static let release = "https://www.wannar.com/api/5.01/"
        public static let debug = "https://test.wannar.com/api/5.01"
        public static let website = "https://website.wannar.com/"
        public static let yelpImage = "https://yelp.wannar.com/"
        public static let scenicImage = "https://ins.wannar.com/"
    }
    
    
    /// Other URL
    public struct OtherURL {
        
        public static let appStore = "itms-apps://itunes.apple.com/app/id"
        public static let appStoreDownload = "https://itunes.apple.com/cn/app/chu-jing-you-wan-na-er-mei/id972562606?mt=8"
        public static let shareApp = "http://a.app.qq.com/o/simple.jsp?pkgname=com.wannar.wannar_adroid2"
    }
    
    
    /// Path
    public struct Path {
        // 首页推荐
        public static let recommend = "config/get-latest-homepage-json.php"
        // 注册
        public static let register = "register.php"
        // 登录
        public static let signIn = "login.php"
        
        public static let destinationTour = "scenic/get-scenic-tour.php"
        public static let destinationPlan = "redis-scenic-plan.php"
        public static let userFeedback = "uid-feedback.php"
        public static let addCredit = "user/add-credit.php"
        
        public static let planListInsert = "plan/reset-plan-items.php"
        public static let planListDelete = "plan/delete-plan.php"
        public static let planListUpdate = "plan/set-plan-items-detail.php"
        public static let planListSelect = "plan/get-plan-items-detail.php"
        
        public static let planDetailInsert = "plan/reset-plan-items.php"
        public static let planDetailDelete = "plan/reset-plan-items.php"
        public static let planDetailUpdate = "plan/reset-plan-items.php"
        public static let planDetailSelect = "plan/get-plan-items-detail.php"
    }
    
    
    /// SandBoxKey
    public struct SandboxKey {
        
        /// 当前城市ID
        public static let cityID = "wannar.config.sandboxKey.cityID"
        
        /// 语言
        public static let language = "wannar.config.sandboxKey.language"
        
        /// 距离
        public static let distance = "wannar.config.sandboxKey.distance"
        
        /// 货币
        public static let currency = "wannar.config.sandboxKey.currency"
        
        /// 未读订单
        public static let unreadOrder = "wannar.config.sandboxKey.unreadOrder"
        
        /// 用户信息
        public static let userModel = "wannar.config.sandboxKey.userModel"
        
        /// 用户名
        public static let account = "wannar.config.sandboxKey.account"
        
        /// 密码
        public static let password = "wannar.config.sandboxKey.password"
    }
    
    
    /// NotifitionName
    public struct NotifiyName {
        
        /// 语言改变
        public static let languageChange = "wannar.notification.name.languageChange"
    }
    
    /// FontName
    public struct FontName {
        // 楷体-常规体
        public static let kaitiRegular = "STKaitiSC-Regular"
        // 楷体-粗体
        public static let kaitiBold = "STKaitiSC-Bold"
        // 楷体-黑体
        public static let kaitiBlack = "STKaitiSC-Black"
    }
}

