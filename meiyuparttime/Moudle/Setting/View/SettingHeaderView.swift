//
//  SettingHeaderView.swift
//  beeparttime
//
//  Created by Senyas on 2020/8/1.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import UIKit

fileprivate let ScreenWidth: CGFloat = UIScreen.main.bounds.width
fileprivate let ScreenHeight: CGFloat = UIScreen.main.bounds.height

protocol SettingHeaderLoginDelegate: NSObjectProtocol {
    func login_sign_up()
}


class SettingHeaderView: UIView {

    weak var delegate: SettingHeaderLoginDelegate?
    
    @IBOutlet weak var setting_head_avatar_imageview: UIImageView!
    @IBOutlet weak var setting_nickname_label: UILabel!
    @IBOutlet weak var setting_h_login_button: UIButton!
    @IBOutlet weak var setting_h_title_label: UILabel!
    
    var nickname: String = "awdiq23123" {
        didSet {
            setting_nickname_label.text = nickname
        }
    }
    
    var is_login: Bool = false {
        didSet {
            if is_login {
                setting_h_login_button.isHidden = true
                setting_h_title_label.isHidden = true
                setting_nickname_label.isHidden = false
                
                setting_head_avatar_imageview.image = Asset.avatarLogin.image
            } else {
                setting_h_login_button.isHidden = false
                setting_h_title_label.isHidden = false
                setting_nickname_label.isHidden = true
                
                setting_head_avatar_imageview.image = Asset.avatarDefault.image
            }
        }
    }
    
    
    // MARK:- 创建视图
    class func instance() -> SettingHeaderView? {
        let nibView = Bundle.main.loadNibNamed("SettingHeaderView", owner: nil, options: nil)
        if let view = nibView?.first as? SettingHeaderView {
            view.backgroundColor = .clear
            return view
        }
        return nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.masksToBounds = true
        clipsToBounds = true
        
        // 默认设置
        setting_h_login_button.isHidden = false
        setting_h_title_label.isHidden = false
        setting_nickname_label.isHidden = true
        setting_head_avatar_imageview.image = Asset.avatarDefault.image
        
        setting_head_avatar_imageview.layer.masksToBounds = true
        setting_head_avatar_imageview.layer.cornerRadius = 40
        setting_head_avatar_imageview.layer.borderColor = UIColor(hex: "f2f2f2").cgColor
        setting_head_avatar_imageview.layer.borderWidth = 1.5
        
    }
    
    @IBAction func loginSignUpAction(_ sender: UIButton) {
        delegate?.login_sign_up()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setting_head_avatar_imageview.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).offset(15)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        setting_nickname_label.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(setting_head_avatar_imageview.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: ScreenWidth - 30 - 50 - 15, height: 20))
        }
        
        setting_h_login_button.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(setting_head_avatar_imageview.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 100, height: 40))
        }
        
        setting_h_title_label.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(setting_h_login_button.snp.bottom)
            make.size.equalTo(CGSize(width: ScreenWidth - 30 - 50 - 15, height: 18))
        }
    }
    
    static var layoutHeight: CGFloat {
       
        let contentHeight: CGFloat = 210
        return contentHeight
    }

}

