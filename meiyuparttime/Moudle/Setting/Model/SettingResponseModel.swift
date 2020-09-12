//
//  SettingResponseModel.swift
//  beeparttime
//
//  Created by Senyas on 2020/8/1.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources

struct SettingListSection {
    var items: [Item]
}

extension SettingListSection: SectionModelType {
    
    typealias Item = SettingItemInfoModel

    init(original: SettingListSection, items: [SettingListSection.Item]) {
        self = original
        self.items = items
    }
}

/// 设置数据模型
struct SettingItemInfoModel: Mappable {
    
    var type: SettingType?
    var is_refresh: Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        type                <- map["type"]
        is_refresh          <- map["is_refresh"]
    }

}

