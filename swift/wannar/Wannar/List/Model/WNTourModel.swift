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
    
    init(array: Array<JSON>) {
        for json in array {
            dataArr.append(WNTourModel.init(json: json))
        }
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
}
