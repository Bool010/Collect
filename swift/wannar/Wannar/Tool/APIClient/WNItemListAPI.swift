//
//  WNItemListAPI.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/28.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit
import SwiftyJSON

class WNItemListAPI: WNHttpClient {
    
    class func selectTour(query: String?,
                          sort: String?,
                          offset: Int = 0,
                          isNeedTitle: Bool = true,
                          isCountOnly: Bool = false,
                          distance: Double? = nil,
                          success: ((WNToursModel?) -> Void)? = nil,
                          fail: (()-> Void)? = nil,
                          finish:(()-> Void)? = nil) -> Void {
        
        let fields = "tour_id,tour_title,tour_siblings,discount,scenic,tour_departure_en_cn,tour_main_picture,tour_slider_pictures,is_sale_now,is_discount_now,current_price,tour_discount_percent,week"
        let facets = "tour_departure_en_cn,tour_leave_single_en_cn,scenic,tag,tour_day,week,discount,service,area"
        let facetsExtend = "tag:tag;tour_departure_en_cn:tour_departure_en;tour_leave_single_en_cn:tour_leave_single_en;scenic:scenic;discount:discount;service:service;week:week"
        let escapes = "tag,tour_departure_en_cn,tour_leave_single_en_cn,scenic,discount,service,week"
        
        var param: [String: Any] = ["solr": "tour"]
        if !isCountOnly {
            param["fields"] = fields
            param["facets"] = facets
            param["facetsExtend"] = facetsExtend
            param["escapes"] = escapes
            param["limit"] = 50
            param["facetLimit"] = 2000
        }
        if let query = query {
            param["query"] = query
        }
        if let sort = sort {
            param["sort"] = sort
        }
        if let distance = distance {
            param["max"] = distance
        }
        param["needTitle"] = isNeedTitle ? 1 : 0
        param["offset"] = offset
        
        /// Post
        self.post(subURL: WNConfig.Path.itemList, param: param, success: { (json) in
            if let success = success {
                var model: WNToursModel?
                model = WNToursModel.init(json: json)
                success(model)
            }
        }, fail: { (error) in
            
            if let fail = fail {
                fail()
            }
        }) {
            if let finish = finish {
                finish()
            }
        }

    }
}
