//
//  JobTypeResponseModel.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/26.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation
import LKDBHelper
import ObjectMapper
import RxDataSources

/// 获取工作类型分类
struct JobTypeResponseModel: Mappable {
    var code: Int?
    var success: Bool?
    var msg: String?
    var data: [JobTypeInfoModel]?

    init?(map _: Map) {}

    mutating func mapping(map: Map) {
        code <- map["code"]
        success <- map["success"]
        msg <- map["msg"]
        data <- map["data"]
    }
}

/// 具体工作类型
struct JobTypeInfoModel: Mappable {
    var workId: Int?
    var workName: String?
    var workStatus: Int?

    init?(map _: Map) {}

    mutating func mapping(map: Map) {
        workId <- map["workId"]
        workName <- map["workName"]
        workStatus <- map["workStatus"]
    }
}

struct JobTypeListSection {
    var items: [Item]
}

extension JobTypeListSection: SectionModelType {
    typealias Item = JobTypeInfoModel

    init(original: JobTypeListSection, items: [JobTypeListSection.Item]) {
        self = original
        self.items = items
    }
}
