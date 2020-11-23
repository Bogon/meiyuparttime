//
//  CityJobTypeVosViewModel.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/30.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import RxCocoa
import RxSwift

final class CityJobTypeVosViewModel {
    // 城市数据序列
    var tableData = BehaviorRelay<[CityJobTypeVosSection]>(value: [])

    // 停止头部刷新状态
    let endHeaderRefreshing: Driver<Bool>
    // 头部刷新
    private var _header_refresh: Driver<Void>?

    /// 网络服务
    private var _network_service: CityJobTypeVosNetworkService?

    /// 包管理器
    private var _dispose_bag: DisposeBag?

    // ViewModel初始化（根据输入实现对应的输出）
    init(input headerRefresh: Driver<Void>,
         dependency: (
             disposeBag: DisposeBag,
             networkService: CityJobTypeVosNetworkService
         ))
    {
        _header_refresh = headerRefresh
        _network_service = dependency.networkService
        _dispose_bag = dependency.disposeBag

        // 下拉结果序列
        let headerRefreshData = headerRefresh
            .startWith(()) // 初始化时会先自动加载一次数据
            .flatMapLatest { // 也可考虑使用flatMapFirst
                dependency.networkService.jobType()
            }

        // 生成停止头部刷新状态序列
        endHeaderRefreshing = headerRefreshData.map { _ in true }

        // 下拉刷新时，直接将查询到的结果替换原数据
        headerRefreshData.drive(onNext: { items in
            self.tableData.accept(items)
        }).disposed(by: dependency.disposeBag)
    }
}

class CityJobTypeVosNetworkService {
    private let provider = MoyaProvider<CityJobTypeVosAPI>.init(endpointClosure: MoyaProvider<CityJobTypeVosAPI>.defaultEndpointMapping, requestClosure: MoyaProvider<CityJobTypeVosAPI>.defaultRequestMapping, stubClosure: MoyaProvider<CityJobTypeVosAPI>.neverStub, callbackQueue: nil, session: MoyaProvider<CityJobTypeVosAPI>.defaultAlamofireSession(), plugins: [RequestLoadingPlugin(), NetworkLogger()], trackInflights: false)

    func jobType() -> Driver<[CityJobTypeVosSection]> {
        let params: [String: Any] = [:]
        return provider.requestJson(.cityJobTypeVosInfo(value: params), isCache: false)
            .mapObject(type: CityJobTypeVosResponseModel.self).flatMap { (response) -> Observable<[CityJobTypeVosSection]> in
                let jobTypeList: [CityJobTypeVosResponseModel] = [response]
                return Observable.just([CityJobTypeVosSection(items: jobTypeList)])
            }.asDriver(onErrorDriveWith: Driver.empty())
    }
}
