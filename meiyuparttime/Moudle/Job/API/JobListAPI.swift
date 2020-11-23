//
//  JobListAPI.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/26.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Alamofire
import Foundation
import Moya
import RxSwift

private var basedURL: String {
    return "http://yzzp.miaoa6.com"
}

enum JobListAPI {
    /// 获取JOB信息
    case jobList(value: [String: Any]?)
}

extension JobListAPI: TargetType {
    /// 网络请求头设置
    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json; charset=utf-8"]
        }
    }

    /// 网络请求基地址
    public var baseURL: URL {
        return URL(string: basedURL)!
    }

    /// 网络请求路径
    public var path: String {
        switch self {
        case .jobList:
            return "/glub-app/user/resume/list"
        }
    }

    /// 设置请求方式
    public var method: Moya.Method {
        switch self {
        case .jobList:
            return .post
        }
    }

    /// 请求参数
    public var parameters: [String: Any]? {
        switch self {
        case let .jobList(value):
            return value
        }
    }

    /// Local data for unit test.use empty data temporarily.
    public var sampleData: Data {
        switch self {
        case let .jobList(value):
            return value!.jsonData()!
        }
    }

    // Represents an HTTP task.
    public var task: Task {
        switch self {
        case .jobList:
            return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
        }
    }

    public var parameterEncoding: ParameterEncoding {
        // Select type of parameter encoding based on requirements.Usually we use 'URLEncoding.default'.
        switch self {
        case .jobList:
            return JSONEncoding.default
        }
    }

    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
}
