//
//  JobCityPanelView.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/2.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import UIKit

protocol JobCityPanelViewDelegate: NSObjectProtocol {
    /// 选择城市
    func selectedCity(cityName value: String)
}

class JobCityPanelView: UIView {
    weak var delegate: JobCityPanelViewDelegate?

    private let button_tag: Int = 110

    @IBOutlet var jcp_title_label: UILabel!
    @IBOutlet var jcp_location_button: UIButton!

    @IBOutlet var jcp_hot_city_label: UILabel!

    var popular_cities_list: [CityInfoModel]? {
        didSet {
            layoutIfNeeded()
        }
    }

    // MARK: - 创建视图

    class func instance() -> JobCityPanelView? {
        let nibView = Bundle.main.loadNibNamed("JobCityPanelView", owner: nil, options: nil)
        if let view = nibView?.first as? JobCityPanelView {
            view.backgroundColor = .clear
            return view
        }
        return nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        let default_city_model: CityInfoModel? = CityInfoHandle.share.selectedCityInfo()
        jcp_location_button.setTitle("  \(default_city_model?.cityName ?? "")", for: .normal)
        jcp_location_button.layer.masksToBounds = true
        jcp_location_button.layer.cornerRadius = 3.0
    }

    @objc func city_selected_action(_ sender: UIButton) {
        guard let _popular_cities_list = popular_cities_list else { return }
        let _city_model: CityInfoModel = _popular_cities_list[sender.tag - button_tag]
        jcp_location_button.setTitle("  \(_city_model.cityName ?? "北京市")", for: .normal)
        delegate?.selectedCity(cityName: _city_model.cityName ?? "北京市")
        CityInfoHandle.share.setSelectedCityInfo(selectedCityInfo: _city_model)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        for (_, sub_view) in subviews.enumerated() {
            if sub_view.tag >= button_tag {
                return
            }
        }

        jcp_title_label.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(self.snp.top)
            make.size.equalTo(CGSize(width: 120, height: 20))
        }

        jcp_location_button.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(jcp_title_label.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 100, height: 30))
        }

        jcp_hot_city_label.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(jcp_location_button.snp.bottom).offset(35)
            make.size.equalTo(CGSize(width: 120, height: 20))
        }

        guard let _popular_cities_list = popular_cities_list else { return }
        let button_width: CGFloat = (drawWidth - 60) / 2.0
        let button_height: CGFloat = 30
        let margin: CGFloat = 20
        for (index, city_model) in _popular_cities_list.enumerated() {
            let city_button = UIButton()
            city_button.tag = button_tag + index
            city_button.setTitle(city_model.cityName ?? "", for: .normal)
            city_button.setTitleColor(UIColor(hex: "#545454"), for: .normal)
            city_button.titleLabel?.font = .systemFont(ofSize: 15)
            city_button.layer.masksToBounds = true
            city_button.layer.cornerRadius = 3.0
            city_button.backgroundColor = UIColor(hex: "#fafafa")
            city_button.addTarget(self, action: #selector(city_selected_action(_:)), for: .touchUpInside)
            addSubview(city_button)
            city_button.snp.makeConstraints { make in
                make.left.equalTo(self.snp.left).offset(margin + CGFloat(index % 2) * (button_width + margin))
                make.top.equalTo(jcp_hot_city_label.snp.bottom).offset(CGFloat(Int(index / 2)) * (button_height + margin) + margin)
                make.size.equalTo(CGSize(width: button_width, height: button_height))
            }
        }
    }

    /// 返回页面布局
    static var _height: CGFloat {
        return UIScreen.main.bounds.height - JobTypeVosNavigationView._height - TopMarginX.topMargin - 20 - BottomMarginY.margin
    }
}
