//
//  JobTypeVosNavigationView.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/2.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 选择城市以及工作类型面板
enum PanelType: Int {
    /// 城市面板
    case city = 0
    /// 工作类型面板
    case vos = 1
}

protocol JobTypeVosNavigationDelegate: NSObjectProtocol {
    /// 选择城市以及工作类型
    func selectedCityVos(vos value: PanelType)
}

class JobTypeVosNavigationView: UIView {
    private let button_tag: Int = 120
    weak var delegate: JobTypeVosNavigationDelegate?

    @IBOutlet var jtv_titel_label: UILabel!
    @IBOutlet var hot_button: UIButton!
    @IBOutlet var job_type_button: UIButton!
    @IBOutlet var arrow: UIView!

    // MARK: - 创建视图

    class func instance() -> JobTypeVosNavigationView? {
        let nibView = Bundle.main.loadNibNamed("JobTypeVosNavigationView", owner: nil, options: nil)
        if let view = nibView?.first as? JobTypeVosNavigationView {
            view.backgroundColor = .clear
            return view
        }
        return nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        hot_button.setTitleColor(UIColor(hex: "#6c6c6c"), for: .normal)
        hot_button.setTitleColor(UIColor(hex: "#343434"), for: .selected)

        job_type_button.setTitleColor(UIColor(hex: "#6c6c6c"), for: .normal)
        job_type_button.setTitleColor(UIColor(hex: "#343434"), for: .selected)

        hot_button.isSelected = true
        job_type_button.isSelected = false
    }

    @IBAction func hot_click_action(_ sender: UIButton) {
        sender.isSelected = true
        job_type_button.isSelected = false
        // 更新动画
        UIView.animate(withDuration: 0.25, animations: {
            self.arrow.snp.remakeConstraints { make in
                make.centerX.equalTo(self.hot_button.snp.centerX)
                make.top.equalTo(self.hot_button.snp.bottom).offset(5)
                make.size.equalTo(CGSize(width: 35, height: 3))
            }
        })

        delegate?.selectedCityVos(vos: .city)
    }

    @IBAction func hob_type_action(_ sender: UIButton) {
        sender.isSelected = true
        hot_button.isSelected = false

        // 更新动画
        UIView.animate(withDuration: 0.25, animations: {
            self.arrow.snp.remakeConstraints { make in
                make.centerX.equalTo(self.job_type_button.snp.centerX)
                make.top.equalTo(self.hot_button.snp.bottom).offset(5)
                make.size.equalTo(CGSize(width: 35, height: 3))
            }
        })

        delegate?.selectedCityVos(vos: .vos)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        jtv_titel_label.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(self.snp.top)
            make.size.equalTo(CGSize(width: 144, height: 26))
        }

        hot_button.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(jtv_titel_label.snp.bottom).offset(40)
            make.size.equalTo(CGSize(width: 70, height: 25))
        }

        job_type_button.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).offset(-20)
            make.top.equalTo(jtv_titel_label.snp.bottom).offset(40)
            make.size.equalTo(CGSize(width: 70, height: 25))
        }

        arrow.snp.makeConstraints { make in
            if hot_button.isSelected {
                make.centerX.equalTo(hot_button.snp.centerX)
            } else {
                make.centerX.equalTo(job_type_button.snp.centerX)
            }
            make.top.equalTo(hot_button.snp.bottom).offset(5)
            make.size.equalTo(CGSize(width: 35, height: 3))
        }
    }

    /// 返回页面布局Rect
    static var _height: CGFloat {
        return 126.5
    }
}
