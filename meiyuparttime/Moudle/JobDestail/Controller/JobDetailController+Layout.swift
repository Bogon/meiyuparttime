//
//  JobDetailController+Layout.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/5.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation
import MJRefresh

extension JobDetailController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarSetting()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor(hex: "#FFFFFF")
        leftBarItemSeeting()
        initSubView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let _width: CGFloat = UIScreen.main.bounds.width
        /// 底部边距
        let _bottom_margin: CGFloat = BottomMarginY.margin + (UIApplication.shared.delegate as! AppDelegate).getTabbarHeight()
        let _height: CGFloat = UIScreen.main.bounds.height - _bottom_margin
        contentScrollView.frame = CGRect(x: 0, y: 0, width: _width, height: _height)
        
        employeeHeaderView.snp.remakeConstraints { (make) in
            make.left.equalTo(contentScrollView.snp.left)
            make.top.equalTo(contentScrollView.snp.top)
            make.size.equalTo(CGSize(width: _width, height: EmployeeHeaderView._height))
        }
        
        advantageView.snp.remakeConstraints { (make) in
            make.left.equalTo(contentScrollView.snp.left)
            make.top.equalTo(employeeHeaderView.snp.bottom)
            make.size.equalTo(CGSize(width: _width, height: AdvantageView.getAdvanceHeight(resumeAdvance: "")))
        }
        
        expectVosView.snp.remakeConstraints { (make) in
            make.left.equalTo(contentScrollView.snp.left)
            make.top.equalTo(advantageView.snp.bottom)
            make.size.equalTo(CGSize(width: _width, height: ExpectVosView._height))
        }
        
        jobVoView.snp.remakeConstraints { (make) in
            make.left.equalTo(contentScrollView.snp.left)
            make.top.equalTo(expectVosView.snp.bottom)
            make.size.equalTo(CGSize(width: _width, height: JobVoView.getJobVoHeight(jobVoModel: jobVosInfoModel)))
        }
        
        schoolVoView.snp.remakeConstraints { (make) in
            make.left.equalTo(contentScrollView.snp.left)
            make.top.equalTo(jobVoView.snp.bottom)
            make.size.equalTo(CGSize(width: _width, height: SchoolVoView._height))
        }
        
        bottomBarView.snp.remakeConstraints { (make) in
            make.left.equalTo(view.snp.left)
            make.bottom.equalTo(view.snp.bottom)
            make.size.equalTo(CGSize(width: _width, height: BottomBarView._height))
        }
        
        let contentOffset: CGFloat = EmployeeHeaderView._height + AdvantageView.getAdvanceHeight(resumeAdvance: "") + ExpectVosView._height + JobVoView.getJobVoHeight(jobVoModel: jobVosInfoModel) + SchoolVoView._height + TopMarginX.topMargin
        
        contentScrollView.contentSize = CGSize(width: _width, height: contentOffset)
        
    }
    
    private func navigationBarSetting() {
        navigationController?.navigationBar.barTintColor = UIColor(hex: "#F7F7FD")
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .black
           
    }
    
    private func leftBarItemSeeting() {
        let closeItem:UIBarButtonItem = UIBarButtonItem.init(image: Asset.back.image, style: .plain, target: self, action:
            #selector(pop))
        closeItem.tintColor = UIColor(hex: "#333333")
        navigationItem.leftBarButtonItem = closeItem
    }
    
    @objc private func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func initSubView() {
        
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(employeeHeaderView)
        contentScrollView.addSubview(advantageView)
        contentScrollView.addSubview(expectVosView)
        contentScrollView.addSubview(jobVoView)
        contentScrollView.addSubview(schoolVoView)
        bottomBarView.delegate = self
        view.addSubview(bottomBarView)
        bottomBarView.isHidden = true
        
        // 设置头部刷新控件
        let header: MJRefreshNormalHeader = MJRefreshNormalHeader()
        header.lastUpdatedTimeLabel?.isHidden = true
        header.arrowView?.image = Asset.xiala.image
        contentScrollView.mj_header = header
    }
    
}
