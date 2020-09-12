//
//  Date+Extention.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/26.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation

extension Date {
    var millisecond: TimeInterval {
        get { return self.timeIntervalSince1970 * 1000 }
    }
}
