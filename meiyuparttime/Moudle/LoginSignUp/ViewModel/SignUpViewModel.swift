//
//  SignUpViewModel.swift
//  beeparttime
//
//  Created by Senyas on 2020/8/1.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct SignUpViewModel {
    // output:
    let nicknameUsable: Driver<ValidateResult>
    let emailUsable: Driver<ValidateResult>
    let passwordUsable: Driver<ValidateResult>
    let signupButtonEnabled: Driver<Bool>

    init(input: (nickname: Driver<String>, email: Driver<String>, password: Driver<String>),
         validationService: ValidationService)
    {
        /// 验证邮箱是否可用
        nicknameUsable = input.nickname
            .map { nickname in
                validationService.validateNickname(nickname: nickname)
            }

        /// 验证邮箱是否可用
        emailUsable = input.email
            .map { email in
                validationService.validateEmail(email: email)
            }

        /// 密码是否可用
        passwordUsable = input.password
            .map { password in
                validationService.validatePassword(password: password)
            }

        /// 登录按钮是否可用
        signupButtonEnabled = Driver.combineLatest(nicknameUsable, emailUsable, passwordUsable) { niackname, email, password in
            niackname.isValid && email.isValid && password.isValid
        }.distinctUntilChanged()
    }
}
