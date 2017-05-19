//
//  WNCityModel.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/16.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation
import CoreLocation

struct WNCityModel {
    
    var area = ""
    var departureFlg = false
    var hbhDestinationCode = ""
    var image = ""
    var imageS = ""
    var nameCN = ""
    var nameEN = ""
    var position: CLLocation?
    var scenicID = 0
    var sort = 0
    var pinyin = ""
    var initialPinyin = ""

    init(dictionary: Dictionary<String, Any>) {
        if dictionary.keys.contains("area") {
            area = dictionary["area"] as! String
        }
        if dictionary.keys.contains("departure_flg") {
            departureFlg = dictionary["departure_flg"] as! Bool
        }
        if dictionary.keys.contains("hbh_destination_code") {
            hbhDestinationCode = dictionary["hbh_destination_code"] as! String
        }
        if dictionary.keys.contains("image") {
            image = dictionary["image"] as! String
        }
        if dictionary.keys.contains("image_s") {
            imageS = dictionary["image_s"] as! String
        }
        if dictionary.keys.contains("name_cn") {
            nameCN = dictionary["name_cn"] as! String
            pinyin = nameCN.pinyin
            var initialStr = ""
            let x = pinyin.components(separatedBy: " ")
            for i in x {
                if let initial = i[0] {
                    initialStr = initialStr + initial
                }
            }
            initialPinyin = initialStr
        }
        if dictionary.keys.contains("name_en") {
            nameEN = dictionary["name_en"] as! String
        }
        if dictionary.keys.contains("position") {
            let p = dictionary["position"]
            if p is String {
                let a = (p as! String).components(separatedBy: ",")
                if a.count == 2 {
                    position = CLLocation.init(latitude: (a.first?.double)!, longitude: (a.last?.double)!)
                }
            }
        }
        if dictionary.keys.contains("scenic_id") {
            scenicID = dictionary["scenic_id"] as! Int
        }
        if dictionary.keys.contains("sort") {
            sort = dictionary["sort"] as! Int
        }
    }
}

struct WNCityGroupModel {
    
    var all: Array<WNCityModel> = []
    var usa: Array<WNCityModel> = []
    var europe: Array<WNCityModel> = []
    var canada: Array<WNCityModel> = []
    var southAmerica: Array<WNCityModel> = []
    var group: Array<WNCityAreaModel> = []
    
    init() {
        
    }
    
    init(array: Array<Dictionary<String, Any>>) {
    
        var array = array
        array = array.sorted { (dic1, dic2) -> Bool in
            return (dic1["sort"] as! Int) < (dic2["sort"] as! Int)
        }
        
        for dic in array {
            let model = WNCityModel.init(dictionary: dic)
            if model.area == "usa"           { usa.append(model) }
            if model.area == "europe"        { europe.append(model) }
            if model.area == "canada"        { canada.append(model) }
            if model.area == "south-america" { southAmerica.append(model) }
            all.append(model)
        }
        
        var areaModel = WNCityAreaModel.init()
        areaModel.area = "美国"
        areaModel.data = usa
        
        
        group = [WNCityAreaModel.init("美国", usa),
                 WNCityAreaModel.init("欧洲", europe),
                 WNCityAreaModel.init("加拿大", canada),
                 WNCityAreaModel.init("南美", southAmerica)]
    }
}

struct WNCityAreaModel {
    var area = ""
    var data: Array<WNCityModel> = []
    
    static func `init`(_ area: String, _ data: Array<WNCityModel>) -> WNCityAreaModel {
        var model = WNCityAreaModel.init()
        model.area = area
        model.data = data
        return model
    }
}
