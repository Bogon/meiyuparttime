//
//  JobTypeVosPanelView.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/3.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import UIKit

protocol JobTypeVosPanelDelegate: NSObjectProtocol {
    /// 选择城职位类型
    func selectedVos(vos value: Int)
}

class JobTypeVosPanelView: UIView {
    private let button_tag: Int = 100
    private var selected_index: Int = 100

    weak var delegate: JobTypeVosPanelDelegate?

    @IBOutlet var jtv_title_label: UILabel!
    @IBOutlet var jtv_all_button: UIButton!
    @IBOutlet var jtv_subtitle_label: UILabel!

    var jobTypeVosList: [JobTypeVosInfoModel]? {
        didSet {
            layoutIfNeeded()
        }
    }

    // MARK: - 创建视图

    class func instance() -> JobTypeVosPanelView? {
        let nibView = Bundle.main.loadNibNamed("JobTypeVosPanelView", owner: nil, options: nil)
        if let view = nibView?.first as? JobTypeVosPanelView {
            view.backgroundColor = .clear
            return view
        }
        return nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        jtv_all_button.setTitle("全职", for: .normal)
        jtv_all_button.layer.masksToBounds = true
        jtv_all_button.layer.cornerRadius = 3.0
    }

    @objc func vos_selected_action(_ sender: UIButton) {
        sender.isSelected = true
        jtv_all_button.setTitle(sender.tag == button_tag ? "全职" : "兼职", for: .normal)
        let lastest_button: UIButton = viewWithTag(selected_index) as! UIButton
        lastest_button.isSelected = false
        delegate?.selectedVos(vos: sender.tag - button_tag)
        selected_index = sender.tag
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        for (_, sub_view) in subviews.enumerated() {
            if sub_view.tag >= button_tag {
                return
            }
        }

        jtv_title_label.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(self.snp.top)
            make.size.equalTo(CGSize(width: 120, height: 20))
        }

        jtv_all_button.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(jtv_title_label.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 100, height: 30))
        }

        jtv_subtitle_label.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(jtv_all_button.snp.bottom).offset(35)
            make.size.equalTo(CGSize(width: 120, height: 20))
        }

        guard let _job_type_vos_list = jobTypeVosList else { return }
        let button_width: CGFloat = (drawWidth - 60) / 2.0
        let button_height: CGFloat = 30
        let margin: CGFloat = 20
        for (index, vos_model) in _job_type_vos_list.enumerated() {
            let city_button = UIButton()
            city_button.tag = button_tag + index
            city_button.setTitle(vos_model.jobName ?? "", for: .normal)
            city_button.setTitleColor(UIColor(hex: "#545454"), for: .normal)
            city_button.setTitleColor(UIColor(hex: "#2536d8"), for: .selected)
            city_button.titleLabel?.font = .systemFont(ofSize: 15)
            city_button.layer.masksToBounds = true
            city_button.layer.cornerRadius = 3.0
            city_button.backgroundColor = UIColor(hex: "#fafafa")
            city_button.addTarget(self, action: #selector(vos_selected_action(_:)), for: .touchUpInside)
            if index == 0 {
                city_button.isSelected = true
            } else {
                city_button.isSelected = false
            }
            addSubview(city_button)
            city_button.snp.makeConstraints { make in
                make.left.equalTo(self.snp.left).offset(margin + CGFloat(index % 2) * (button_width + margin))
                make.top.equalTo(jtv_subtitle_label.snp.bottom).offset(CGFloat(Int(index / 2)) * (button_height + margin) + margin)
                make.size.equalTo(CGSize(width: button_width, height: button_height))
            }
        }
    }

    /// 返回页面布局
    static var _height: CGFloat {
        return UIScreen.main.bounds.height - JobTypeVosNavigationView._height - TopMarginX.topMargin - 20 - BottomMarginY.margin
    }
}
