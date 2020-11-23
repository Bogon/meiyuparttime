//
//  JobContentFooterView.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/29.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import UIKit

class JobContentFooterView: UIView {
    // MARK: - 创建视图

    class func instance() -> JobContentFooterView? {
        let nibView = Bundle.main.loadNibNamed("JobContentFooterView", owner: nil, options: nil)
        if let view = nibView?.first as? JobContentFooterView {
            let ScreenWidth: CGFloat = UIScreen.main.bounds.width
            let _content_rect = CGRect(x: 0, y: 0, width: ScreenWidth, height: 85)
            view.frame = _content_rect
            return view
        }
        return nil
    }

    /// 返回页面布局Rect
    static var rect: CGRect {
        let ScreenWidth: CGFloat = UIScreen.main.bounds.width
        let _content_rect = CGRect(x: 0, y: 0, width: ScreenWidth, height: 85)
        return _content_rect
    }
}
