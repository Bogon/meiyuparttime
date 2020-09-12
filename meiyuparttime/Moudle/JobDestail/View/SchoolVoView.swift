//
//  SchoolVoView.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/6.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import UIKit

class SchoolVoView: UIView {

    @IBOutlet weak var icon_imageview: UIImageView!
    @IBOutlet weak var title_label: UILabel!
    @IBOutlet weak var school_label: UILabel!
    @IBOutlet weak var year_label: UILabel!
    @IBOutlet weak var profession_label: UILabel!
    @IBOutlet weak var line: UIView!
    
    /// 学校名称
    var school_name: String = "" {
        didSet {
            var _school_name: String = school_name
            if school_name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).length == 0 {
                _school_name = "无"
            }
            school_label.text = _school_name
        }
    }
    
    /// 入学年限
    var year: String = "" {
        didSet {
            var _year: String = year
            if year.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).length == 0 {
               _year = "无"
            }
            year_label.text = _year
        }
    }
    
    /// 专业
    var profession: String = "" {
        didSet {
            var _profession: String = profession
            if year.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).length == 0 {
               _profession = "无"
            }
            profession_label.text = _profession
        }
    }
    
    // MARK:- 创建视图
    class func instance() -> SchoolVoView? {
        let nibView = Bundle.main.loadNibNamed("SchoolVoView", owner: nil, options: nil)
        if let view = nibView?.first as? SchoolVoView {
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
        
        icon_imageview.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(25)
            make.top.equalTo(self.snp.top).offset(20)
            make.size.equalTo(CGSize(width: 19, height: 19))
        }
        
        title_label.snp.makeConstraints { (make) in
            make.left.equalTo(icon_imageview.snp.right).offset(5)
            make.top.equalTo(self.snp.top).offset(20)
            make.size.equalTo(CGSize(width: 120, height: 25))
        }
        
        school_label.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(25)
            make.top.equalTo(title_label.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 180, height: 25))
        }
        
        year_label.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-25)
            make.top.equalTo(school_label.snp.top)
            make.size.equalTo(CGSize(width: 180, height: 25))
        }
        
        profession_label.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(25)
            make.top.equalTo(school_label.snp.bottom).offset(5)
            make.size.equalTo(CGSize(width: 200, height: 25))
        }
       
        let screen_width: CGFloat = UIScreen.main.bounds.size.width
        
        line.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom)
            make.size.equalTo(CGSize(width: screen_width - 40, height: 1))
        }
        
    }
    
    static var _height: CGFloat {
        return 136
    }
}
