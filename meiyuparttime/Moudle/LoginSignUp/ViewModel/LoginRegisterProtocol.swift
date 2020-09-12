//
//  LoginRegisterProtocol.swift
//  beeparttime
//
//  Created by Senyas on 2020/8/1.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation
import RxSwift

/// - success: ok
/// - empty: nothing
/// - failed: failed
enum ValidateResult {
    case success(message: String)
    case empty
    case failed(message: String)
}

protocol LoginRegisterAPI {
    func register(_ email: String, password: String) -> Observable<ValidateResult>
    func login(_ email: String, password: String) -> Observable<ValidateResult>
}

protocol ValidationServiceProcotol {
    func validateNickname(nickname value: String) -> ValidateResult
    func validateEmail(email value: String) -> ValidateResult
    func validatePassword(password value: String) -> ValidateResult
}

extension ValidateResult {
    var isValid: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
}
