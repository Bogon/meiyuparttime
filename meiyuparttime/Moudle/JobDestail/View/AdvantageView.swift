//
//  AdvantageView.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/6.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import UIKit

class AdvantageView: UIView {
    @IBOutlet var advance_imageview: UIImageView!
    @IBOutlet var advance_title_label: UILabel!
    @IBOutlet var advance_subtitle_label: UILabel!
    @IBOutlet var line: UIView!

    /// 个人优势
    var resume_advance: String = "工作踏实认真，做事有条理。学习能力强，适应环境能力强。" {
        didSet {
            var _resume_advance: String = resume_advance
            if resume_advance.length == 0 {
                _resume_advance = "工作踏实认真，做事有条理。学习能力强，适应环境能力强。"
            }
            advance_subtitle_label.text = _resume_advance
        }
    }

    // MARK: - 创建视图

    class func instance() -> AdvantageView? {
        let nibView = Bundle.main.loadNibNamed("AdvantageView", owner: nil, options: nil)
        if let view = nibView?.first as? AdvantageView {
            view.backgroundColor = .clear
            return view
        }
        return nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        advance_imageview.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(25)
            make.top.equalTo(self.snp.top).offset(20)
            make.size.equalTo(CGSize(width: 19, height: 19))
        }

        advance_title_label.snp.makeConstraints { make in
            make.left.equalTo(advance_imageview.snp.right).offset(5)
            make.top.equalTo(self.snp.top).offset(20)
            make.size.equalTo(CGSize(width: 120, height: 21))
        }

        let screen_width: CGFloat = UIScreen.main.bounds.size.width

        /// 计算当前字符串的value
        var _subtitle_size: CGSize = "\(resume_advance)  ".sizeWithConstrainedWidth(screen_width - 50, font: UIFont.systemFont(ofSize: 15))
        _subtitle_size.height += 2

        advance_subtitle_label.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(25)
            make.top.equalTo(advance_title_label.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: screen_width - 50, height: _subtitle_size.height))
        }

        line.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom)
            make.size.equalTo(CGSize(width: screen_width - 40, height: 1))
        }
    }

    static func getAdvanceHeight(resumeAdvance value: String) -> CGFloat {
        var _resume_advance: String = value
        if value.length == 0 {
            _resume_advance = "工作踏实认真，做事有条理。学习能力强，适应环境能力强。"
        }

        let screen_width: CGFloat = UIScreen.main.bounds.size.width

        /// 计算当前字符串的value
        var _subtitle_size: CGSize = "\(_resume_advance)  ".sizeWithConstrainedWidth(screen_width - 50, font: UIFont.systemFont(ofSize: 15))
        _subtitle_size.height += 2
        let __height: CGFloat = 20 + 21 + 15 + _subtitle_size.height + 20 + 1
        return __height
    }
}
