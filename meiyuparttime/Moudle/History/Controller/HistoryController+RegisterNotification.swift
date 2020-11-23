//
//  HistoryController+RegisterNotification.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/6.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation

extension HistoryController {
    /// 注册通知中心
    func registerNotificationCenter() {
        /// 关注新职位人员
        NotificationCenter.default.rx
            .notification(NSNotification.Name.attentionUser)
            .takeUntil(rx.deallocated) /// 页面销毁自动移除通知监听
            .subscribe(onNext: { [weak self] _ in
                self?.reload()
            }).disposed(by: bag)
    }
}
