//
//  Double+roundTo.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/26.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation

extension Double {
    /// 保留后几位
    /// - parameter places: 保留小数位数
    ///
    /// - returns: 保留后的结果.
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
