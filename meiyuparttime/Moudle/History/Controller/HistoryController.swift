//
//  HistoryController.swift
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
import UIKit

class HistoryController: ScrollingNavigationViewController, ScrollingNavigationControllerDelegate {
    let bag = DisposeBag()

    fileprivate var history_view_model: HistoryViewModel?

    /// 空数据视图
    var jobContentEmptyView = JobContentEmptyView.instance()!

    // MARK: -  职位列表

    lazy var contentTableView: UITableView = {
        var contentTableView = UITableView()
        contentTableView.backgroundColor = .clear
        contentTableView.separatorStyle = .none
        return contentTableView
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        navigationItem.title = "Attention"

        registerNotificationCenter()

        history_view_model = HistoryViewModel(input: (contentTableView.mj_header?.rx.refreshing.asDriver())!, dependency: (disposeBag: bag, networkService: HistoryNetworkService()))

        load()

        // 下拉刷新状态结束的绑定
        history_view_model!.endHeaderRefreshing
            .drive(contentTableView.mj_header!.rx.endRefreshing)
            .disposed(by: bag)

        contentTableView.rx.itemSelected.bind { [weak self] indexPath in
            self?.contentTableView.deselectRow(at: indexPath, animated: true)
            let jobListSection: JobInfoListSection = (self?.history_view_model!.tableData.value[indexPath.section])!
            let jobInfoModel: JobInfoModel = jobListSection.items[indexPath.row] as JobInfoModel

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

    /// 重新加载数据
    func reload() {
        history_view_model?.load()
    }
}

extension HistoryController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return JobTableViewCell.layoutHeight
    }
}

private extension HistoryController {
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

        _ = history_view_model!.tableData.asObservable().bind(to: contentTableView.rx.items(dataSource: dataSource))

        _ = history_view_model!.tableData.asObservable().bind(onNext: { [weak self] job_info_list in
            if job_info_list.count == 0 {
                self?.jobContentEmptyView.isHidden = false
            } else {
                if (job_info_list.first?.items.count)! == 0 {
                    self?.jobContentEmptyView.isHidden = false
                } else {
                    self?.jobContentEmptyView.isHidden = true
                }
            }
        })
    }
}
