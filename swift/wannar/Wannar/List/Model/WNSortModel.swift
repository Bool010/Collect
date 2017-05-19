//
//  WNItemListSortModel.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/2.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation

public struct WNSortRowModel {
    
    var title = ""
    var image = ""
    var param = ""
    var isSelected = false

    init(title: String, image: String, param: String, isSelected: Bool = false) {
        self.title = title
        self.image = image
        self.param = param
        self.isSelected = isSelected
    }
}



struct WNSortModel {
    
    var data: Array<WNSortRowModel> = []
    
    init(type: String) {
        let lowercased = type.lowercased()
        switch lowercased {
        case "scenic":
            self.data = WNSortScenic.data
        case "yelp":
            self.data = WNSortYelp.data
        case "activity":
            self.data = WNSortActivity.data
        case "tour":
            self.data = WNSortTour.data
        case "onedaytour":
            self.data = WNSortOnedayTour.data
        default:
            wn_debugMessage("未处理状况")
        }
    }
    
    func getSortParam() -> String {
        
        for rowModel in self.data {
            if rowModel.isSelected {
                return rowModel.param
            }
        }
        return ""
    }
    
    mutating func selected(index: Int) -> Void {
        
        for i in 0 ..< self.data.count {
            self.data[i].isSelected = false
        }
        self.data[index].isSelected = true
    }
}



struct WNSortScenic {
    
    private static let hot =
        WNSortRowModel.init(title: "热度从高到低".ItemList,
                            image: WNSortConfig.Hot.image,
                            param: "col_scenery_recommand,desc;col_scenery_id,asc",
                            isSelected: true)
    
    private static let distance =
        WNSortRowModel.init(title: WNSortConfig.Distance.title,
                            image: WNSortConfig.Distance.image,
                            param: "geodist(),asc;col_scenery_id,asc")
    
    public static var data: Array<WNSortRowModel> = [hot, distance]
}



struct WNSortYelp {
    
    private static let hot =
        WNSortRowModel.init(title: "热度从高到低".ItemList,
                            image: WNSortConfig.Hot.image,
                            param: "review_count,desc;geodist(),asc;id,asc",
                            isSelected: true)
    
    private static let distance =
        WNSortRowModel.init(title: WNSortConfig.Distance.title,
                            image: WNSortConfig.Distance.image,
                            param: "geodist(),asc;review_count,desc;id,asc")
    
    private static let priceAsc =
        WNSortRowModel.init(title: WNSortConfig.PriceAsc.title,
                            image: WNSortConfig.PriceAsc.image,
                            param: "price,asc;geodist(),asc;review_count,desc;id,asc")
    
    private static let priceDesc =
        WNSortRowModel.init(title: WNSortConfig.PriceDesc.title,
                            image: WNSortConfig.PriceDesc.image,
                            param: "price,desc;geodist(),asc;review_count,desc;id,asc")
    
    private static let evaluate =
        WNSortRowModel.init(title: WNSortConfig.Evaluate.title,
                            image: WNSortConfig.Evaluate.image,
                            param: "rating,desc;geodist(),asc;review_count,desc;id,asc")
    
    public static var data: Array<WNSortRowModel> = [hot, distance]
}



struct WNSortActivity {
    
    private static let hot =
        WNSortRowModel.init(title: WNSortConfig.Hot.title,
                            image: WNSortConfig.Hot.image,
                            param: WNSortConfig.Hot.param,
                            isSelected: true)
    private static let priceAsc =
        WNSortRowModel.init(title: WNSortConfig.PriceAsc.title,
                            image: WNSortConfig.PriceAsc.image,
                            param: WNSortConfig.PriceAsc.param)
    private static let priceDesc =
        WNSortRowModel.init(title: WNSortConfig.PriceDesc.title,
                            image: WNSortConfig.PriceDesc.image,
                            param: WNSortConfig.PriceDesc.param)
    private static let evaluate =
        WNSortRowModel.init(title: WNSortConfig.Evaluate.title,
                            image: WNSortConfig.Evaluate.image,
                            param: WNSortConfig.Evaluate.param)
    
    public static var data: Array<WNSortRowModel> = [hot, priceAsc, priceDesc, evaluate]
}



struct WNSortOnedayTour {
    
    private static let hot =
        WNSortRowModel.init(title: WNSortConfig.Hot.title,
                            image: WNSortConfig.Hot.image,
                            param: WNSortConfig.Hot.param,
                            isSelected: true)
    private static let priceAsc =
        WNSortRowModel.init(title: WNSortConfig.PriceAsc.title,
                            image: WNSortConfig.PriceAsc.image,
                            param: WNSortConfig.PriceAsc.param)
    private static let priceDesc =
        WNSortRowModel.init(title: WNSortConfig.PriceDesc.title,
                            image: WNSortConfig.PriceDesc.image,
                            param: WNSortConfig.PriceDesc.param)
    
    public static var data: Array<WNSortRowModel> = [hot, priceAsc, priceDesc]
}



struct WNSortTour {
    
    private static let hot =
        WNSortRowModel.init(title: WNSortConfig.Hot.title,
                            image: WNSortConfig.Hot.image,
                            param: WNSortConfig.Hot.param,
                            isSelected: true)
    private static let priceAsc =
        WNSortRowModel.init(title: WNSortConfig.PriceAsc.title,
                            image: WNSortConfig.PriceAsc.image,
                            param: WNSortConfig.PriceAsc.param)
    private static let priceDesc =
        WNSortRowModel.init(title: WNSortConfig.PriceDesc.title,
                            image: WNSortConfig.PriceDesc.image,
                            param: WNSortConfig.PriceDesc.param)
    private static let dayAsc =
        WNSortRowModel.init(title: WNSortConfig.DayAsc.title,
                            image: WNSortConfig.DayAsc.image,
                            param: WNSortConfig.DayAsc.param)
    private static let dayDesc =
        WNSortRowModel.init(title: WNSortConfig.DayDesc.title,
                            image: WNSortConfig.DayDesc.image,
                            param: WNSortConfig.DayDesc.param)
    
    public static var data: Array<WNSortRowModel> = [hot, priceAsc, priceDesc, dayAsc, dayDesc]
}



struct WNSortConfig {
    
    struct Hot {
        static let title = "玩哪儿推荐".ItemList
        static let image = "WN_sort_hot"
        static let param = "recommand,desc"
    }
    
    struct PriceAsc {
        static let title = "价格从低到高".ItemList
        static let image = "WN_sort_price_asc"
        static let param = "display_price,asc"
    }
    
    struct PriceDesc {
        static let title = "价格从高到低".ItemList
        static let image = "WN_sort_price_desc"
        static let param = "display_price,desc"
    }
    
    struct DayAsc {
        static let title = "天数从低到高".ItemList
        static let image = "WN_sort_day_asc"
        static let param = "day,asc"
    }
    
    struct DayDesc {
        static let title = "天数从高到低".ItemList
        static let image = "WN_sort_day_desc"
        static let param = "day,desc"
    }
    
    struct Distance {
        static let title = "距离从近到远".ItemList
        static let image = "WN_sort_distance"
        static let param = "distance,asc"
    }
    
    struct Evaluate {
        static let title = "评价".ItemList
        static let image = "WN_sort_evaluate"
        static let param = "rating,desc"
    }
}
