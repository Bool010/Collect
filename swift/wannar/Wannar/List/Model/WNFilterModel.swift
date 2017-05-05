//
//  WNFilterModel.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/3.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation

struct WNFilterItemModel {
    var title = ""
    var value = ""
    var isSelected = false
}

struct WNFilterModel {
    
    var inceptionQuery = ""
    var query = ""
    var keyArr: Array<WNFilterItemModel> = []
    var valueArr: Array<Array<WNFilterItemModel>> = []
    
    struct InceptionQuery {
        static let tour = "tour_published:true;tour_activity:false;tour_day:2-*"
        static let onedayTour = "tour_published:true;tour_activity:false;tour_day:1"
        static let activity = "tour_published:true;tour_activity:true;tour_transportation:false"
        static let transportation = "tour_published:true;tour_activity:true;tour_transportation:true"
        static let scenic = ""
        static let yelp = ""
    }
    
    static func `init`(facetExtend: WNTourFacetExtend, facetDetail: WNTourFacetDetail) -> WNFilterModel {
        /// Tag
//        let tagDic: Dictionary<String, Array<WNFilterItemModel>> = [:]
//        if let tag = facetExtend.tag {
//            var array: Array<WNFilterItemModel> = []
//            for key in tag.keys {
//                var model = WNFilterItemModel.init()
//                model.title =
//            }
//        }
        var filterModel = WNFilterModel.init()
        
        /// Scenic
        if let scenic = facetExtend.scenic {
            var array: Array<WNFilterItemModel> = []
            for key in scenic.keys {
                if !key.isEmpty {
                    var model = WNFilterItemModel.init()
                    model.title = key
                    model.value = key
                    model.isSelected = false
                    array.append(model)
                }
            }
            
            var model = WNFilterItemModel.init()
            model.title = "途径景点"
            model.value = "scenic"
            model.isSelected = false
            filterModel.keyArr.append(model)
            filterModel.valueArr.append(array)
        }
        
        
        /// Departure
        if let departure = facetExtend.departure {
            var array: Array<WNFilterItemModel> = []
            for key in departure.keys {
                if !key.isEmpty && !(key == "|") {
                    let a = key.components(separatedBy: "|")
                    guard a.count == 2 else {
                        continue
                    }
                    var model = WNFilterItemModel.init()
                    model.title = a[1]
                    model.value = a[0]
                    model.isSelected = false
                    array.append(model)
                }
            }
            
            var model = WNFilterItemModel.init()
            model.title = "出发城市"
            model.value = "tour_departure_en_cn"
            model.isSelected = false
            filterModel.keyArr.append(model)
            filterModel.valueArr.append(array)
        }
        
        /// Leave
        if let leave = facetExtend.leave {
            var array: Array<WNFilterItemModel> = []
            for key in leave.keys {
                if !key.isEmpty && !(key == "|") {
                    let a = key.components(separatedBy: "|")
                    guard a.count == 2 else {
                        continue
                    }
                    var model = WNFilterItemModel.init()
                    model.title = a[1]
                    model.value = a[0]
                    model.isSelected = false
                    array.append(model)
                }
            }
            
            var model = WNFilterItemModel.init()
            model.title = "结束城市"
            model.value = "tour_leave_single_en_cn"
            model.isSelected = false
            filterModel.keyArr.append(model)
            filterModel.valueArr.append(array)
        }

        /// Service
        if let service = facetExtend.service {
            var array: Array<WNFilterItemModel> = []
            for key in service.keys {
                if !key.isEmpty {
                    var model = WNFilterItemModel.init()
                    if key == "pickup"  { model.title = "本地出发" }
                    if key == "airport" { model.title = "接机参团" }
                    if key == "hotel"   { model.title = "加订酒店" }
                    if key == "share"   { model.title = "配房服务" }
                    model.value = key
                    model.isSelected = false
                    array.append(model)
                }
            }
            
            var model = WNFilterItemModel.init()
            model.title = "服务"
            model.value = "service"
            model.isSelected = false
            filterModel.keyArr.append(model)
            filterModel.valueArr.append(array)
        }
        
        /// Week
        if let week = facetExtend.week {
            var array: Array<WNFilterItemModel> = []
            var sortArr = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
            var titleArr = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"]
            for i in 0 ..< sortArr.count {
                if week.keys.contains(sortArr[i]) {
                    var model = WNFilterItemModel.init()
                    model.title = titleArr[i]
                    model.value = sortArr[i]
                    model.isSelected = false
                    array.append(model)
                }
            }
            
            var model = WNFilterItemModel.init()
            model.title = "发团日期"
            model.value = "week"
            model.isSelected = false
            filterModel.keyArr.append(model)
            filterModel.valueArr.append(array)
        }
        
        /// Discount
        if let discount = facetExtend.discount {
            var array: Array<WNFilterItemModel> = []
            var sortArr = ["buy2get1", "buy2get2", "extradiscount", "getpoints", "usepoints", "vipdiscount", "tag3"]
            var titleArr = ["买二送一", "买二送二", "满额返点", "积分返点", "积分兑换", "VIP特价", "App折扣"]
            for i in 0 ..< sortArr.count {
                if discount.keys.contains(sortArr[i]) {
                    var model = WNFilterItemModel.init()
                    model.title = titleArr[i]
                    model.value = sortArr[i]
                    model.isSelected = false
                    array.append(model)
                }
            }
            
            var model = WNFilterItemModel.init()
            model.title = "优惠"
            model.value = "discount"
            model.isSelected = false
            filterModel.keyArr.append(model)
            filterModel.valueArr.append(array)
        }
        return filterModel
    }
}
