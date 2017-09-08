//
//  WNRecommendModel.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/13.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit
import ObjectMapper

struct WNRecommendModel: Mappable {
    
    fileprivate struct WNRecommendKey {
        /// 循环滚动
        static let banner = "banners"
        /// 菜单按钮
        static let menu = "menu"
        /// 本周特卖
        static let weekly = "weekly-promotion"
        /// 主题玩法
        static let theme = "theme"
        /// 必玩景点
        static let scenic = "scenic-tag"
        /// 当季热推
        static let season = "seasons"
        /// 舒适小团
        static let miniTour = "mini-tours"
        /// 爆款热销
        static let hot = "hot"
    }
    
    var data: Array = [Any]()
    var version: Int = 0
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        let sections: [[String : Any]] = map.JSON["sections"] as! [[String : Any]]
        for dic in sections {
            let idName = dic["id"] as! String
            if idName == WNRecommendKey.banner {
                if let banners = Mapper<WNRecommendModel.Banners>().map(JSONString: wn_toJSONString(object: dic)) {
                    data.append(banners)
                }
            }
            if idName == WNRecommendKey.menu {
                if let meau = Mapper<WNRecommendModel.Meaus>().map(JSONString: wn_toJSONString(object: dic)) {
                    data.append(meau)
                }
            }
            if idName == WNRecommendKey.weekly {
                if let weekly = Mapper<WNRecommendModel.Weeklys>().map(JSONString: wn_toJSONString(object: dic)) {
                    data.append(weekly)
                }
            }
            if idName == WNRecommendKey.theme {
                if let theme = Mapper<WNRecommendModel.Thems>().map(JSONString: wn_toJSONString(object: dic)) {
                    data.append(theme)
                }
            }
            if idName == WNRecommendKey.scenic {
                if let scenic = Mapper<WNRecommendModel.Scenics>().map(JSONString: wn_toJSONString(object: dic)) {
                    data.append(scenic)
                }
            }
            if idName == WNRecommendKey.season {
                if let season = Mapper<WNRecommendModel.Seasons>().map(JSONString: wn_toJSONString(object: dic)) {
                    data.append(season)
                }
            }
            if idName == WNRecommendKey.miniTour {
                if let miniTour = Mapper<WNRecommendModel.MiniTours>().map(JSONString: wn_toJSONString(object: dic)) {
                    data.append(miniTour)
                }
            }
            if idName == WNRecommendKey.hot {
                if let hot = Mapper<WNRecommendModel.Hots>().map(JSONString: wn_toJSONString(object: dic)) {
                    data.append(hot)
                }
            }
        }
        version <- map["version"]
    }
    
    ///////// 循环滚动 /////////
    struct Banners: Mappable {
        var id: String = ""
        var enable: Bool = true
        var data: Array = [Banner]()
        struct Banner: Mappable {
            var action: String = ""
            var text: String = ""
            var param: Dictionary = [String: Any]()
            var image: String = ""
            var bigImage: String = ""
            init?(map: Map) {
                
            }
            mutating func mapping(map: Map) {
                action    <- map["action"]
                text      <- map["text"]
                param     <- map["param"]
                bigImage  <- map["big-image"]
                image     <- map["image"]
            }
        }
        
        init?(map: Map) { }
        mutating func mapping(map: Map) {
            id      <- map["id"]
            enable  <- map["enable"]
            data    <- map["data"]
        }
    }
    
    ///////// 菜单按钮 /////////
    struct Meaus: Mappable {
        var id: String = ""
        var enable: Bool = true
        var slogan: String = ""
        var app: Array = [Int]()
        var data: Array = [Meau]()
        init?(map: Map) { }
        mutating func mapping(map: Map) {
            id      <- map["id"]
            enable  <- map["enable"]
            slogan  <- map["slogan"]
            app     <- map["app"]
            data    <- map["data"]
            var x: [Meau] = []
            for i in app { x.append(data[i]) }
            data = x
        }
        
        struct Meau: Mappable {
            var action: String = ""
            var text: String = ""
            var param: Dictionary = [String: Any]()
            var image: String = ""
            
            init?(map: Map) { }
            mutating func mapping(map: Map) {
                action  <- map["action"]
                text    <- map["text"]
                param   <- map["param"]
                image   <- map["image"]
            }
        }
    }
    
    ///////// 本周特卖 /////////
    struct Weeklys: Mappable {
        var id: String = ""
        var enable: Bool = true
        var title: String = ""
        var subtitle: String = ""
        var icon: String = ""
        var data: Array = [RecommendTour]()
        
        init?(map: Map) { }
        mutating func mapping(map: Map) {
            id       <- map["id"]
            enable   <- map["enable"]
            title    <- map["title"]
            subtitle <- map["subtitle"]
            icon     <- map["icon"]
            data     <- map["data"]
        }
    }
    
    ///////// 主题玩法 /////////
    struct Thems: Mappable {
        var id: String = ""
        var enable: Bool = true
        var title: String = ""
        var subtitle: String = ""
        var icon: String = ""
        var data: Array = [Them]()
        
        init?(map: Map) { }
        mutating func mapping(map: Map) {
            id       <- map["id"]
            enable   <- map["enable"]
            title    <- map["title"]
            subtitle <- map["subtitle"]
            icon     <- map["icon"]
            data     <- map["data"]
        }
        
        struct Them: Mappable {
            var action: String = ""
            var text: String = ""
            var param: Dictionary = [String: Any]()
            var image: String = ""
            
            init?(map: Map) { }
            mutating func mapping(map: Map) {
                action <- map["action"]
                text   <- map["text"]
                param  <- map["param"]
                image  <- map["image"]
            }
        }
    }
    
    ///////// 必玩景点 /////////
    struct Scenics: Mappable {
        var id: String = ""
        var enable: Bool = true
        var title: String = ""
        var subtitle: String = ""
        var icon: String = ""
        var data: Array = [Scenic]()
        
        init?(map: Map) { }
        mutating func mapping(map: Map) {
            id       <- map["id"]
            enable   <- map["enable"]
            title    <- map["title"]
            subtitle <- map["subtitle"]
            icon     <- map["icon"]
            data     <- map["data"]
        }
        
        struct Scenic: Mappable {
            var action: String = ""
            var text: String = ""
            var param: Dictionary = [String: Any]()
            var image: String = ""
            
            init?(map: Map) { }
            mutating func mapping(map: Map) {
                action <- map["action"]
                text   <- map["text"]
                param  <- map["param"]
                image  <- map["image"]
            }
        }
    }
    
    ///////// 当季热推 /////////
    struct Seasons: Mappable {
        var id: String = ""
        var enable: Bool = true
        var title: String = ""
        var subtitle: String = ""
        var icon: String = ""
        var description: String = ""
        var image: String = ""
        var action: String = ""
        var text: String = ""
        var param: Dictionary = [String: Any]()
        var data: Array = [RecommendTour]()
        var isHaveCover: Bool {
            get {
                return !(self.image.isEmpty || self.image == "")
            }
        }
        
        init?(map: Map) { }
        mutating func mapping(map: Map) {
            id          <- map["id"]
            enable      <- map["enable"]
            title       <- map["title"]
            subtitle    <- map["subtitle"]
            icon        <- map["icon"]
            description <- map["description"]
            image       <- map["image"]
            action      <- map["action"]
            text        <- map["text"]
            param       <- map["param"]
            data        <- map["data"]
        }
    }
    
    ///////// 舒适小团 /////////
    struct MiniTours: Mappable {
        var id: String = ""
        var enable: Bool = true
        var title: String = ""
        var subtitle: String = ""
        var icon: String = ""
        var data: Array = [RecommendTour]()
        
        init?(map: Map) { }
        mutating func mapping(map: Map) {
            id       <- map["id"]
            enable   <- map["enable"]
            title    <- map["title"]
            subtitle <- map["subtitle"]
            icon     <- map["icon"]
            data     <- map["data"]
        }
    }
    
    ///////// 爆款热销 /////////
    struct Hots: Mappable {
        var id: String = ""
        var enable: Bool = true
        var title: String = ""
        var subtitle: String = ""
        var icon: String = ""
        var data: Array = [RecommendTour]()
        
        init?(map: Map) { }
        mutating func mapping(map: Map) {
            id       <- map["id"]
            enable   <- map["enable"]
            title    <- map["title"]
            subtitle <- map["subtitle"]
            icon     <- map["icon"]
            data     <- map["data"]
        }
    }
    
    ///////// 共通 团模型 /////////
    struct RecommendTour: Mappable {
        var id: Int = 0
        var mainPic: String = ""
        var departure: String = ""
        var displayPrice: Double = 0
        var isActivity: Bool = false
        var title: String = ""
        var titleApp: String = ""
        var discountPercentNow: Int = 0
        var isDiscountNow: Bool = false
        var discountEnd: String = ""
        var currentPrice: Int = 0
        var url: String = ""
        
        init?(map: Map) { }
        mutating func mapping(map: Map) {
            id                  <- map["tour_id"]
            mainPic             <- map["tour_main_picture"]
            departure           <- map["tour_departure_en_cn"]
            displayPrice        <- map["tour_display_price"]
            isActivity          <- map["tour_activity"]
            title               <- map["tour_title"]
            titleApp            <- map["tour_title_app"]
            discountPercentNow  <- map["tour_discount_percent_now"]
            isDiscountNow       <- map["is_discount_now"]
            discountEnd         <- map["tour_discount_end"]
            currentPrice        <- map["current_price"]
            url                 <- map["tour_url"]
        }
    }
}


class WNRecommendAPI: WNHttpClient {
    
    class func fetch(success: ((WNRecommendModel) -> Void)?) -> Void {
        
        let param = ["ver" : ""]

        self.post(subURL: WNConfig.Path.recommend, param: param, success: { (data) in
            let model = Mapper<WNRecommendModel>().map(JSONString: data)
            if let model = model,
               let success = success {
                success(model)
            }
        }, fail: { (error) in
            
        }) { () in
            
        }
        
    }
}
