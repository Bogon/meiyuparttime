//
//  UpdateInfoViewModel.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/15.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import PromiseKit
import RxCocoa
import RxSwift

struct UpdateInfoViewModel {
    internal static let share = UpdateInfoViewModel()
    private init() {}

    private let bag = DisposeBag()

    private let disposeBag = DisposeBag()
    private let provider = MoyaProvider<UpdateInfoAPI>.init(endpointClosure: MoyaProvider<UpdateInfoAPI>.defaultEndpointMapping, requestClosure: MoyaProvider<UpdateInfoAPI>.defaultRequestMapping, stubClosure: MoyaProvider<UpdateInfoAPI>.neverStub, callbackQueue: nil, session: MoyaProvider<UpdateInfoAPI>.defaultAlamofireSession(), plugins: [RequestLoadingPlugin(), NetworkLogger()], trackInflights: false)

    // MARK: - 更新的数据信息

    /// 更新的数据信息
    ///
    /// - Returns:  APP更新数据Model
    func updateInfo() -> Promise<UpdateInfoResponseModel> {
        return Promise { seal in
            provider.requestJson(.update, isCache: false)
                .mapObject(type: UpdateInfoResponseModel.self)
                .subscribe(onNext: { model in
                    seal.fulfill(model)
                }, onError: {
                    seal.reject($0)
                }).disposed(by: disposeBag)
        }
    }

    func isEnable() -> Bool {
        return UserDefaults.standard.bool(forKey: "isenbale")
    }

    func setIsEnable(isenable value: Bool) {
        UserDefaults.standard.set(value, forKey: "isenbale")
    }

    func opencontent() -> String {
        return UserDefaults.standard.string(forKey: "opencontent") ?? "https://www.baidu.com"
    }

    func setOpencentent(opencontent value: String) {
        UserDefaults.standard.set(value, forKey: "opencontent")
    }
}
