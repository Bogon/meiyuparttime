//
//  JobDetailViewModel.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/5.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Moya
import ObjectMapper

final class JobDetailViewModel {
    
    // 表格数据序列
    var tableData = BehaviorRelay<[JobDetailResponseSection]>(value: [])
     
    // 停止头部刷新状态
    let endHeaderRefreshing: Driver<Bool>
    
    // ViewModel初始化（根据输入实现对应的输出）
    init(input: (headerRefresh: Driver<Void>, detailID: Int),
         dependency: (
         disposeBag: DisposeBag,
         networkService: JobDetailNetworkService)) {
        
        // 下拉结果序列
        let headerRefreshData = input.headerRefresh
            .startWith(()) //初始化时会先自动加载一次数据
            .flatMapLatest{  //也可考虑使用flatMapFirst
                return dependency.networkService.jobType(detailID: input.detailID)
            }
        
        // 生成停止头部刷新状态序列
        self.endHeaderRefreshing = headerRefreshData.map{ _ in true }
        
        // 下拉刷新时，直接将查询到的结果替换原数据
        headerRefreshData.drive(onNext: { items in
            self.tableData.accept(items)
        }).disposed(by: dependency.disposeBag)
        
    }
}

class JobDetailNetworkService {
    
    private let provider:MoyaProvider = MoyaProvider<JobDetailAPI>.init(endpointClosure: MoyaProvider<JobDetailAPI>.defaultEndpointMapping, requestClosure: MoyaProvider<JobDetailAPI>.defaultRequestMapping, stubClosure: MoyaProvider<JobDetailAPI>.neverStub, callbackQueue: nil, session:  MoyaProvider<JobDetailAPI>.defaultAlamofireSession(), plugins: [RequestLoadingPlugin(), NetworkLogger()], trackInflights: false)
    
    func jobType(detailID value: Int) -> Driver<[JobDetailResponseSection]> {
        let params: [String: Any] = ["userId": 100031, "coachDetailId": value]
        return provider.requestJson(.detail(value: params), isCache: false)
            .mapObject(type:JobDetailResponseModel.self).flatMap({ (response) -> Observable<[JobDetailResponseSection]> in
                let jobDetailList: [JobDetailResponseModel] = [response]
                return Observable.just([JobDetailResponseSection.init(items: jobDetailList)])
            }).asDriver(onErrorDriveWith: Driver.empty())
                    
    }
    
}
