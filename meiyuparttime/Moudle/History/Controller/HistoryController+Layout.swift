//
//  HistoryController+Layout.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/25.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation
import MJRefresh

extension HistoryController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarSetting()
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor(hex: "#F7F7FD")
        initSubView()
    }

    private func navigationBarSetting() {
        navigationController?.navigationBar.barTintColor = UIColor(hex: "#F7F7FD") /// 设置导航栏
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false /// 去除磨砂效果
        navigationController?.navigationBar.tintColor = .black /// 修改返回按钮的颜色
    }

    private func initSubView() {
        contentTableView.delegate = self
        contentTableView.tableHeaderView = UIView()
        contentTableView.tableFooterView = UIView()
        view.addSubview(contentTableView)
        contentTableView.register(cellType: JobTableViewCell.self)

        // 设置头部刷新控件
        let header = MJRefreshNormalHeader()
        header.lastUpdatedTimeLabel?.isHidden = true
        header.arrowView?.image = Asset.xiala.image
        contentTableView.mj_header = header

        jobContentEmptyView.isHidden = true
        view.addSubview(jobContentEmptyView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let _width: CGFloat = UIScreen.main.bounds.width
        let _bottom_margin: CGFloat = BottomMarginY.margin + (UIApplication.shared.delegate as! AppDelegate).getTabbarHeight()
        contentTableView.frame = CGRect(x: 0, y: 0, width: _width, height: UIScreen.main.bounds.height - _bottom_margin)

        jobContentEmptyView.snp.remakeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.size.equalTo(JobContentEmptyView._size)
        }
    }
}
