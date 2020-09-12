//
//  JobTypeVosController+Layout.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/2.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation

extension JobTypeVosController {
    
    override func loadView() {
        super.loadView()
        initliazeSubView()
        navigationBarSetting()
    }
    
    private func initliazeSubView() {
        jobCityPanelView.isHidden = false
        jobTypeVosPanelView.isHidden = true
        
        jobCityPanelView.delegate = self
        jobTypeVosPanelView.delegate = self
        jobTypeVosNavigationView.delegate = self
        view.addSubview(jobTypeVosNavigationView)
        view.addSubview(jobCityPanelView)
        view.addSubview(jobTypeVosPanelView)
    }
    
    private func navigationBarSetting() {
        navigationController?.navigationBar.barTintColor = UIColor.clear    /// 设置导航栏
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false           /// 去除磨砂效果
        navigationController?.navigationBar.tintColor = .black              /// 修改返回按钮的颜色
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        jobTypeVosNavigationView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left)
            make.top.equalTo(self.view.snp.top).offset(TopMarginX.topMargin - 20)
            make.size.equalTo(CGSize(width: drawWidth, height: JobTypeVosNavigationView._height))
        }
        
        jobCityPanelView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left)
            make.top.equalTo(self.jobTypeVosNavigationView.snp.bottom).offset(25.5)
            make.size.equalTo(CGSize(width: drawWidth, height: JobCityPanelView._height))
        }
        
        jobTypeVosPanelView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left)
            make.top.equalTo(self.jobTypeVosNavigationView.snp.bottom).offset(25.5)
            make.size.equalTo(CGSize(width: drawWidth, height: JobTypeVosPanelView._height))
        }
    }
    
}
