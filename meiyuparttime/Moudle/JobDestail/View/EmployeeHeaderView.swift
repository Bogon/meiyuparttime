//
//  EmployeeHeaderView.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/5.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import UIKit

class EmployeeHeaderView: UIView {

    @IBOutlet weak var avatar_imageview: UIImageView!
    @IBOutlet weak var user_content_view: UIView!
    @IBOutlet weak var nickname_label: UILabel!
    @IBOutlet weak var id_label: UILabel!
    @IBOutlet weak var job_status_view: UIView!
    @IBOutlet weak var job_status_label: UILabel!
    @IBOutlet weak var addr_status_view: UIView!
    @IBOutlet weak var addr_label: UILabel!
    @IBOutlet weak var age_label: UILabel!
    @IBOutlet weak var degree_label: UILabel!
    @IBOutlet weak var job_time_label: UILabel!
    @IBOutlet weak var line: UIView!
    
    
    /// 个人照片
    var avatar_url: String = "" {
        didSet {
            avatar_imageview.kf.setImage(with: URL(string: avatar_url))
        }
    }
    
    /// 昵称
    var nickname: String = "" {
        didSet {
            nickname_label.text = nickname
        }
    }
    
    /// ID
    var job_id: String = "ID：YZ000000001" {
        didSet {
            id_label.text = job_id
        }
    }
    
    /// 工作状态
    var job_status: Int = 0 {
        didSet {
            var _status: String = "目前离职，正在找工作"
            switch job_status {
                case 1:
                    _status = "目前离职，正在找工作"
                
                case 2:
                    _status = "目前离职，暂不找工作"
                case 3:
                    _status = "目前在职，正在找工作"
                
                case 4:
                    _status = "目前在职，暂不找工作"
                
                default:
                    _status = "目前离职，正在找工作"
            }
            job_status_label.text = _status
        }
    }
    
    /// 居住地
    var address: String = "" {
        didSet {
            var _address: String = address
            if address.length == 0 {
                
                let cityModel: CityInfoModel = CityInfoHandle.share.selectedCityInfo()!
                _address = cityModel.cityName ?? "北京市"
            }
            addr_label.text = _address
        }
    }
    
    /// 年龄
    var age: String = "25" {
        didSet {
            var _age: String = age
            if age.length == 0 {
                _age = "25"
            }
            age_label.text = "\(_age)岁"
        }
    }
    
    /// 学历
    var degree: String = "本科" {
        didSet {
            var _degree: String = degree
            if _degree.length == 0 {
                _degree = "本科"
            }
            degree_label.text = _degree
        }
    }
    
    /// 工作年限
    var job_time: String = "5年" {
        didSet {
            var _job_year: String = job_time
            if _job_year.length == 0 {
                _job_year = "5年"
            }
            job_time_label.text = _job_year
        }
    }
    
    // MARK:- 创建视图
    class func instance() -> EmployeeHeaderView? {
        let nibView = Bundle.main.loadNibNamed("EmployeeHeaderView", owner: nil, options: nil)
        if let view = nibView?.first as? EmployeeHeaderView {
            view.backgroundColor = .clear
            return view
        }
        return nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        job_status_view.layer.masksToBounds = true
        job_status_view.layer.cornerRadius = 2.5
        
        addr_status_view.layer.masksToBounds = true
        addr_status_view.layer.cornerRadius = 2.5
        
        age_label.layer.masksToBounds = true
        age_label.layer.cornerRadius = 12.5
        
        degree_label.layer.masksToBounds = true
        degree_label.layer.cornerRadius = 12.5
        
        job_time_label.layer.masksToBounds = true
        job_time_label.layer.cornerRadius = 12.5
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let screen_width: CGFloat = UIScreen.main.bounds.size.width
        
        avatar_imageview.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.snp.top)
            make.height.equalTo(440)
        }
        
        let content_height: CGFloat = 175
        user_content_view.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(avatar_imageview.snp.bottom)
            make.height.equalTo(content_height)
        }
        
        nickname_label.snp.makeConstraints { (make) in
            make.left.equalTo(user_content_view.snp.left).offset(25)
            make.top.equalTo(user_content_view.snp.top).offset(20)
            make.size.equalTo(CGSize(width: screen_width - 40, height: 30))
        }
        
        id_label.snp.makeConstraints { (make) in
            make.left.equalTo(user_content_view.snp.left).offset(25)
            make.top.equalTo(nickname_label.snp.bottom).offset(5)
            make.size.equalTo(CGSize(width: screen_width - 40, height: 20))
        }
        
        job_status_view.snp.makeConstraints { (make) in
            make.left.equalTo(user_content_view.snp.left).offset(25)
            make.top.equalTo(id_label.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 5, height: 5))
        }
        
        job_status_label.snp.makeConstraints { (make) in
            make.left.equalTo(job_status_view.snp.right).offset(10)
            make.centerY.equalTo(job_status_view.snp.centerY)
            make.size.equalTo(CGSize(width: screen_width - 40, height: 20))
        }
        
        addr_status_view.snp.makeConstraints { (make) in
            make.left.equalTo(user_content_view.snp.left).offset(25)
            make.top.equalTo(job_status_view.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 5, height: 5))
        }
        
        addr_label.snp.makeConstraints { (make) in
            make.left.equalTo(addr_status_view.snp.right).offset(10)
            make.centerY.equalTo(addr_status_view.snp.centerY)
            make.size.equalTo(CGSize(width: screen_width - 40, height: 20))
        }
        
        age_label.snp.makeConstraints { (make) in
            make.left.equalTo(user_content_view.snp.left).offset(25)
            make.top.equalTo(addr_label.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 60, height: 25))
        }
        
        degree_label.snp.makeConstraints { (make) in
            make.left.equalTo(age_label.snp.right).offset(10)
            make.centerY.equalTo(age_label.snp.centerY)
            make.size.equalTo(CGSize(width: 60, height: 25))
        }
        
        job_time_label.snp.makeConstraints { (make) in
            make.left.equalTo(degree_label.snp.right).offset(10)
            make.centerY.equalTo(degree_label.snp.centerY)
            make.size.equalTo(CGSize(width: 60, height: 25))
        }
        
        line.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom)
            make.size.equalTo(CGSize(width: screen_width - 40, height: 1))
        }
    }
    
    static var _height: CGFloat {
        return 631
    }
    
}
