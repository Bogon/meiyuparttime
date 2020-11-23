//
//  HistoryViewModel.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/6.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import RxCocoa
import RxSwift

final class HistoryViewModel {
    // 表格数据序列
    var tableData = BehaviorRelay<[JobInfoListSection]>(value: [])

    // 停止头部刷新状态
    let endHeaderRefreshing: Driver<Bool>

    // 头部刷新
    private var _header_refresh: Driver<Void>?

    /// 网络服务
    private var _network_service: HistoryNetworkService?

    /// 包管理器
    private var _dispose_bag: DisposeBag?

    // ViewModel初始化（根据输入实现对应的输出）
    init(input headerRefresh: Driver<Void>, dependency: (
        disposeBag: DisposeBag,
        networkService: HistoryNetworkService
    )) {
        _header_refresh = headerRefresh
        _network_service = dependency.networkService
        _dispose_bag = dependency.disposeBag

        // 下拉结果序列
        let headerRefreshData = headerRefresh
            .startWith(()) // 初始化时会先自动加载一次数据
            .flatMapLatest { // 也可考虑使用flatMapFirst
                dependency.networkService.collectionInfo()
            }

        // 生成停止头部刷新状态序列
        endHeaderRefreshing = headerRefreshData.map { _ in true }

        // 下拉刷新时，直接将查询到的结果替换原数据
        headerRefreshData.drive(onNext: { items in
            self.tableData.accept(items)
        }).disposed(by: dependency.disposeBag)
    }

    /// 下拉刷新
    func load() {
        // 下拉结果序列
        let headerRefreshData = _header_refresh!
            .startWith(()) // 初始化时会先自动加载一次数据
            .flatMapLatest { // 也可考虑使用flatMapFirst
                self._network_service!.collectionInfo()
            }

        // 下拉刷新时，直接将查询到的结果替换原数据
        headerRefreshData.drive(onNext: { [weak self] items in
            self?.tableData.accept(items)
        }).disposed(by: _dispose_bag!)
    }
}

class HistoryNetworkService {
    func collectionInfo() -> Driver<[JobInfoListSection]> {
        let response: [JobInfoModel] = JobInfoHandle.share.selecteJobList()
        return Observable.just([JobInfoListSection(items: response)]).asDriver(onErrorDriveWith: Driver.empty())
    }
}
