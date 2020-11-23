//
//  RequestLoadingPlugin.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/26.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation
import Moya

/// show or hide the loading hud
public final class RequestLoadingPlugin: PluginType {
    public func willSend(_: RequestType, target _: TargetType) {
        /// show loading
        //        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    public func didReceive(_: Result<Moya.Response, MoyaError>, target _: TargetType) {
        // hide loading
        //        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

// network logger
public final class NetworkLogger: PluginType {
    public func willSend(_: RequestType, target _: TargetType) {}
    public func didReceive(_: Result<Moya.Response, MoyaError>, target _: TargetType) {
//        log.info("\(target)")
    }
}

protocol CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy { get }
}

final class CachePolicyPlugin: PluginType {
    init(configuration: URLSessionConfiguration, inMemoryCapacity: Int, diskCapacity: Int, diskPath: String?) {
        configuration.urlCache = URLCache(memoryCapacity: inMemoryCapacity, diskCapacity: diskCapacity, diskPath: diskPath)
    }

    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let cachePolicyGettable = target as? CachePolicyGettable {
            var mutableRequest = request
            mutableRequest.cachePolicy = cachePolicyGettable.cachePolicy
            return mutableRequest
        }

        return request
    }
}
