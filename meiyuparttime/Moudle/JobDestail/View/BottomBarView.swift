//
//  BottomBarView.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/6.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import UIKit

protocol BottomBarViewDelegate: NSObjectProtocol {
    /// 联系ta
    func connectedTaAction(phone value: String)
}

class BottomBarView: UIView {
    weak var delegate: BottomBarViewDelegate?

    @IBOutlet var content_view: UIView!
    @IBOutlet var notice_imageview: UIImageView!
    @IBOutlet var title_label: UILabel!
    @IBOutlet var phone_label: UILabel!
    @IBOutlet var warnning_imageview: UIImageView!
    @IBOutlet var connect_button: UIButton!

    /// 电话数据
    var phone_number: String = "13442616834" {
        didSet {
            /// 对电话号码进行加密
            var _phone_number: String = phone_number
            let _phone_headfix: String = phone_number.substring(to: 2)
            let _phone_footerfix: String = phone_number.substring(from: 7)
            _phone_number = "\(_phone_headfix)****\(_phone_footerfix)"
            phone_label.text = _phone_number
        }
    }

    // MARK: - 创建视图

    class func instance() -> BottomBarView? {
        let nibView = Bundle.main.loadNibNamed("BottomBarView", owner: nil, options: nil)
        if let view = nibView?.first as? BottomBarView {
            view.backgroundColor = .clear
            return view
        }
        return nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        content_view.layer.masksToBounds = true
        content_view.layer.cornerRadius = 5

        /// 添加左右晃动效果
        let shake = CABasicAnimation(keyPath: "transform.translation.x")
        shake.fromValue = NSNumber(floatLiteral: -5)
        shake.toValue = NSNumber(floatLiteral: 5)
        shake.duration = 0.5
        shake.autoreverses = true
        shake.repeatCount = Float(CGFloat.greatestFiniteMagnitude)
        notice_imageview.layer.add(shake, forKey: "shakeAnimation")
    }

    @IBAction func connected_action(_: UIButton) {
        delegate?.connectedTaAction(phone: phone_number)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        warnning_imageview.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).offset(-30)
            make.top.equalTo(self.snp.top).offset(20)
            make.size.equalTo(CGSize(width: 86, height: 44))
        }

        content_view.snp.makeConstraints { make in
            make.right.equalTo(warnning_imageview.snp.left).offset(-10)
            make.top.equalTo(self.snp.top).offset(20)
            make.left.equalTo(self.snp.left).offset(25)
            make.height.equalTo(44)
        }

        notice_imageview.snp.makeConstraints { make in
            make.left.equalTo(content_view.snp.left).offset(25)
            make.centerY.equalTo(content_view.snp.centerY)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }

        title_label.snp.makeConstraints { make in
            make.centerX.equalTo(content_view.snp.centerX).offset(24)
            make.bottom.equalTo(content_view.snp.centerY)
            make.size.equalTo(CGSize(width: 120, height: 15))
        }

        phone_label.snp.makeConstraints { make in
            make.centerX.equalTo(content_view.snp.centerX).offset(24)
            make.top.equalTo(content_view.snp.centerY)
            make.size.equalTo(CGSize(width: 100, height: 15))
        }

        connect_button.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.bottom.equalTo(content_view.snp.bottom)
        }
    }

    static var _height: CGFloat {
        return 84
    }
}
