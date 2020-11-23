//
//  JobContentEmptyView.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/30.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import UIKit

class JobContentEmptyView: UIView {
    // MARK: - 创建视图

    class func instance() -> JobContentEmptyView? {
        let nibView = Bundle.main.loadNibNamed("JobContentEmptyView", owner: nil, options: nil)
        if let view = nibView?.first as? JobContentEmptyView {
            let ScreenWidth: CGFloat = UIScreen.main.bounds.width
            let _content_rect = CGRect(x: 0, y: 0, width: ScreenWidth, height: 160)
            view.frame = _content_rect
            return view
        }
        return nil
    }

    /// 返回页面布局Rect
    static var _size: CGSize {
        let ScreenWidth: CGFloat = UIScreen.main.bounds.width
        let _content_size = CGSize(width: ScreenWidth, height: 160)
        return _content_size
    }
}
