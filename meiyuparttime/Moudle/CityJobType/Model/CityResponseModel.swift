//
//  CityResponseModel.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/30.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation
import LKDBHelper
import ObjectMapper
import RxDataSources

/// 工作的城市
struct CityJobTypeVosResponseModel: Mappable {
    var code: Int?
    var success: Bool?
    var msg: String?
    var data: [String: Any]?

    init?(map _: Map) {}

    mutating func mapping(map: Map) {
        code <- map["code"]
        success <- map["success"]
        msg <- map["msg"]
        data <- map["data"]
    }

    /// 工作类型数组
    var jobTypeVosList: [JobTypeVosInfoModel]? {
        guard let _data = data else { return [JobTypeVosInfoModel]() }
        if !_data.keys.contains("jobTypeVos") { return [JobTypeVosInfoModel]() }
        let _jobTypeVos: [[String: Any]] = _data["jobTypeVos"] as! [[String: Any]]
        let _job_type_vos_list = [JobTypeVosInfoModel].init(JSONArray: _jobTypeVos)
        return _job_type_vos_list
    }

    /// 工作城市
    var systemPopularCitiesList: [CityInfoModel]? {
        guard let _data = data else { return [CityInfoModel]() }
        if !_data.keys.contains("systemPopularCities") { return [CityInfoModel]() }
        let _systemPopularCities: [[String: Any]] = _data["systemPopularCities"] as! [[String: Any]]
        let _system_popular_cities_list = [CityInfoModel].init(JSONArray: _systemPopularCities)
        return _system_popular_cities_list
    }
}

/// 城市
@objc class CityInfoModel: NSObject, Mappable {
    @objc var cityId: Int = 1
    @objc var cityName: String?
    @objc var createTime: String?
    @objc var updateTime: String?

    /// 是否选中
    @objc var isSelected: Bool = false

    required init?(map _: Map) {}

    override init() {
        super.init()
    }

    /// 设置数据存储模型
    override static func getPrimaryKey() -> String {
        /// 消息id作为主键
        return "cityId"
    }

    override static func getTableName() -> String {
        return "CityInfoModel"
    }

    func mapping(map: Map) {
        cityId <- map["cityId"]
        cityName <- map["cityName"]
        createTime <- map["createTime"]
        updateTime <- map["updateTime"]
    }

    /// 获取操作用户表的句柄
    static var helper: LKDBHelper {
        let kSandDocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let targetPath: String = "\(kSandDocumentPath)/meiyuparttime.db"
        let db = LKDBHelper(dbPath: targetPath)
        return db
    }
}

struct CityJobTypeVosSection {
    var items: [Item]
}

extension CityJobTypeVosSection: SectionModelType {
    typealias Item = CityJobTypeVosResponseModel

    init(original: CityJobTypeVosSection, items: [CityJobTypeVosSection.Item]) {
        self = original
        self.items = items
    }
}

/// 兼职还是全职
@objc class JobTypeVosInfoModel: NSObject, Mappable {
    @objc var jobId: Int = 1
    @objc var jobName: String?
    /// 是否选中
    @objc var isSelected: Bool = false

    override init() {
        super.init()
    }

    required init?(map _: Map) {}

    /// 设置数据存储模型
    override static func getPrimaryKey() -> String {
        /// 消息id作为主键
        return "jobId"
    }

    override static func getTableName() -> String {
        return "JobTypeVosInfoModel"
    }

    func mapping(map: Map) {
        jobId <- map["jobId"]
        jobName <- map["jobName"]
    }

    /// 获取操作用户表的句柄
    static var helper: LKDBHelper {
        let kSandDocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let targetPath: String = "\(kSandDocumentPath)/meiyuparttime.db"
        let db = LKDBHelper(dbPath: targetPath)
        return db
    }
}
