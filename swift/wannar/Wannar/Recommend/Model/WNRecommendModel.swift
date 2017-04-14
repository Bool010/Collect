//
//  WNRecommendModel.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/13.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit
import SwiftyJSON

struct WNRecommendModel {
    
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
    
    init(response: JSON?) {
        
        if let response = response {
            let sections = response["sections"].arrayValue
            for dic in sections {
                let idName = dic["id"].stringValue
                
                if idName == WNRecommendKey.banner {
                    let banners = Banners.init(json: dic)
                    data.append(banners)
                }
                if idName == WNRecommendKey.menu {
                    let meau = Meaus.init(json: dic)
                    data.append(meau)
                }
                if idName == WNRecommendKey.weekly {
                    let weekly = Weeklys.init(json: dic)
                    data.append(weekly)
                }
                if idName == WNRecommendKey.theme {
                    let theme = Thems.init(json: dic)
                    data.append(theme)
                }
                if idName == WNRecommendKey.season {
                    let season = Seasons.init(json: dic)
                    data.append(season)
                }
                if idName == WNRecommendKey.miniTour {
                    let miniTour = MiniTours.init(json: dic)
                    data.append(miniTour)
                }
                if idName == WNRecommendKey.hot {
                    let hot = Hots.init(json: dic)
                    data.append(hot)
                }
            }
        } else {
            return
        }
    }
    
    
    
    
    ///////// 循环滚动 /////////
    struct Banners {
        var id: String = ""
        var enable: Bool = true
        var data: Array = [Banner]()
        struct Banner {
            var action: String = ""
            var text: String = ""
            var param: Dictionary = [String: JSON]()
            var image: String = ""
            var bigImage: String = ""
            
            init(json: JSON?) {
                if let json = json {
                    action = json["action"].stringValue
                    text = json["text"].stringValue
                    param = json["param"].dictionaryValue
                    bigImage = json["big-image"].stringValue
                    image = json["image"].stringValue
                }
            }
        }
        
        
        init(json: JSON?) {
            if let json = json {
                id = json["id"].stringValue
                enable = json["enable"].boolValue
                
                let dataArr = json["data"].arrayValue
                for dic in dataArr {
                    let banner = Banner.init(json: dic)
                    data.append(banner)
                }
            }
        }
    }
    
    ///////// 菜单按钮 /////////
    struct Meaus {
        var id: String = ""
        var enable: Bool = true
        var slogan: String = ""
        var app: Array = [JSON]()
        var data: Array = [Meau]()
        struct Meau {
            var action: String = ""
            var text: String = ""
            var param: Dictionary = [String: JSON]()
            var image: String = ""
            
            init(json: JSON?) {
                if let json = json {
                    action = json["action"].stringValue
                    text = json["text"].stringValue
                    param = json["param"].dictionaryValue
                    image = json["image"].stringValue
                }
            }
        }
        
        
        init(json: JSON?) {
            if let json = json {
                id = json["id"].stringValue
                enable = json["enable"].boolValue
                slogan = json["slogan"].stringValue
                app = json["app"].arrayValue
                
                let dataArr = json["data"].arrayValue
                for i in 0..<dataArr.count {
                    if app.contains(JSON.init(integerLiteral: i)) {
                        let dic = dataArr[i]
                        let banner = Meau.init(json: dic)
                        data.append(banner)
                    }
                }
            }
        }
    }
    
    ///////// 本周特卖 /////////
    struct Weeklys {
        var id: String = ""
        var enable: Bool = true
        var title: String = ""
        var subtitle: String = ""
        var icon: String = ""
        var data: Array = [RecommendTour]()
        
        init(json: JSON?) {
            if let json = json {
                id = json["id"].stringValue
                enable = json["enable"].boolValue
                title = json["slogan"].stringValue
                subtitle = json["subtitle"].stringValue
                icon = json["icon"].stringValue
                
                let dataArr = json["data"].arrayValue
                for dic in dataArr {
                    let banner = RecommendTour.init(json: dic)
                    data.append(banner)
                }
            } else {
                return
            }
        }
        
    }
    
    ///////// 主题玩法 /////////
    struct Thems {
        var id: String = ""
        var enable: Bool = true
        var title: String = ""
        var subtitle: String = ""
        var icon: String = ""
        var data: Array = [Them]()
        struct Them {
            var action: String = ""
            var text: String = ""
            var param: Dictionary = [String: JSON]()
            var image: String = ""
            init(json: JSON?) {
                if let json = json {
                    action = json["action"].stringValue
                    text = json["text"].stringValue
                    param = json["param"].dictionaryValue
                    image = json["image"].stringValue
                } else {
                    return
                }
            }
        }
        
        init(json: JSON?) {
            if let json = json {
                id = json["id"].stringValue
                enable = json["enable"].boolValue
                title = json["title"].stringValue
                subtitle = json["subtitle"].stringValue
                icon = json["icon"].stringValue
                
                let dataArr = json["data"].arrayValue
                for dic in dataArr {
                    let them = Them.init(json: dic)
                    data.append(them)
                }
            }
        }
    }
    
    ///////// 必玩景点 /////////
    struct Scenics {
        var id: String = ""
        var enable: Bool = true
        var title: String = ""
        var subtitle: String = ""
        var icon: String = ""
        var data: Array = [Scenic]()
        struct Scenic {
            var action: String = ""
            var text: String = ""
            var param: Dictionary = [String: JSON]()
            var image: String = ""
            init(json: JSON?) {
                if let json = json {
                    action = json["action"].stringValue
                    text = json["text"].stringValue
                    param = json["param"].dictionaryValue
                    image = json["image"].stringValue
                } else {
                    return
                }
            }
        }
        
        
        init(json: JSON?) {
            if let json = json {
                id = json["id"].stringValue
                enable = json["enable"].boolValue
                title = json["title"].stringValue
                subtitle = json["subtitle"].stringValue
                icon = json["icon"].stringValue
                
                let dataArr = json["data"].arrayValue
                for dic in dataArr {
                    let them = Scenic.init(json: dic)
                    data.append(them)
                }
            }
        }
    }
    
    ///////// 当季热推 /////////
    struct Seasons {
        var id: String = ""
        var enable: Bool = true
        var title: String = ""
        var subtitle: String = ""
        var icon: String = ""
        var description: String = ""
        var image: String = ""
        var action: String = ""
        var text: String = ""
        var param: Dictionary = [String: JSON]()
        var data: Array = [RecommendTour]()
        
        init(json: JSON?) {
            if let json = json {
                id = json["id"].stringValue
                enable = json["enable"].boolValue
                title = json["title"].stringValue
                subtitle = json["subtitle"].stringValue
                icon = json["icon"].stringValue
                description = json["description"].stringValue
                image = json["image"].stringValue
                action = json["action"].stringValue
                text = json["text"].stringValue
                param = json["param"].dictionaryValue
                
                let dataArr = json["data"].arrayValue
                for dic in dataArr {
                    let tour = RecommendTour.init(json: dic)
                    data.append(tour)
                }
            }
        }
    }
    
    ///////// 舒适小团 /////////
    struct MiniTours {
        var id: String = ""
        var enable: Bool = true
        var title: String = ""
        var subtitle: String = ""
        var icon: String = ""
        var data: Array = [RecommendTour]()
        
        init(json: JSON?) {
            if let json = json {
                id = json["id"].stringValue
                enable = json["enable"].boolValue
                title = json["title"].stringValue
                subtitle = json["subtitle"].stringValue
                icon = json["icon"].stringValue
                
                let dataArr = json["data"].arrayValue
                for dic in dataArr {
                    let tour = RecommendTour.init(json: dic)
                    data.append(tour)
                }
            }
        }
    }
    
    ///////// 爆款热销 /////////
    struct Hots {
        var id: String = ""
        var enable: Bool = true
        var title: String = ""
        var subtitle: String = ""
        var icon: String = ""
        var data: Array = [RecommendTour]()
        
        init(json: JSON?) {
            if let json = json {
                id = json["id"].stringValue
                enable = json["enable"].boolValue
                title = json["title"].stringValue
                subtitle = json["subtitle"].stringValue
                icon = json["icon"].stringValue
            }
        }

    }
    
    ///////// 共通 团模型 /////////
    struct RecommendTour {
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
        init(json: JSON?) {
            if let json = json {
                id = json["tour_id"].intValue
                mainPic = json["tour_main_picture"].stringValue
                departure = json["tour_departure_en_cn"].stringValue
                displayPrice = json["tour_display_price"].doubleValue
                isActivity = json["tour_activity"].boolValue
                title = json["tour_title"].stringValue
                titleApp = json["tour_title_app"].stringValue
                discountPercentNow = json["tour_discount_percent_now"].intValue
                isDiscountNow = json["is_discount_now"].boolValue
                discountEnd = json["tour_discount_end"].stringValue
                currentPrice = json["current_price"].intValue
                url = json[""].stringValue
            } else {
                return
            }
            
        }
    }
}


class WNRecommendAPI: WNHttpClient {
    
    class func fetch(success: ((WNRecommendModel) -> Void)?) -> Void {
        let param = ["ver" : ""]
        
        self.post(subURL: WNConfig.Path.recommend, param: param, handle: { (data) -> JSON? in
            if !(data is JSON) {
                return nil
            }
            return data as? JSON
        }, success: { (data) in
            let model = WNRecommendModel.init(response: data)
            if let success = success {
                success(model)
            }
        }, fail: { (error) in
            
        }) { () in
            
        }
        
    }
}
