//
//  JobListController.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/25.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import AMScrollingNavbar
import MJRefresh
import Reusable
import RxCocoa
import RxDataSources
import RxSwift
import SideMenu
import UIKit

class JobListController: ScrollingNavigationViewController, ScrollingNavigationControllerDelegate {
    let bag = DisposeBag()

    fileprivate var job_list_viewmodel: JobListViewModel?
    fileprivate var job_type_viewModel: JobTypeViewModel?
    fileprivate var city_job_type_vos_viewmodel: CityJobTypeVosViewModel?

    private var right_item = UIButton()
    var city_name: String {
        let default_city_model: CityInfoModel? = CityInfoHandle.share.selectedCityInfo()
        return default_city_model?.cityName ?? "北京市"
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    /// 职位类型视图
    var jobTypeContentView = JobTypeContentView.instance()!
    /// 尾部视图
    var jobContentFooterView = JobContentFooterView.instance()!
    /// 空数据视图
    var jobContentEmptyView = JobContentEmptyView.instance()!

    var right_item_button = UIButton()

    // MARK: -  职位列表

    lazy var contentTableView: UITableView = {
        var contentTableView = UITableView()
        contentTableView.backgroundColor = .clear
        contentTableView.separatorStyle = .none
        return contentTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        registerNotificationCenter()

        // 初始化ViewModel
        job_list_viewmodel = JobListViewModel(
            input: (
                headerRefresh: (contentTableView.mj_header?.rx.refreshing.asDriver())!,
                footerRefresh: (contentTableView.mj_footer?.rx.refreshing.asDriver())!,
                word_id: 0,
                city_name: city_name,
                type: 1
            ),
            dependency: (
                disposeBag: bag,
                networkService: JobListNetworkService()
            )
        )

        /// 获取工作类型
        job_type_viewModel = JobTypeViewModel(input: (contentTableView.mj_header?.rx.refreshing.asDriver())!, dependency: (disposeBag: bag, networkService: JobTypeNetworkService()))

        /// 获取城市和职位类型信息
        city_job_type_vos_viewmodel = CityJobTypeVosViewModel(input: (contentTableView.mj_header?.rx.refreshing.asDriver())!, dependency: (disposeBag: bag, networkService: CityJobTypeVosNetworkService()))

        load()

        // 下拉刷新状态结束的绑定
        job_list_viewmodel!.endHeaderRefreshing!
            .drive(contentTableView.mj_header!.rx.endRefreshing)
            .disposed(by: bag)

        job_type_viewModel!.endHeaderRefreshing
            .drive(contentTableView.mj_header!.rx.endRefreshing)
            .disposed(by: bag)

        city_job_type_vos_viewmodel!.endHeaderRefreshing
            .drive(contentTableView.mj_header!.rx.endRefreshing)
            .disposed(by: bag)

        // 上拉刷新状态结束的绑定
        job_list_viewmodel!.endFooterRefreshing!
            .drive(contentTableView.mj_footer!.rx.endRefreshing)
            .disposed(by: bag)

        contentTableView.rx.itemSelected.bind { [weak self] indexPath in
            self?.contentTableView.deselectRow(at: indexPath, animated: true)
            let jobListSection: JobInfoListSection = (self?.job_list_viewmodel!.tableData.value[indexPath.section])!
            let jobInfoModel: JobInfoModel = jobListSection.items[indexPath.row] as JobInfoModel
            /// 1.保存浏览数据
            JobInfoHandle.share.insert(jobInfo: jobInfoModel)
            NotificationCenter.default.post(name: NSNotification.Name.attentionUser, object: nil)

            let jobDetailController = JobDetailController(jobInfo: jobInfoModel)
            jobDetailController.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(jobDetailController, animated: true)
        }.disposed(by: bag)
    }

    // Enable the navbar scrolling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /// 导航栏跟随滑动视图滚动
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            if let tabBarController = tabBarController {
                navigationController.followScrollView(contentTableView, delay: 0, scrollSpeedFactor: 2, followers: [NavigationBarFollower(view: tabBarController.tabBar, direction: .scrollDown)])
            } else {
                navigationController.followScrollView(contentTableView, delay: 0.0, scrollSpeedFactor: 2)
            }
            navigationController.scrollingNavbarDelegate = self
            navigationController.expandOnActive = false
        }
    }
}

extension JobListController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return JobTableViewCell.layoutHeight
    }
}

extension JobListController: JobTypeContentViewDelegate {
    /// 选择工作类型
    func selectedJobType(result value: (String, String)) {
        job_list_viewmodel?._work_id = value.1
    }

    /// 选择推荐1和最新2
    func selectedRecommendOrLastest(type value: String) {
        job_list_viewmodel?._type = value
    }
}

extension JobListController {
    /// 选择城市
    @objc func selectedCity() {
        // 显示侧栏菜单
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }

    /// 更新城市信息
    func updateCurrentCity(WithInfo userInfo: [String: Any]) {
        let _city_name: String = userInfo["cityName"] as! String
        job_list_viewmodel?._city_name = _city_name
        right_item_button.setTitle(" \(_city_name)", for: .normal)
    }

    /// 更新工作面板
    func updateVos(WithInfo userInfo: [String: Any]) {
        let _vos: Int = userInfo["vos"] as! Int
        job_list_viewmodel?._vos = _vos
    }
}

private extension JobListController {
    /// 1.保证网络正常的情况下加载骨架动画和请求数据
    func load() {
        let dataSource = RxTableViewSectionedReloadDataSource<JobInfoListSection>(configureCell: { _, tv, ip, item in
            let cell: JobTableViewCell = tv.dequeueReusableCell(for: ip)
            cell.selectionStyle = .none
            cell.avatar_url = item.coachAvatarUrl ?? ""
            cell.username = item.coachNickname ?? ""
            cell.job_id = item.displayId ?? ""
            cell.job_id = item.displayId ?? ""
            cell.job_want = item.jobIntention ?? ""
            cell.job_base = "\(item.coachAddr?.length == 0 ? "保密" : item.coachAddr ?? "保密"),\(item.coachAge?.length == 0 ? "保密" : item.coachAge ?? ""),本科"
            cell.job_xinzi = item.coachPrice ?? ""
            cell.job_advan = item.coachResume?.length == 0 ? "这个人很懒，什么也没写~" : item.coachResume ?? ""
            return cell
        })

        _ = job_list_viewmodel!.tableData.asObservable().bind(to: contentTableView.rx.items(dataSource: dataSource))

        _ = job_list_viewmodel!.tableData.asObservable().bind(onNext: { [weak self] job_info_list in
            if job_info_list.count == 0 {
                self?.jobContentFooterView.frame = JobContentFooterView.rect
                self?.contentTableView.tableFooterView = self?.jobContentFooterView
                self?.jobContentEmptyView.isHidden = false
            } else {
                if (job_info_list.first?.items.count)! % 20 == 0 {
                    self?.contentTableView.tableFooterView = UIView()
                } else {
                    self?.jobContentFooterView.frame = JobContentFooterView.rect
                    self?.contentTableView.tableFooterView = self?.jobContentFooterView
                }

                if (job_info_list.first?.items.count)! == 0 {
                    self?.jobContentEmptyView.isHidden = false
                } else {
                    self?.jobContentEmptyView.isHidden = true
                }
            }
        })

        _ = job_type_viewModel?.tableData.asObservable().bind(onNext: { [weak self] type_list_section in
            self?.jobTypeContentView.type_data = type_list_section.first?.items
            let _job_type_rect: CGRect = (self?.jobTypeContentView.rect)!
            self?.jobTypeContentView.frame = _job_type_rect
            let ContentScrollViewWidth: CGFloat = UIScreen.main.bounds.width
            /// 底部边距
            let _bottom_margin: CGFloat = BottomMarginY.margin + (UIApplication.shared.delegate as! AppDelegate).getTabbarHeight()
            self?.contentTableView.frame = CGRect(x: 0, y: _job_type_rect.height, width: ContentScrollViewWidth, height: UIScreen.main.bounds.height - _job_type_rect.height - _bottom_margin)

        })

        _ = city_job_type_vos_viewmodel?.tableData.asObservable().bind(onNext: { city_job_type_vos_section in

            guard let _cityJobTypeVosResponseModel = city_job_type_vos_section.first?.items.first else {
                return
            }
            /// 职位类型未入库，保存到数据库
            if !JobTypeVosInfoHandle.share.isExist() {
                guard let _job_type_vos_list = _cityJobTypeVosResponseModel.jobTypeVosList else { return }
                if _job_type_vos_list.count != 0 {
                    JobTypeVosInfoHandle.share.insertCityList(jobTypeVosInfoList: _job_type_vos_list)
                }
            }

            /// 城市未入库，保存到数据库
            if !CityInfoHandle.share.isExist() {
                guard let _system_popular_cities_list = _cityJobTypeVosResponseModel.systemPopularCitiesList else { return }
                if _system_popular_cities_list.count != 0 {
                    CityInfoHandle.share.insertCityList(cityInfoList: _system_popular_cities_list)
                }
                /// 更新城市信息
                NotificationCenter.default.post(name: NSNotification.Name.updatecity, object: nil, userInfo: nil)
            }

        })
    }
}
