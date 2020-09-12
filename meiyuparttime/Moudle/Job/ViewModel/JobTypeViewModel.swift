//
//  JobTypeViewModel.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/26.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Moya
import ObjectMapper

final class JobTypeViewModel {
    
    // 表格数据序列
    var tableData = BehaviorRelay<[JobTypeListSection]>(value: [])
     
    // 停止头部刷新状态
    let endHeaderRefreshing: Driver<Bool>
    
    // ViewModel初始化（根据输入实现对应的输出）
    init(input headerRefresh: Driver<Void>,
         dependency: (
         disposeBag: DisposeBag,
         networkService: JobTypeNetworkService)) {
        
        // 下拉结果序列
        let headerRefreshData = headerRefresh
            .startWith(()) //初始化时会先自动加载一次数据
            .flatMapLatest{  //也可考虑使用flatMapFirst
                return dependency.networkService.jobType()
            }
        
        // 生成停止头部刷新状态序列
        self.endHeaderRefreshing = headerRefreshData.map{ _ in true }
        
        // 下拉刷新时，直接将查询到的结果替换原数据
        headerRefreshData.drive(onNext: { items in
            self.tableData.accept(items)
        }).disposed(by: dependency.disposeBag)
        
    }
}

class JobTypeNetworkService {
    
    private let provider:MoyaProvider = MoyaProvider<JobTypeAPI>.init(endpointClosure: MoyaProvider<JobTypeAPI>.defaultEndpointMapping, requestClosure: MoyaProvider<JobTypeAPI>.defaultRequestMapping, stubClosure: MoyaProvider<JobTypeAPI>.neverStub, callbackQueue: nil, session:  MoyaProvider<JobTypeAPI>.defaultAlamofireSession(), plugins: [RequestLoadingPlugin(), NetworkLogger()], trackInflights: false)
    
    func jobType() -> Driver<[JobTypeListSection]> {
        let params: [String: Any] = [:]
        return provider.requestJson(.jobType(value: params), isCache: false)
            .mapObject(type:JobTypeResponseModel.self).flatMap({ (response) -> Observable<[JobTypeListSection]> in
                let jobTypeList: [JobTypeInfoModel] = (response.data)!
                return Observable.just([JobTypeListSection.init(items: jobTypeList)])
            }).asDriver(onErrorDriveWith: Driver.empty())
                    
    }
    
}
