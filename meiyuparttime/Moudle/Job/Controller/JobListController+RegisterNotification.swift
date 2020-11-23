//
//  JobListController+RegisterNotification.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/3.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation

extension JobListController {
    /// 注册通知中心
    func registerNotificationCenter() {
        /// 收到点击左侧城市
        NotificationCenter.default.rx
            .notification(NSNotification.Name.selectedcity)
            .takeUntil(rx.deallocated) /// 页面销毁自动移除通知监听
            .subscribe(onNext: { [weak self] notification in
                let userInfo: [String: Any] = notification.userInfo as! [String: Any]
                self?.updateCurrentCity(WithInfo: userInfo)

            }).disposed(by: bag)

        /// 收到点击工作面板
        NotificationCenter.default.rx
            .notification(NSNotification.Name.selectedVos)
            .takeUntil(rx.deallocated) /// 页面销毁自动移除通知监听
            .subscribe(onNext: { [weak self] notification in
                let userInfo: [String: Any] = notification.userInfo as! [String: Any]
                self?.updateVos(WithInfo: userInfo)

            }).disposed(by: bag)
    }
}
