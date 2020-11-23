//
//  ExpectVosView.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/6.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import UIKit

class ExpectVosView: UIView {
    @IBOutlet var vos_imageview: UIImageView!
    @IBOutlet var title_label: UILabel!
    @IBOutlet var job_type_label: UILabel!
    @IBOutlet var salory_label: UILabel!
    @IBOutlet var address_label: UILabel!
    @IBOutlet var vos_label: UILabel!
    @IBOutlet var line: UIView!

    /// 职位
    var job_positon: String = "" {
        didSet {
            job_type_label.text = job_positon
        }
    }

    /// 薪资范围
    var salory: String = "" {
        didSet {
            salory_label.text = salory
        }
    }

    /// 工作地址
    var address: String = "" {
        didSet {
            address_label.text = address
        }
    }

    /// 职位类型
    var job_type: String = "" {
        didSet {
            vos_label.text = job_type
        }
    }

    // MARK: - 创建视图

    class func instance() -> ExpectVosView? {
        let nibView = Bundle.main.loadNibNamed("ExpectVosView", owner: nil, options: nil)
        if let view = nibView?.first as? ExpectVosView {
            view.backgroundColor = .clear
            return view
        }
        return nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        address_label.layer.masksToBounds = true
        address_label.layer.cornerRadius = 3

        vos_label.layer.masksToBounds = true
        vos_label.layer.cornerRadius = 3
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        vos_imageview.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(25)
            make.top.equalTo(self.snp.top).offset(20)
            make.size.equalTo(CGSize(width: 19, height: 19))
        }

        title_label.snp.makeConstraints { make in
            make.left.equalTo(vos_imageview.snp.right).offset(5)
            make.top.equalTo(self.snp.top).offset(20)
            make.size.equalTo(CGSize(width: 120, height: 25))
        }

        job_type_label.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(25)
            make.top.equalTo(title_label.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 80, height: 25))
        }

        salory_label.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).offset(-25)
            make.top.equalTo(title_label.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 80, height: 25))
        }

        address_label.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(25)
            make.top.equalTo(salory_label.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 65, height: 25))
        }

        vos_label.snp.makeConstraints { make in
            make.left.equalTo(address_label.snp.right).offset(15)
            make.top.equalTo(salory_label.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 65, height: 25))
        }

        let screen_width: CGFloat = UIScreen.main.bounds.size.width

        line.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom)
            make.size.equalTo(CGSize(width: screen_width - 40, height: 1))
        }
    }

    static var _height: CGFloat {
        return 146
    }
}
