//
//  JobListController+Layout.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/25.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation
import Hue
import MJRefresh
import Reusable
import DeviceKit
import SideMenu

extension JobListController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarSetting()
        
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor(hex: "#F7F7FD")
        initSubView()
        initRightItem()
    }
    
    private func navigationBarSetting() {
        navigationController?.navigationBar.barTintColor = UIColor(hex: "#F7F7FD")    /// 设置导航栏
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false           /// 去除磨砂效果
        navigationController?.navigationBar.tintColor = .black              /// 修改返回按钮的颜色
           
    }
    
    private func initSubView() {
        
        /// 添加职位类型选择视图
        jobTypeContentView.delegate = self
        view.addSubview(jobTypeContentView)
        
        contentTableView.delegate = self
        contentTableView.tableHeaderView = UIView()
        contentTableView.tableFooterView = UIView()
        view.addSubview(contentTableView)
        contentTableView.register(cellType: JobTableViewCell.self)
        
        // 设置头部刷新控件
        let header: MJRefreshNormalHeader = MJRefreshNormalHeader()
        header.lastUpdatedTimeLabel?.isHidden = true
        header.arrowView?.image = Asset.xiala.image
        contentTableView.mj_header = header
        // 设置尾部刷新控件
        let footer: MJRefreshBackNormalFooter = MJRefreshBackNormalFooter()
        footer.arrowView?.image = Asset.xiala.image
        contentTableView.mj_footer = footer
        
        jobContentEmptyView.isHidden = true
        view.addSubview(jobContentEmptyView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        jobContentEmptyView.snp.remakeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.size.equalTo(JobContentEmptyView._size)
        }
    }
    
    private func initRightItem() {
        
        if city_name.length != 0 {
            right_item_button.setTitle(" \(city_name)", for: .normal)
        }
        right_item_button.setImage(Asset.arrow.image, for: .normal)
        right_item_button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        right_item_button.setTitleColor(.black, for: .normal)
        right_item_button.addTarget(self, action: #selector(selectedCity), for: .touchUpInside)
        right_item_button.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: right_item_button)
    }
    
}
