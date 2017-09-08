//
//  WNTourModel.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/2.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WNToursModel {
    
    var dataArr: Array<WNTourModel> = []
    var title = "列表"
    var found: Int = 0
    var facetExtend: WNTourFacetExtend?
    var facetDetail: WNTourFacetDetail?
    
    init(json: String) {
        let json = JSON.parse(json)
        if let data = json["data"].array {
            for json in data {
                self.dataArr.append(WNTourModel.init(json: json))
            }
        }
        self.title = json["title"].stringValue
        self.found = json["found"].intValue
        self.facetExtend = WNTourFacetExtend.init(json: json["facetExtend"])
        self.facetDetail = WNTourFacetDetail.init(json: json["facetDetails"])
    }
    
}

struct WNTourModel {
    
    var id: Int = 0
    var title: String = ""
    var siblings: String = ""
    var discount: Array<JSON> = []
    var scenic: Array<JSON> = []
    var departure: Array<String> = []
    var mainPicture: String = ""
    var sliderPicture: Array<String> = []
    var isSaleNow: Bool = false
    var isDiscountNow = false
    var currentPrice: Int
    var discountPercent: Int
    var week: Array<JSON> = []
    
    init(json: JSON) {
        
        self.id = json["tour_id"].intValue
        self.title = json["tour_title"].stringValue
        self.siblings = json["tour_siblings"].stringValue
        self.discount = json["discount"].arrayValue
        self.scenic = json["scenic"].arrayValue
        self.departure = (json["tour_departure_en_cn"].stringValue).components(separatedBy: "|")
        self.mainPicture = json["tour_main_picture"].stringValue
        self.sliderPicture = (json["tour_slider_pictures"].stringValue).components(separatedBy: ";")
        self.isSaleNow = json["is_sale_now"].boolValue
        self.isDiscountNow = json["is_discount_now"].boolValue
        self.currentPrice = json["current_price"].intValue
        self.discountPercent = json["tour_discount_percent"].intValue
        self.week = json["week"].arrayValue
    }
    
    static func convert(week: Array<JSON>) -> String {
        var str = ""
        var weeks: Array<String>  = []
        for json in week {
            weeks.append(json.stringValue)
        }
        if weeks.count == 7 {
            return "每天发团"
        }
        
        var a: Array<String> = []
        if weeks.contains("monday") { a.append("一") }
        if weeks.contains("tuesday") { a.append("二") }
        if weeks.contains("wednesday") { a.append("三") }
        if weeks.contains("thursday") { a.append("四") }
        if weeks.contains("friday") { a.append("五") }
        if weeks.contains("saturday") { a.append("六") }
        if weeks.contains("sunday") { a.append("日") }
        str = String.init(format: "每周%@发团", a.joined(separator: "、"))
        return str
    }
}

struct WNTourFacetExtend {
    
    var scenic: Dictionary<String, Int>?
    var departure: Dictionary<String, Int>?
    var leave: Dictionary<String, Int>?
    var service: Dictionary<String, Int>?
    var week: Dictionary<String, Int>?
    var discount: Dictionary<String, Int>?
    var tag: Dictionary<String, Int>?
    
    init?(json: JSON?) {
        
        guard let _json = json else { return nil }
        
        if _json["scenic"].dictionaryObject is Dictionary<String, Int> {
            self.scenic = _json["scenic"].dictionaryObject as? Dictionary<String, Int>
        }
        if _json["tour_departure_en_cn"].dictionaryObject is Dictionary<String, Int> {
            self.departure = _json["tour_departure_en_cn"].dictionaryObject as? Dictionary<String, Int>
        }
        if _json["tour_leave_single_en_cn"].dictionaryObject is Dictionary<String, Int> {
            self.leave = _json["tour_leave_single_en_cn"].dictionaryObject as? Dictionary<String, Int>
        }
        if _json["service"].dictionaryObject is Dictionary<String, Int> {
            self.service = _json["service"].dictionaryObject as? Dictionary<String, Int>
        }
        if _json["week"].dictionaryObject is Dictionary<String, Int> {
            self.week = _json["week"].dictionaryObject as? Dictionary<String, Int>
        }
        if _json["discount"].dictionaryObject is Dictionary<String, Int> {
            self.discount = _json["discount"].dictionaryObject as? Dictionary<String, Int>
        }
        if _json["tag"].dictionaryObject is Dictionary<String, Int> {
            self.tag = _json["tag"].dictionaryObject as? Dictionary<String, Int>
        }
    }
}

struct WNTourFacetDetail {
    
    var tags: Array<WNTourTag> = []
    
    init?(json: JSON?) {
        guard let _json = json else { return nil }
        for a in _json["tag"].arrayValue {
            tags.append(WNTourTag.init(json: a))
        }
    }
    
    struct WNTourTag {
        var anchor = ""
        var area = ""
        var recommend = 0
        var type = 0
        var tag = ""
        
        init(json: JSON) {
            anchor = json["anchor"].stringValue
            area = json["area"].stringValue
            recommend = json["recommend"].intValue
            type = json["type"].intValue
            tag = json["tag"].stringValue
        }
    }
}

