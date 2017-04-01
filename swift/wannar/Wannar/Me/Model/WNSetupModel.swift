//
//  WNSetupModel.swift
//  Wannar
//
//  Created by 付国良 on 2016/11/24.
//  Copyright © 2016年 玩哪儿. All rights reserved.
//

import UIKit

class WNSetupRowModel: NSObject {
    
    var title: String = ""
    var subtitle: String = ""

    override init () {
        super.init()
    }
    
    convenience init(title: String, subtitle: String) {
        self.init()
        self.title = title;
        self.subtitle = subtitle;
    }
}


class WNSetupModel: NSObject {
    
    var model: Array <Array <WNSetupRowModel>> = []
    
    override init() {
        
        super.init()
        self.model = [
            [
                WNSetupRowModel.init(title: "账号管理", subtitle: ""),
                WNSetupRowModel.init(title: "账号安全", subtitle: "")
            ],
            [
                WNSetupRowModel.init(title: "距离显示", subtitle: ""),
                WNSetupRowModel.init(title: "繁简转换", subtitle: "")
            ],
            [
                WNSetupRowModel.init(title: "喜欢？来个好评吧！", subtitle: ""),
                WNSetupRowModel.init(title: "好东西就要分享", subtitle: ""),
                WNSetupRowModel.init(title: "期待您的反馈", subtitle: ""),
                WNSetupRowModel.init(title: "版本信息", subtitle: "")
            ],
            [
                WNSetupRowModel.init(title: "清除缓存", subtitle: "")
            ]
        ]
    }
}
