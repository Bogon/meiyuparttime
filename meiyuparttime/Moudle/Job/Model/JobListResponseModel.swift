//
//  JobListResponseModel.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/26.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation
import LKDBHelper
import ObjectMapper
import RxDataSources

/// 获取工作信息
struct JobListResponseModel: Mappable {
    var code: Int?
    var success: Bool?
    var msg: String?
    var data: [JobInfoModel]?

    init?(map _: Map) {}

    mutating func mapping(map: Map) {
        code <- map["code"]
        success <- map["success"]
        msg <- map["msg"]
        data <- map["data"]
    }
}

/// 具体工作信息
@objc class JobInfoModel: NSObject, Mappable {
    @objc var coachAddr: String?
    @objc var coachAge: String?
    @objc var coachAvatarUrl: String?
    @objc var coachDegree: String?
    @objc var coachDetailId: Int = 0
    @objc var coachId: NSInteger = 0
    @objc var coachNickname: String?
    @objc var coachPrice: String?
    @objc var coachResume: String?
    @objc var coachSex: NSInteger = 1
    @objc var displayId: String?
    @objc var distance: String?
    @objc var jobIntention: String?
    @objc var status: NSInteger = 0

    /// 创建时间
    @objc var insert_time: TimeInterval = Date().millisecond
    // 关联用户id, 为空时表示在游客模式
    @objc var user_id: String = ""

    required init?(map _: Map) {}

    func mapping(map: Map) {
        coachAddr <- map["coachAddr"]
        coachAge <- map["coachAge"]
        coachAvatarUrl <- map["coachAvatarUrl"]
        coachDegree <- map["coachDegree"]
        coachDetailId <- map["coachDetailId"]
        coachId <- map["coachId"]
        coachNickname <- map["coachNickname"]
        coachPrice <- map["coachPrice"]
        coachResume <- map["coachResume"]
        coachSex <- map["coachSex"]
        displayId <- map["displayId"]
        distance <- map["distance"]
        jobIntention <- map["jobIntention"]
        status <- map["status"]
    }

    override init() {
        super.init()
    }

    /// 设置数据存储模型
    override static func getPrimaryKey() -> String {
        /// 消息id作为主键
        return "coachId"
    }

    override static func getTableName() -> String {
        return "JobInfoModel"
    }

    /// 获取操作用户表的句柄
    static var helper: LKDBHelper {
        let kSandDocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let targetPath: String = "\(kSandDocumentPath)/meiyuparttime.db"
        let db = LKDBHelper(dbPath: targetPath)
        return db
    }
}

struct JobInfoListSection {
    var items: [Item]
}

extension JobInfoListSection: SectionModelType {
    typealias Item = JobInfoModel

    init(original: JobInfoListSection, items: [JobInfoListSection.Item]) {
        self = original
        self.items = items
    }
}
