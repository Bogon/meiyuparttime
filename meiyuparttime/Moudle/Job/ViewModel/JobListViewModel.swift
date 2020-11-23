//
//  JobListViewModel.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/26.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import RxCocoa
import RxSwift

final class JobListViewModel {
    // 表格数据序列
    var tableData = BehaviorRelay<[JobInfoListSection]>(value: [])

    // 停止头部刷新状态
    var endHeaderRefreshing: Driver<Bool>?

    // 停止尾部刷新状态
    var endFooterRefreshing: Driver<Bool>?

    // 头部刷新
    private var _header_refresh: Driver<Void>?

    // 尾部刷新
    private var _footer_refresh: Driver<Void>?

    /// 网络服务
    private var _network_service: JobListNetworkService?

    /// 包管理器
    private var _dispose_bag: DisposeBag?

    /// 工作类型
    var _work_id: String = "" {
        didSet {
            load()
        }
    }

    /// 城市
    var _city_name: String = "" {
        didSet {
            load()
        }
    }

    /// 最新还是推荐
    var _type: String = "" {
        didSet {
            load()
        }
    }

    /// 工作面板
    var _vos: Int = -1 {
        didSet {
            load()
        }
    }

    // ViewModel初始化（根据输入实现对应的输出）
    init(input: (
        headerRefresh: Driver<Void>,
        footerRefresh: Driver<Void>, word_id: Int, city_name: String, type: Int
    ),
    dependency: (
        disposeBag: DisposeBag,
        networkService: JobListNetworkService
    )) {
        _work_id = "\(input.word_id)"
        _city_name = input.city_name
        _type = "\(input.type)"

        _header_refresh = input.headerRefresh
        _footer_refresh = input.footerRefresh
        _network_service = dependency.networkService
        _dispose_bag = dependency.disposeBag

        // 下拉结果序列
        let headerRefreshData = _header_refresh!
            .startWith(()) // 初始化时会先自动加载一次数据
            .flatMapLatest { [weak self] in // 也可考虑使用flatMapFirst
                self!._network_service!.jobList(word_id: self!._work_id, city_name: self!._city_name, type: self!._type, vos: self!._vos)
            }

        // 上拉结果序列
        let footerRefreshData = _footer_refresh!
            .flatMapLatest { [weak self] in // 也可考虑使用flatMapFirst
                self!._network_service!.nextPage(word_id: self!._work_id, city_name: self!._city_name, type: self!._type, vos: self!._vos)
            }

        // 生成停止头部刷新状态序列
        endHeaderRefreshing = headerRefreshData.map { _ in true }

        // 生成停止尾部刷新状态序列
        endFooterRefreshing = footerRefreshData.map { _ in true }

        // 下拉刷新时，直接将查询到的结果替换原数据
        headerRefreshData.drive(onNext: { [weak self] items in
            self?.tableData.accept(items)
        }).disposed(by: _dispose_bag!)

        // 上拉加载时，将查询到的结果拼接到原数据底部
        footerRefreshData.drive(onNext: { [weak self] items in
            self?.tableData.accept((self?.tableData.value)! + items)
        }).disposed(by: _dispose_bag!)
    }

    /// 下拉刷新
    private func load() {
        // 下拉结果序列
        let headerRefreshData = _header_refresh!
            .startWith(()) // 初始化时会先自动加载一次数据
            .flatMapLatest { [weak self] in // 也可考虑使用flatMapFirst
                self!._network_service!.jobList(word_id: self!._work_id, city_name: self!._city_name, type: self!._type, vos: self!._vos)
            }

        // 下拉刷新时，直接将查询到的结果替换原数据
        headerRefreshData.drive(onNext: { [weak self] items in
            self?.tableData.accept(items)
        }).disposed(by: _dispose_bag!)
    }
}

class JobListNetworkService {
    private var page: Int = 1

    private let provider = MoyaProvider<JobListAPI>.init(endpointClosure: MoyaProvider<JobListAPI>.defaultEndpointMapping, requestClosure: MoyaProvider<JobListAPI>.defaultRequestMapping, stubClosure: MoyaProvider<JobListAPI>.neverStub, callbackQueue: nil, session: MoyaProvider<JobListAPI>.defaultAlamofireSession(), plugins: [RequestLoadingPlugin(), NetworkLogger()], trackInflights: false)
    
    
    

    func jobList(word_id _id: String, city_name: String, type: String, vos: Int) -> Driver<[JobInfoListSection]> {
        page = 1
        var params: [String: Any] = ["cityName": city_name,
                                     "workId": _id == "0" ? "" : "\(_id)",
                                     "type": type,
                                     "pageSize": "20",
                                     "pageNum": "\(page)",
                                     "coachType": "\(vos)"]
        if vos == -1 {
            params.removeValue(forKey: "coachType")
        }
        return provider.requestJson(.jobList(value: params), isCache: false)
            .mapObject(type: JobListResponseModel.self).flatMap { (response) -> Observable<[JobInfoListSection]> in
                let jobInfoList: [JobInfoModel] = (response.data ?? [JobInfoModel]())
                return Observable.just([JobInfoListSection(items: jobInfoList)])
            }.asDriver(onErrorDriveWith: Driver.empty())
    }

    // MARK: - 获取下一页热门兼职的信息

    /// 热门兼职信息列表-下一页
    ///
    /// - Parameter value: 无
    /// - Returns:  热门兼职信息
    func nextPage(word_id _id: String, city_name: String, type: String, vos: Int) -> Driver<[JobInfoListSection]> {
        page += 1
        var params: [String: Any] = ["cityName": city_name,
                                     "workId": _id == "0" ? "" : "\(_id)",
                                     "type": type,
                                     "pageSize": "20",
                                     "pageNum": "\(page)",
                                     "coachType": "\(vos)"]
        if vos == -1 {
            params.removeValue(forKey: "coachType")
        }
        return provider.requestJson(.jobList(value: params), isCache: false)
            .mapObject(type: JobListResponseModel.self).flatMap { (response) -> Observable<[JobInfoListSection]> in
                let jobInfoList: [JobInfoModel] = (response.data ?? [JobInfoModel]())
                return Observable.just([JobInfoListSection(items: jobInfoList)])
            }.asDriver(onErrorDriveWith: Driver.empty())
    }
}
