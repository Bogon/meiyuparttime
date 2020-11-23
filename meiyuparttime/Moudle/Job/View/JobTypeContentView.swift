//
//  JobTypeContentView.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/29.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import UIKit

protocol JobTypeContentViewDelegate: NSObjectProtocol {
    /// 选择职位类型
    func selectedJobType(result value: (String, String))
    /// 选择推荐和最新
    func selectedRecommendOrLastest(type value: String)
}

class JobTypeContentView: UIView {
    weak var delegate: JobTypeContentViewDelegate?

    fileprivate let button_tag: Int = 1101
    fileprivate var slected_index: Int = 1101

    /// 填充按钮的数据
    var type_data: [JobTypeInfoModel]? {
        didSet {
            layoutIfNeeded()
        }
    }

    @IBOutlet var recomand_button: UIButton!
    @IBOutlet var newest_button: UIButton!

    // MARK: - 创建视图

    class func instance() -> JobTypeContentView? {
        let nibView = Bundle.main.loadNibNamed("JobTypeContentView", owner: nil, options: nil)
        if let view = nibView?.first as? JobTypeContentView {
            return view
        }
        return nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        /// 初始化隐藏文本样式内容
        recomand_button.isHidden = true
        newest_button.isHidden = true

        recomand_button.isSelected = true
        newest_button.isSelected = false

        let button_width: CGFloat = 75
        let button_height: CGFloat = 35

        /// 推荐按钮样式设置
        recomand_button.setTitleColor(UIColor(hex: "#FFFFFF"), for: .selected)
        recomand_button.setTitleColor(UIColor(hex: "#484849"), for: .normal)
        recomand_button.setBackgroundImage(UIImage.getImage(WithColor: UIColor(hex: "#3134ce"), size: CGSize(width: button_width, height: button_height)), for: .selected)
        recomand_button.setBackgroundImage(UIImage.getImage(WithColor: UIColor(hex: "#F7F7FD"), size: CGSize(width: button_width, height: button_height)), for: .normal)
        recomand_button.layer.masksToBounds = true
        recomand_button.layer.cornerRadius = button_height / 2.0

        /// 最新按钮样式设置
        newest_button.setTitleColor(UIColor(hex: "#FFFFFF"), for: .selected)
        newest_button.setTitleColor(UIColor(hex: "#484849"), for: .normal)
        newest_button.setBackgroundImage(UIImage.getImage(WithColor: UIColor(hex: "#3134ce"), size: CGSize(width: button_width, height: button_height)), for: .selected)
        newest_button.setBackgroundImage(UIImage.getImage(WithColor: UIColor(hex: "#F7F7FD"), size: CGSize(width: button_width, height: button_height)), for: .normal)
        newest_button.layer.masksToBounds = true
        newest_button.layer.cornerRadius = button_height / 2.0
    }

    /// 点击推荐按钮
    @IBAction func recommend_action(_ sender: UIButton) {
        if sender.isSelected { return }
        newest_button.isSelected = sender.isSelected
        sender.isSelected = !sender.isSelected
        delegate?.selectedRecommendOrLastest(type: "1")
    }

    /// 点击最新按钮
    @IBAction func newest_action(_ sender: UIButton) {
        if sender.isSelected { return }
        recomand_button.isSelected = sender.isSelected
        sender.isSelected = !sender.isSelected
        delegate?.selectedRecommendOrLastest(type: "2")
    }

    /// 点击类型选择按钮
    @objc private func selectedTypeAction(_ sender: UIButton) {
        let seletced_button: UIButton = viewWithTag(slected_index) as! UIButton
        /// 存在已经选中的按钮，去除选中状态，新点击的按钮设置选中状态
        if seletced_button.isSelected {
            seletced_button.isSelected = !seletced_button.isSelected
            sender.isSelected = !seletced_button.isSelected
        } else { /// 不存在已经选中的按钮，直接设置点击的按钮为选中状态
            sender.isSelected = !sender.isSelected
        }
        slected_index = sender.tag

        guard let _type_data = type_data else { return }

        let job_type_info: JobTypeInfoModel = _type_data[slected_index - button_tag]
        let work_name: String = "\(job_type_info.workName ?? "")"
        let work_id: String = "\(job_type_info.workId ?? 0)"
        let result: (String, String) = (work_name, work_id)
        delegate?.selectedJobType(result: result)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        for (_, _subview) in subviews.enumerated() {
            if _subview.tag >= button_tag {
                return
            }
        }

        let ScreenWidth: CGFloat = UIScreen.main.bounds.width

        guard let _type_data = type_data else { return }
        recomand_button.isHidden = false
        newest_button.isHidden = false

        /// 按钮页面逻辑布局
        var _top_margin: CGFloat = 10
        var _left_margin: CGFloat = 0
        let _font_size: CGFloat = 13
        let _content_width: CGFloat = ScreenWidth - 20 - 20
        var _button_height: CGFloat = 0

        for (index, type_info) in _type_data.enumerated() {
            var _button_size: CGSize = "\(type_info.workName ?? "-")  ".sizeWithConstrainedWidth(_content_width, font: UIFont.systemFont(ofSize: _font_size))
            _button_size.height += 6
            let _right_margin: CGFloat = _left_margin + _button_size.width
            if _right_margin > _content_width {
                _left_margin = 0
                _top_margin = _top_margin + _button_size.height + 5
            }

            /// 计算左边距
            let _type_button = UIButton(frame: CGRect(x: _left_margin, y: _top_margin, width: _button_size.width, height: _button_size.height))
            _type_button.tag = button_tag + index
            _type_button.setTitle("\(type_info.workName ?? "-")", for: .normal)
            _type_button.isSelected = false
            _type_button.setTitleColor(UIColor(hex: "#3c3fd0"), for: .selected)
            _type_button.setTitleColor(UIColor(hex: "#9f9f9f"), for: .normal)
            _type_button.titleLabel?.font = UIFont.systemFont(ofSize: _font_size)
            _type_button.addTarget(self, action: #selector(selectedTypeAction(_:)), for: .touchUpInside)
            addSubview(_type_button)

            _left_margin += _button_size.width + 10
            /// 缓存按钮高度
            _button_height = _button_height == 0 ? _button_size.height : 0
        }

        _top_margin = _top_margin + _button_height + 15

        let button_width: CGFloat = 75
        let button_height: CGFloat = 35

        recomand_button.snp.remakeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top).offset(_top_margin)
            make.size.equalTo(CGSize(width: button_width, height: button_height))
        }

        newest_button.snp.remakeConstraints { make in
            make.left.equalTo(recomand_button.snp.right).offset(15)
            make.top.equalTo(self.snp.top).offset(_top_margin)
            make.size.equalTo(CGSize(width: button_width, height: button_height))
        }
    }

    /// 返回页面布局Rect
    var rect: CGRect {
        let ScreenWidth: CGFloat = UIScreen.main.bounds.width

        var _content_rect: CGRect = .zero
        guard let _type_data = type_data else { return _content_rect }

        /// 按钮页面逻辑布局
        /// 按钮页面逻辑布局
        var _top_margin: CGFloat = 10
        var _left_margin: CGFloat = 0
        let _font_size: CGFloat = 13
        let _content_width: CGFloat = ScreenWidth - 20 - 20
        var _button_height: CGFloat = 0

        for (_, type_info) in _type_data.enumerated() {
            var _button_size: CGSize = "\(type_info.workName ?? "-")  ".sizeWithConstrainedWidth(_content_width, font: UIFont.systemFont(ofSize: _font_size))
            _button_size.height += 6
            let _right_margin: CGFloat = _left_margin + _button_size.width
            if _right_margin > _content_width {
                _left_margin = 0
                _top_margin = _top_margin + _button_size.height + 5
            }
            _left_margin += _button_size.width + 10
            /// 缓存按钮高度
            _button_height = _button_height == 0 ? _button_size.height : 0
        }

        _top_margin = _top_margin + _button_height + 15

        let button_height: CGFloat = 35
        _top_margin += button_height + 15
        _content_rect = CGRect(x: 20, y: 0, width: _content_width, height: _top_margin)
        return _content_rect
    }
}
