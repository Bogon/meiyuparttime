//
//  Macro.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/3.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation

// MARK: 通知

/// 城市选择模块通知
extension NSNotification.Name {
    public static let updatecity: NSNotification.Name = Notification.Name("updatecity")
    /// 选择左侧的城市
    public static let selectedcity: NSNotification.Name = Notification.Name("selectedcity")
    public static let selectedVos: NSNotification.Name = Notification.Name("selectedVos")
    public static let attentionUser: NSNotification.Name = Notification.Name("attentionUser")
}
