//
//  JobDetailResponseModel.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/4.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation
import LKDBHelper
import ObjectMapper
import RxDataSources

/// 获取工作详细信息
struct JobDetailResponseModel: Mappable {
    var code: Int?
    var success: Bool?
    var msg: String?
    var data: JobDetailInfoModel?

    init?(map _: Map) {}

    mutating func mapping(map: Map) {
        code <- map["code"]
        success <- map["success"]
        msg <- map["msg"]
        data <- map["data"]
    }
}

/// 工作信息
@objc class JobDetailInfoModel: NSObject, Mappable {
    @objc var distance: String?
    @objc var expectVos: [ExpectVosInfoModel]?
    @objc var jobVoList: [JobVosInfoModel]?
    @objc var lookStatus: Int = 0
    @objc var resumeVo: ResumeVoInfoModel?
    @objc var schoolVoList: [SchoolVoListInfoModel]?

    required init?(map: Map) {
        distance <- map["distance"]
        expectVos <- map["expectVos"]
        jobVoList <- map["jobVoList"]
        lookStatus <- map["lookStatus"]
        resumeVo <- map["resumeVo"]
        schoolVoList <- map["schoolVoList"]
    }

    func mapping(map _: Map) {}

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

/// 期望信息
@objc class ExpectVosInfoModel: NSObject, Mappable {
    @objc var cityName: String?
    @objc var coachPrice: String?
    @objc var coachType: Int = 0
    @objc var coachTypeName: String?
    @objc var expectId: Int = 0
    @objc var jobPosition: String?
    @objc var userId: Int = 0
    @objc var workId: Int = 0
    @objc var workOther: String?

    required init?(map _: Map) {}

    func mapping(map: Map) {
        cityName <- map["cityName"]
        coachPrice <- map["coachPrice"]
        coachType <- map["coachType"]
        coachTypeName <- map["coachTypeName"]
        expectId <- map["expectId"]
        jobPosition <- map["jobPosition"]
        userId <- map["userId"]
        workId <- map["workId"]
        workOther <- map["workOther"]
    }

    override init() {
        super.init()
    }

    /// 设置数据存储模型
    override static func getPrimaryKey() -> String {
        /// 消息id作为主键
        return "expectId"
    }

    override static func getTableName() -> String {
        return "ExpectVosInfoModel"
    }

    /// 获取操作用户表的句柄
    static var helper: LKDBHelper {
        let kSandDocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let targetPath: String = "\(kSandDocumentPath)/meiyuparttime.db"
        let db = LKDBHelper(dbPath: targetPath)
        return db
    }
}

/// 履历信息
@objc class JobVosInfoModel: NSObject, Mappable {
    @objc var jobContent: String?
    @objc var jobDep: String?
    @objc var jobId: Int = 0
    @objc var jobMent: String?
    @objc var jobName: String?
    @objc var jobPosition: String?
    @objc var jobType: String?
    @objc var jobYearTime: String?
    @objc var userId: Int = 0

    required init?(map _: Map) {}

    func mapping(map: Map) {
        jobContent <- map["jobContent"]
        jobDep <- map["jobDep"]
        jobId <- map["jobId"]
        jobMent <- map["jobMent"]
        jobName <- map["jobName"]
        jobPosition <- map["jobPosition"]
        jobType <- map["jobType"]
        jobYearTime <- map["jobYearTime"]
        userId <- map["userId"]
    }

    override init() {
        super.init()
    }

    /// 设置数据存储模型
    override static func getPrimaryKey() -> String {
        /// 消息id作为主键
        return "jobId"
    }

    override static func getTableName() -> String {
        return "JobVosInfoModel"
    }

    /// 获取操作用户表的句柄
    static var helper: LKDBHelper {
        let kSandDocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let targetPath: String = "\(kSandDocumentPath)/meiyuparttime.db"
        let db = LKDBHelper(dbPath: targetPath)
        return db
    }
}

/// 简历信息
@objc class ResumeVoInfoModel: NSObject, Mappable {
    @objc var cityName: String?
    @objc var coachAddr: String?
    @objc var coachAge: String?
    @objc var coachAvatarUrl: String?
    @objc var coachBirthday: String?
    @objc var coachDegree: String?
    @objc var coachDetailId: Int = 0
    @objc var coachEmail: String?
    @objc var coachHeight: String?
    @objc var coachJobStatus: Int = 0
    @objc var coachNickname: String?
    @objc var coachPhone: String?
    @objc var coachPrice: String?
    @objc var coachResume: String?
    @objc var coachSex: Int = 0
    @objc var coachSort: Int = 0
    @objc var coachStatus: Int = 0
    @objc var createTime: String?
    @objc var displayId: String?
    @objc var jobPosition: String?
    @objc var jobYears: String?
    @objc var jobYearsTime: String?
    @objc var resumeType: Int = 0
    @objc var sortTime: String?
    @objc var status: Int = 0
    @objc var updateTime: String?
    @objc var userId: Int = 0
    @objc var wxName: String?

    required init?(map _: Map) {}

    func mapping(map: Map) {
        cityName <- map["cityName"]
        coachAddr <- map["coachAddr"]
        coachAge <- map["coachAge"]
        coachAvatarUrl <- map["coachAvatarUrl"]
        coachBirthday <- map["coachBirthday"]
        coachDegree <- map["coachDegree"]
        coachDetailId <- map["coachDetailId"]
        coachEmail <- map["coachEmail"]
        coachHeight <- map["coachHeight"]
        coachJobStatus <- map["coachJobStatus"]
        coachNickname <- map["coachNickname"]
        coachPhone <- map["coachPhone"]
        coachPrice <- map["coachPrice"]
        coachResume <- map["coachResume"]
        coachSex <- map["coachSex"]
        coachSort <- map["coachSort"]
        coachStatus <- map["coachStatus"]
        createTime <- map["createTime"]
        displayId <- map["displayId"]
        jobPosition <- map["jobPosition"]
        jobYears <- map["jobYears"]
        jobYearsTime <- map["jobYearsTime"]
        resumeType <- map["resumeType"]
        sortTime <- map["sortTime"]
        status <- map["status"]
        updateTime <- map["updateTime"]
        userId <- map["userId"]
        wxName <- map["wxName"]
    }

    override init() {
        super.init()
    }

    /// 设置数据存储模型
    override static func getPrimaryKey() -> String {
        /// 消息id作为主键
        return "coachDetailId"
    }

    override static func getTableName() -> String {
        return "ResumeVoInfoModel"
    }

    /// 获取操作用户表的句柄
    static var helper: LKDBHelper {
        let kSandDocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let targetPath: String = "\(kSandDocumentPath)/meiyuparttime.db"
        let db = LKDBHelper(dbPath: targetPath)
        return db
    }
}

/// 学校信息
@objc class SchoolVoListInfoModel: NSObject, Mappable {
    @objc var schoolDegree: String?
    @objc var schoolDep: String?
    @objc var schoolId: Int = 0
    @objc var schoolMet: String?
    @objc var schoolName: String?
    @objc var schoolTime: String?
    @objc var schoolType: String?
    @objc var userId: Int = 0

    required init?(map _: Map) {}

    func mapping(map: Map) {
        schoolDegree <- map["schoolDegree"]
        schoolDep <- map["schoolDep"]
        schoolId <- map["schoolId"]
        schoolMet <- map["schoolMet"]
        schoolName <- map["schoolName"]
        schoolTime <- map["schoolTime"]
        schoolType <- map["schoolType"]
        userId <- map["userId"]
    }

    override init() {
        super.init()
    }

    /// 设置数据存储模型
    override static func getPrimaryKey() -> String {
        /// 消息id作为主键
        return "schoolId"
    }

    override static func getTableName() -> String {
        return "SchoolVoListInfoModel"
    }

    /// 获取操作用户表的句柄
    static var helper: LKDBHelper {
        let kSandDocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let targetPath: String = "\(kSandDocumentPath)/meiyuparttime.db"
        let db = LKDBHelper(dbPath: targetPath)
        return db
    }
}

struct JobDetailResponseSection {
    var items: [Item]
}

extension JobDetailResponseSection: SectionModelType {
    typealias Item = JobDetailResponseModel

    init(original: JobDetailResponseSection, items: [JobDetailResponseSection.Item]) {
        self = original
        self.items = items
    }
}
