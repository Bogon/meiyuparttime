//
//  FirstLaunch.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/12.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation

fileprivate let FirstLaunchValue: String = "FirstLaunchValue"
fileprivate let EverLaunchValue: String = "EverLaunchValue"

struct FirstLaunch {
    
    /// func is first launch
    static func firstLaunch() {
        if UserDefaults.standard.bool(forKey: EverLaunchValue) {
            UserDefaults.standard.set(true, forKey: EverLaunchValue)
            UserDefaults.standard.set(false, forKey: FirstLaunchValue)
        } else {
            UserDefaults.standard.set(true, forKey: FirstLaunchValue)
            UserDefaults.standard.set(true, forKey: EverLaunchValue)
        }
    }

    /// get is first launch
    static func isFirstLaunch() -> Bool {
       return UserDefaults.standard.bool(forKey: FirstLaunchValue)
    }
    
}
