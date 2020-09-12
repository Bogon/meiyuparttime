//
//  JobVoView.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/6.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import UIKit

class JobVoView: UIView {

    @IBOutlet weak var icon_imageview: UIImageView!
    @IBOutlet weak var title_label: UILabel!
    @IBOutlet weak var compony_label: UILabel!
    @IBOutlet weak var year_label: UILabel!
    @IBOutlet weak var positon_label: UILabel!
    @IBOutlet weak var detail_label: UILabel!
    @IBOutlet weak var line: UIView!
    
    /// 公司名称
    var compony: String = "无" {
        didSet {
            var _compony: String = compony
            if compony.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).length == 0 {
                _compony = "无"
            }
            compony_label.text = _compony
        }
    }
    
    /// 工作区间
    var job_year: String = "无" {
        didSet {
            var _job_year: String = job_year
            if job_year.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).length == 0 {
                _job_year = "无"
            }
            year_label.text = _job_year
        }
    }
    
    /// 职位
    var positon: String = "无" {
        didSet {
            var _positon: String = positon
            if positon.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).length == 0 {
                _positon = "无"
            }
            positon_label.text = _positon
        }
    }
    
    /// 工作内容
    var job_detail: String = "无" {
        didSet {
            var _job_detail: String = job_detail
            if job_detail.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).length == 0 {
                _job_detail = "这个人很懒，什么也没留下~"
            }
            detail_label.text = _job_detail
            setNeedsLayout()
        }
    }
    
    // MARK:- 创建视图
    class func instance() -> JobVoView? {
        let nibView = Bundle.main.loadNibNamed("JobVoView", owner: nil, options: nil)
        if let view = nibView?.first as? JobVoView {
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

        let screen_width: CGFloat = UIScreen.main.bounds.size.width
        
        icon_imageview.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(25)
            make.top.equalTo(self.snp.top).offset(23)
            make.size.equalTo(CGSize(width: 19, height: 19))
        }
        
        title_label.snp.makeConstraints { (make) in
            make.left.equalTo(icon_imageview.snp.right).offset(5)
            make.top.equalTo(self.snp.top).offset(20)
            make.size.equalTo(CGSize(width: 120, height: 25))
        }
        
        var _compony_size: CGSize = "\(compony)  ".sizeWithConstrainedWidth(screen_width - 150, font: .systemFont(ofSize: 16, weight: .medium))
        _compony_size.height += 2
        
        compony_label.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(25)
            make.top.equalTo(title_label.snp.bottom).offset(15)
            make.size.equalTo(_compony_size)
        }
        
        year_label.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-25)
            make.top.equalTo(title_label.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 90, height: 20))
        }
        
        positon_label.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(25)
            make.top.equalTo(compony_label.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: screen_width - 50, height: 25))
        }
        
        var _detail_size: CGSize = "\(job_detail)  ".sizeWithConstrainedWidth(screen_width - 50, font: .systemFont(ofSize: 15))
        _detail_size.height += 2
        if _detail_size.width != (screen_width - 50) {
            _detail_size.width = screen_width - 50
        }
        detail_label.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(25)
            make.top.equalTo(positon_label.snp.bottom).offset(15)
            make.size.equalTo(_detail_size)
        }
        
        line.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom)
            make.size.equalTo(CGSize(width: screen_width - 40, height: 1))
        }
        
    }
    
    static var default_height: CGFloat {
        return 260
    }
    
    static func getJobVoHeight(jobVoModel value: JobVosInfoModel) -> CGFloat {
        
        let screen_width: CGFloat = UIScreen.main.bounds.size.width
        var _compony_size: CGSize = "\(value.jobName ?? "-")  ".sizeWithConstrainedWidth(screen_width - 150, font: .systemFont(ofSize: 15, weight: .medium))
        _compony_size.height += 2
        
        var _detail_size: CGSize = "\(value.jobContent ?? "-")  ".sizeWithConstrainedWidth(screen_width - 50, font: .systemFont(ofSize: 15))
        _detail_size.height += 2
        
        let __height: CGFloat = 136 + _compony_size.height + _detail_size.height
        return __height
    }
    
}
