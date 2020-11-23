//
//  LoginController.swift
//  beeparttime
//
//  Created by Senyas on 2020/8/1.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import AMScrollingNavbar
import JVFloatLabeledTextField
import RxCocoa
import RxSwift
import UIKit

class LoginController: ScrollingNavigationViewController, ScrollingNavigationControllerDelegate {
    let bag = DisposeBag()

    var viewModel: LoginViewModel?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    /// 登录视图
    var loginContentView = LoginContentView.instance()!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = ""

        viewModel = LoginViewModel(input: (email: loginContentView.lc_email_textField.rx.text.orEmpty.asDriver(), password: loginContentView.lc_password_textField.rx.text.orEmpty.asDriver()), validationService: ValidationService())

        viewModel?.emailUsable.drive(onNext: { [weak self] result in
            self?.loginContentView.nickname_result = result
        }).disposed(by: bag)

        viewModel?.passwordUsable.drive(onNext: { [weak self] result in
            self?.loginContentView.password_result = result
        }).disposed(by: bag)

        viewModel?.loginButtonEnabled.drive(onNext: { [weak self] isEnable in
            self?.loginContentView.login_isEnable = isEnable
        }).disposed(by: bag)
    }

    // Enable the navbar scrolling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /// 导航栏跟随滑动视图滚动
//        if let navigationController = self.navigationController as? ScrollingNavigationController {
//            if let tabBarController = tabBarController {
//                navigationController.followScrollView(settingTableView, delay: 0, scrollSpeedFactor: 2, followers: [NavigationBarFollower(view: tabBarController.tabBar, direction: .scrollDown)])
//            } else {
//                navigationController.followScrollView(settingTableView, delay: 0.0, scrollSpeedFactor: 2)
//            }
//            navigationController.scrollingNavbarDelegate = self
//            navigationController.expandOnActive = false
//        }
    }
}

extension LoginController: LoginContentDelegate {
    /// 1.登录
    func login() {
        /// 1.获取登录信息
        let userinfo: (String, String) = loginContentView.login_info
        /// 2.登录
        let isLogined: Bool = UserInfoHandle.share.login(email: userinfo.0, password: userinfo.1)

        if isLogined {
            MBProgressHUD.showMessage("登录成功", to: view)
            dismiss(animated: true, completion: nil)
        } else {
            MBProgressHUD.showError("用户名或密码错误", to: view)
        }
    }

    /// 2.注册
    func signup() {
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
}
