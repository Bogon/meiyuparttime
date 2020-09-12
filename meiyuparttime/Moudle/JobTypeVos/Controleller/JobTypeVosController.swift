//
//  JobTypeVosController.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/2.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


let drawWidth: CGFloat = 230

class JobTypeVosController: UIViewController {

    let bag = DisposeBag()
    
    /// 标题
    var jobTypeVosNavigationView: JobTypeVosNavigationView = JobTypeVosNavigationView.instance()!
    
    /// 城市列表
    var jobCityPanelView: JobCityPanelView = JobCityPanelView.instance()!
    
    /// 工作类型列表
    var jobTypeVosPanelView: JobTypeVosPanelView = JobTypeVosPanelView.instance()!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /// 收到点击工作面板
        NotificationCenter.default.rx
            .notification(NSNotification.Name.updatecity)
            .takeUntil(self.rx.deallocated) /// 页面销毁自动移除通知监听
            .subscribe(onNext: { [weak self] _ in
                self?.updateCityList()
            }).disposed(by: bag)
    }
    
    private func updateCityList() {
        jobCityPanelView.popular_cities_list = CityInfoHandle.share.getCityInfoList()
        jobTypeVosPanelView.jobTypeVosList = JobTypeVosInfoHandle.share.getJobTypeVosInfoList()
        
    }

}

extension JobTypeVosController: JobTypeVosNavigationDelegate {
    
    func selectedCityVos(vos value: PanelType) {
        
        switch value {
            case .city:
                jobCityPanelView.isHidden = false
                jobTypeVosPanelView.isHidden = true
            case .vos:
                jobCityPanelView.isHidden = true
                jobTypeVosPanelView.isHidden = false
        }
    }
}

extension JobTypeVosController: JobCityPanelViewDelegate {
    
    func selectedCity(cityName value: String) {
        let selectedInfo: [String: Any]? = ["cityName": value]
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name.selectedcity, object: nil, userInfo: selectedInfo)
        }
    }
}

extension JobTypeVosController: JobTypeVosPanelDelegate {
    
    func selectedVos(vos value: Int) {
        let selectedInfo: [String: Any]? = ["vos": value]
        NotificationCenter.default.post(name: NSNotification.Name.selectedVos, object: nil, userInfo: selectedInfo)
    }
}
