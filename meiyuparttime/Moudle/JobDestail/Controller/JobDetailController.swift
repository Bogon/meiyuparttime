//
//  JobDetailController.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/5.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import MJRefresh
import RxCocoa
import RxSwift
import RxDataSources
import Reusable

class JobDetailController: ScrollingNavigationViewController, ScrollingNavigationControllerDelegate {
    
    let bag = DisposeBag()
    
    private var viewModel: JobDetailViewModel?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    private var infoModel: JobInfoModel?
    
    var jobVosInfoModel: JobVosInfoModel = JobVosInfoModel()
    
    /// 求职人介绍视图
    var employeeHeaderView: EmployeeHeaderView = EmployeeHeaderView.instance()!
    /// 求职人个人优势
    var advantageView: AdvantageView = AdvantageView.instance()!
    /// 求职人期望
    var expectVosView: ExpectVosView = ExpectVosView.instance()!
    /// 求职人工作经历
    var jobVoView: JobVoView = JobVoView.instance()!
    /// 求职人教育经历
    var schoolVoView: SchoolVoView = SchoolVoView.instance()!
    /// 联系求职者
    var bottomBarView: BottomBarView = BottomBarView.instance()!
    
    
    // MARK:-  职位列表
    lazy var contentScrollView: UIScrollView = {
        var _contentScrollView: UIScrollView = UIScrollView()
        _contentScrollView.backgroundColor = .clear
        return _contentScrollView
    }()
    
    init(jobInfo value: JobInfoModel) {
        super.init(nibName: nil, bundle: nil)
        infoModel = value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "\(infoModel?.coachNickname ?? "-")"
        
        // 初始化ViewModel
        viewModel = JobDetailViewModel(input: (headerRefresh: (contentScrollView.mj_header?.rx.refreshing.asDriver())!, detailID: infoModel!.coachDetailId), dependency: (disposeBag: bag, networkService: JobDetailNetworkService()))
        
        load()

        // 下拉刷新状态结束的绑定
        viewModel!.endHeaderRefreshing
            .drive(contentScrollView.mj_header!.rx.endRefreshing)
            .disposed(by: bag)
        
    }

    // Enable the navbar scrolling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /// 导航栏跟随滑动视图滚动
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            if let tabBarController = tabBarController {
                navigationController.followScrollView(contentScrollView, delay: 0, scrollSpeedFactor: 2, followers: [NavigationBarFollower(view: tabBarController.tabBar, direction: .scrollDown)])
            } else {
                navigationController.followScrollView(contentScrollView, delay: 0.0, scrollSpeedFactor: 2)
            }
            navigationController.scrollingNavbarDelegate = self
            navigationController.expandOnActive = false
        }
    }
    
}

extension JobDetailController: BottomBarViewDelegate {
    
    func connectedTaAction(phone value: String) {
        //用这个API打电话
        if let mobileURL:URL = URL(string: "tel://\(value)") {
            UIApplication.shared.open(mobileURL, options: [:], completionHandler: nil)
        }
    }
}

private extension JobDetailController {
    
    /// 1.请求数据
    func load() {
        
        _ = viewModel?.tableData.asObservable().bind(onNext: { [weak self] (job_detail_response_section) in
            
            /// 数据源绑定
            guard let _jobDetailResponseModel = job_detail_response_section.first?.items.first else {
                return
            }
            
            /// 头部个人信息数据绑定
            let resumeVo: ResumeVoInfoModel = _jobDetailResponseModel.data?.resumeVo ?? ResumeVoInfoModel()
            self?.employeeHeaderView.avatar_url = resumeVo.coachAvatarUrl ?? ""
            self?.employeeHeaderView.nickname = resumeVo.coachNickname ?? ""
            self?.employeeHeaderView.job_id = resumeVo.displayId ?? ""
            self?.employeeHeaderView.job_status = resumeVo.coachJobStatus
            self?.employeeHeaderView.address = resumeVo.coachAddr ?? ""
            self?.employeeHeaderView.age = resumeVo.coachAge ?? ""
            self?.employeeHeaderView.degree = resumeVo.coachDegree ?? ""
            self?.employeeHeaderView.job_time = resumeVo.jobYearsTime ?? ""
            /// 个人优势
            self?.advantageView.resume_advance = resumeVo.coachResume ?? ""
            /// 工作期望
            let expectVosInfoModel: ExpectVosInfoModel = _jobDetailResponseModel.data?.expectVos?.first ?? ExpectVosInfoModel()
            self?.expectVosView.job_positon = expectVosInfoModel.jobPosition ?? "总助"
            self?.expectVosView.salory = expectVosInfoModel.coachPrice ?? "面议"
            self?.expectVosView.address = expectVosInfoModel.cityName ?? "全国"
            self?.expectVosView.job_type = expectVosInfoModel.coachTypeName ?? "全职"
            /// 工作经历
            let _jobVosInfoModel: JobVosInfoModel = _jobDetailResponseModel.data?.jobVoList?.first ?? JobVosInfoModel()
            self?.jobVosInfoModel = _jobVosInfoModel
            self?.jobVoView.compony = _jobVosInfoModel.jobName ?? "-"
            self?.jobVoView.job_year = _jobVosInfoModel.jobYearTime ?? "-"
            self?.jobVoView.positon = _jobVosInfoModel.jobPosition ?? "-"
            self?.jobVoView.job_detail = _jobVosInfoModel.jobContent ?? "-"
            /// 教育经历
            let schoolVoListInfoModel: SchoolVoListInfoModel = _jobDetailResponseModel.data?.schoolVoList?.first ?? SchoolVoListInfoModel()
            self?.schoolVoView.school_name = schoolVoListInfoModel.schoolName ?? "-"
            self?.schoolVoView.year = schoolVoListInfoModel.schoolTime ?? "-"
            self?.schoolVoView.profession = schoolVoListInfoModel.schoolType ?? "-"
            /// 添加联系方式
            self?.bottomBarView.isHidden = false
            self?.bottomBarView.phone_number = resumeVo.coachPhone ?? "13442616834"
            
        })
    }
    
}
