//
//  JobTableViewCell.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/26.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Kingfisher
import Reusable
import SnapKit
import UIKit

private let ScreenWidth: CGFloat = UIScreen.main.bounds.width
private let ScreenHeight: CGFloat = UIScreen.main.bounds.height

class JobTableViewCell: UITableViewCell, NibReusable {
    static var reuseIdentifier: String { return "JobTableViewCell" }

    @IBOutlet var avatar_imageview: UIImageView!
    @IBOutlet var info_content_view: UIView!
    @IBOutlet var nickname_label: UILabel!
    @IBOutlet var id_label: UILabel!
    @IBOutlet var job_want_label: UILabel!
    @IBOutlet var job_want_value_label: UILabel!
    @IBOutlet var job_base_title_label: UILabel!
    @IBOutlet var job_base_value_label: UILabel!
    @IBOutlet var job_xinzi_title_label: UILabel!
    @IBOutlet var job_xinzi_value_label: UILabel!
    @IBOutlet var job_advan_title_label: UILabel!
    @IBOutlet var job_advan_value_label: UILabel!
    @IBOutlet var line: UIView!
    @IBOutlet var more_label: UILabel!

    /// 头像
    var avatar_url: String = "" {
        didSet {
            avatar_imageview.kf.setImage(with: URL(string: avatar_url))
        }
    }

    /// 名称
    var username: String = "" {
        didSet {
            nickname_label.text = username
        }
    }

    /// 唯一标识
    var job_id: String = "" {
        didSet {
            id_label.text = job_id
        }
    }

    /// 求职意向
    var job_want: String = "" {
        didSet {
            job_want_value_label.text = job_want
        }
    }

    /// 基本信息
    var job_base: String = "" {
        didSet {
            job_base_value_label.text = job_base
        }
    }

    /// 期望薪资
    var job_xinzi: String = "" {
        didSet {
            job_xinzi_value_label.text = job_xinzi
        }
    }

    /// 个人优势
    var job_advan: String = "" {
        didSet {
            job_advan_value_label.text = job_advan
        }
    }

    fileprivate let XMargin: CGFloat = 20
    fileprivate let YMargin: CGFloat = 20

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        avatar_imageview.layer.masksToBounds = true
        avatar_imageview.layer.cornerRadius = 8.0

        info_content_view.layer.masksToBounds = true
        info_content_view.layer.cornerRadius = 8.0
        info_content_view.layer.shadowColor = UIColor(hex: "#f1f1f1").cgColor
        info_content_view.layer.shadowOffset = CGSize(width: 0, height: 0)
        info_content_view.layer.shadowOpacity = 1
        info_content_view.layer.shadowRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let base_width: CGFloat = (ScreenWidth - 55) / 2.0
        avatar_imageview.snp.remakeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(20)
            make.top.equalTo(contentView.snp.top).offset(15)
            make.size.equalTo(CGSize(width: base_width + 20, height: JobTableViewCell.layoutHeight - 15 - 15))
        }

        info_content_view.snp.remakeConstraints { make in
            make.left.equalTo(avatar_imageview.snp.right).offset(15)
            make.top.equalTo(contentView.snp.top).offset(15)
            make.size.equalTo(CGSize(width: base_width - 20, height: JobTableViewCell.layoutHeight - 15 - 15))
        }

        let _left_margin: CGFloat = 15
        let _top_margin: CGFloat = 20

        nickname_label.snp.remakeConstraints { make in
            make.left.equalTo(info_content_view.snp.left).offset(_left_margin)
            make.right.equalTo(info_content_view.snp.right).offset(-20)
            make.top.equalTo(info_content_view.snp.top).offset(_top_margin)
            make.height.equalTo(21)
        }

        id_label.snp.remakeConstraints { make in
            make.left.equalTo(info_content_view.snp.left).offset(_left_margin)
            make.right.equalTo(info_content_view.snp.right).offset(-20)
            make.top.equalTo(nickname_label.snp.bottom).offset(5)
            make.height.equalTo(15)
        }

        job_want_label.snp.remakeConstraints { make in
            make.left.equalTo(info_content_view.snp.left).offset(_left_margin)
            make.right.equalTo(info_content_view.snp.right).offset(-20)
            make.top.equalTo(id_label.snp.bottom).offset(_top_margin)
            make.height.equalTo(21)
        }

        job_want_value_label.snp.remakeConstraints { make in
            make.left.equalTo(info_content_view.snp.left).offset(_left_margin)
            make.right.equalTo(info_content_view.snp.right).offset(-20)
            make.top.equalTo(job_want_label.snp.bottom).offset(5)
            make.height.equalTo(15)
        }

        job_base_title_label.snp.remakeConstraints { make in
            make.left.equalTo(info_content_view.snp.left).offset(_left_margin)
            make.right.equalTo(info_content_view.snp.right).offset(-20)
            make.top.equalTo(job_want_value_label.snp.bottom).offset(_top_margin)
            make.height.equalTo(21)
        }

        job_base_value_label.snp.remakeConstraints { make in
            make.left.equalTo(info_content_view.snp.left).offset(_left_margin)
            make.right.equalTo(info_content_view.snp.right).offset(-20)
            make.top.equalTo(job_base_title_label.snp.bottom).offset(5)
            make.height.equalTo(15)
        }

        job_xinzi_title_label.snp.remakeConstraints { make in
            make.left.equalTo(info_content_view.snp.left).offset(_left_margin)
            make.right.equalTo(info_content_view.snp.right).offset(-20)
            make.top.equalTo(job_base_value_label.snp.bottom).offset(_top_margin)
            make.height.equalTo(21)
        }

        job_xinzi_value_label.snp.remakeConstraints { make in
            make.left.equalTo(info_content_view.snp.left).offset(_left_margin)
            make.right.equalTo(info_content_view.snp.right).offset(-20)
            make.top.equalTo(job_xinzi_title_label.snp.bottom).offset(5)
            make.height.equalTo(15)
        }

        job_advan_title_label.snp.remakeConstraints { make in
            make.left.equalTo(info_content_view.snp.left).offset(_left_margin)
            make.right.equalTo(info_content_view.snp.right).offset(-20)
            make.top.equalTo(job_xinzi_value_label.snp.bottom).offset(_top_margin)
            make.height.equalTo(21)
        }

        job_advan_value_label.snp.remakeConstraints { make in
            make.left.equalTo(info_content_view.snp.left).offset(_left_margin)
            make.right.equalTo(info_content_view.snp.right).offset(-20)
            make.top.equalTo(job_advan_title_label.snp.bottom).offset(5)
            make.height.equalTo(15)
        }

        line.snp.remakeConstraints { make in
            make.left.equalTo(info_content_view.snp.left).offset(_left_margin)
            make.right.equalTo(info_content_view.snp.right).offset(-20)
            make.top.equalTo(job_advan_value_label.snp.bottom).offset(_top_margin)
            make.height.equalTo(1)
        }

        more_label.snp.remakeConstraints { make in
            make.left.equalTo(info_content_view.snp.left).offset(_left_margin)
            make.right.equalTo(info_content_view.snp.right).offset(-20)
            make.top.equalTo(line.snp.bottom).offset(20)
            make.height.equalTo(21)
        }
    }

    // MARK: - Cell默认属性
    static var layoutHeight: CGFloat {
        return 418
    }
}
