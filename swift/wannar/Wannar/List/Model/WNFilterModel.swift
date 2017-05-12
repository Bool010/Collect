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
    var cityArr: Array<Array<WNFilterItemModel>> = []
    
    struct InceptionQuery {
        static let tour = "tour_published:true;tour_activity:false;tour_day:2-*"
        static let onedayTour = "tour_published:true;tour_activity:false;tour_day:1"
        static let activity = "tour_published:true;tour_activity:true;tour_transportation:false"
        static let transportation = "tour_published:true;tour_activity:true;tour_transportation:true"
        static let scenic = ""
        static let yelp = ""
    }
    
    static func `init`(facetExtend: WNTourFacetExtend,
                       facetDetail: WNTourFacetDetail,
                       query: String = "",
                       inceptionQuery: String = "") -> WNFilterModel {
        
        let queryDic = toQueryDic(query: query)
        let inceptionQueryDic = toQueryDic(query: inceptionQuery)
        
        var filterModel = WNFilterModel.init()
        
        // MARK: Tag
        let tagKey = "tag"
        if !inceptionQueryDic.keys.contains(tagKey) {
            
            if let tag = facetExtend.tag {
                // Get Detail
                var tagsArr: Array<WNTourFacetDetail.WNTourTag> = []
                let keys = tag.keys
                for a in facetDetail.tags {
                    if keys.contains(a.tag) {
                        tagsArr.append(a)
                    }
                }
                
                // Group
                var recommend: Array<WNTourFacetDetail.WNTourTag> = []
                var type0: Array<WNTourFacetDetail.WNTourTag> = []
                var other: Array<WNTourFacetDetail.WNTourTag> = []
                for a in tagsArr {
                    if a.recommend == 4 {
                        recommend.append(a)
                    } else {
                        if a.type == 0 {
                            type0.append(a)
                        } else {
                            other.append(a)
                        }
                    }
                }
                var total: Array<WNTourFacetDetail.WNTourTag> = []
                total = recommend + type0 + other
                
                // Init Model
                var array: Array<WNFilterItemModel> = []
                for x in total {
                    var model = WNFilterItemModel.init()
                    model.title = x.anchor
                    model.isSelected = isShouldSelected(queryDic: queryDic, key: tagKey, value: x.tag)
                    model.value = x.tag
                    array.append(model)
                }
                
                var model = WNFilterItemModel.init()
                model.title = "主题玩法"
                model.value = tagKey
                model.isSelected = false
                filterModel.keyArr.append(model)
                filterModel.valueArr.append(array)
            }
        }
        
        // MARK: Scenic
        let scenicKey = "scenic"
        if !inceptionQueryDic.keys.contains(scenicKey) {
            if let scenic = facetExtend.scenic {
                var array: Array<WNFilterItemModel> = []
                for key in scenic.keys {
                    if !key.isEmpty {
                        var model = WNFilterItemModel.init()
                        model.title = key
                        model.value = key
                        model.isSelected = isShouldSelected(queryDic: queryDic,
                                                            key: scenicKey,
                                                            value: key)
                        array.append(model)
                    }
                }
                
                var model = WNFilterItemModel.init()
                model.title = "途径景点"
                model.value = scenicKey
                model.isSelected = false
                filterModel.keyArr.append(model)
                filterModel.valueArr.append(array)
            }
        }
        
        // MARK: Departure City
        let departureKey = "tour_departure_en"
        if !inceptionQueryDic.keys.contains(departureKey) {
            
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
                        model.isSelected = isShouldSelected(queryDic: queryDic,
                                                            key: departureKey,
                                                            value: a[0])
                        array.append(model)
                    }
                }
                filterModel.cityArr.append(array)
            }
        }

        /**
        let departureKey = "tour_departure_en"
        if !inceptionQueryDic.keys.contains(departureKey) {
            
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
                        model.isSelected = isShouldSelected(queryDic: queryDic,
                                                            key: departureKey,
                                                            value: a[0])
                        array.append(model)
                    }
                }
                
                var model = WNFilterItemModel.init()
                model.title = "出发城市"
                model.value = departureKey
                model.isSelected = false
                filterModel.keyArr.append(model)
                filterModel.valueArr.append(array)
            }
        }
         */
        
        // MARK: Leave
        let leaveKey = "tour_leave_single_en"
        if !inceptionQueryDic.keys.contains(leaveKey) {
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
                        model.isSelected = isShouldSelected(queryDic: queryDic,
                                                            key: leaveKey,
                                                            value: a[0])
                        array.append(model)
                    }
                }
                
                var model = WNFilterItemModel.init()
                model.title = "结束城市"
                model.value = leaveKey
                model.isSelected = false
                filterModel.keyArr.append(model)
                filterModel.valueArr.append(array)
            }
        }

        // MARK: Service
        let serviceKey = "service"
        if !inceptionQueryDic.keys.contains(serviceKey) {
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
                        model.isSelected = isShouldSelected(queryDic: queryDic,
                                                            key: serviceKey,
                                                            value: key)
                        array.append(model)
                    }
                }
                
                var model = WNFilterItemModel.init()
                model.title = "服务"
                model.value = serviceKey
                model.isSelected = false
                filterModel.keyArr.append(model)
                filterModel.valueArr.append(array)
            }
        }
        
        // MARK: Week
        let weekKey = "week"
        if !inceptionQueryDic.keys.contains(weekKey) {
            if let week = facetExtend.week {
                var array: Array<WNFilterItemModel> = []
                var sortArr = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
                var titleArr = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"]
                for i in 0 ..< sortArr.count {
                    if week.keys.contains(sortArr[i]) {
                        var model = WNFilterItemModel.init()
                        model.title = titleArr[i]
                        model.value = sortArr[i]
                        model.isSelected = isShouldSelected(queryDic: queryDic,
                                                            key: weekKey,
                                                            value: sortArr[i])
                        array.append(model)
                    }
                }
                
                var model = WNFilterItemModel.init()
                model.title = "发团日期"
                model.value = weekKey
                model.isSelected = false
                filterModel.keyArr.append(model)
                filterModel.valueArr.append(array)
            }
        }
        
        // MARK: Discount
        let discountKey = "discount"
        if !inceptionQueryDic.keys.contains(discountKey) {
            if let discount = facetExtend.discount {
                var array: Array<WNFilterItemModel> = []
                var sortArr = ["buy2get1", "buy2get2", "extradiscount", "getpoints", "usepoints", "vipdiscount", "tag3"]
                var titleArr = ["买二送一", "买二送二", "满额返点", "积分返点", "积分兑换", "VIP特价", "App折扣"]
                for i in 0 ..< sortArr.count {
                    if discount.keys.contains(sortArr[i]) {
                        var model = WNFilterItemModel.init()
                        model.title = titleArr[i]
                        model.value = sortArr[i]
                        model.isSelected = isShouldSelected(queryDic: queryDic,
                                                            key: discountKey,
                                                            value: sortArr[i])
                        array.append(model)
                    }
                }
                
                var model = WNFilterItemModel.init()
                model.title = "优惠"
                model.value = discountKey
                model.isSelected = false
                filterModel.keyArr.append(model)
                filterModel.valueArr.append(array)
            }
        }
        return filterModel
    }
}

extension WNFilterModel {
    
    func queryString() -> String {
        
        var x: Array<String> = []
        for i in 0 ..< valueArr.count {
            
            // Key
            let key = keyArr[i].value
            
            // Value
            let valueArray = self.valueArr[i]
            var arr: Array<String> = []
            for model in valueArray {
                if model.isSelected {
                    arr.append(model.value)
                }
            }
            if arr.count > 0 {
                x.append("\(key):\(arr.joined(separator: ","))")
            }
        }
        return x.joined(separator: ";") + self.query
    }
    
    static func toQueryDic(query: String) -> Dictionary<String, Array<String>> {
        
        var dic: Dictionary<String, Array<String>> = [:]
        let x = query.components(separatedBy: ";")
        for a in x {
            let b = a.components(separatedBy: ":")
            let aKey = b.first
            let aValue = b.last?.components(separatedBy: ",")
            if (aKey != nil) && (aValue != nil) {
                dic[aKey!] = aValue
            }
        }
        return dic
    }
    
    static func isShouldSelected(queryDic: Dictionary<String, Array<String>>, key: String, value: String) -> Bool {
        
        let array = queryDic[key]
        if let array = array {
            return array.contains(value)
        } else {
            return false
        }
    }
}
