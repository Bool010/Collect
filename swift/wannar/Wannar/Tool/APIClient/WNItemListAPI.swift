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
                          success: (() -> Void)? = nil,
                          fail: (()-> Void)? = nil,
                          finish:(()-> Void)? = nil) -> Void {
        let fields = "tour_id,tour_departure,tour_leave,tour_display_price,current_price,tour_code,tour_sale_start,tour_sale_end,tour_discount_start,tour_discount_end,tour_display_price,tour_teaser,tour_travel_together_post,tour_recommand,tour_discount_percent,tour_title_app,tour_tag1,tour_tag2,tour_tag3,tour_buy2get1,tour_buy2get2,tour_airport,tour_pickup,tour_hotel,tour_share,tour_extradiscount,tour_getpoints,tour_usepoints,tour_vipdiscount,tour_double_confirm,tour_cancelable,tour_updatable,tour_birthday,tour_passport,tour_slider_pictures,tour_monday,tour_tuesday,tour_wednesday,tour_thursday,tour_friday,tour_saturday,tour_sunday,tour_transportation,tour_day,tour_main_picture,tour_url,tour_discount_percent_now,activity_tags,tour_rating,tour_reviews,tag,tour_base_price_info,tour_special_promotion,is_discount_now,is_sale_now,tour_activity"
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
        self.post(subURL: WNConfig.Path.itemList, param: param, handle: { (data) -> JSON? in
            
            if !(data is JSON) {
                return nil
            }
            return data as? JSON
        }, success: { (json) in
            
            if let success = success {
                success()
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
