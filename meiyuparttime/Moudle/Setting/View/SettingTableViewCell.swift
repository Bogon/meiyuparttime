//
//  SettingTableViewCell.swift
//  beeparttime
//
//  Created by Senyas on 2020/8/1.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import UIKit
import Reusable

enum SettingType {
    case protocols
    case version
    case clear
    
}

fileprivate let ScreenWidth: CGFloat = UIScreen.main.bounds.width
fileprivate let ScreenHeight: CGFloat = UIScreen.main.bounds.height

class SettingTableViewCell: UITableViewCell, NibReusable {

    static var reuseIdentifier: String { return "SettingTableViewCell" }

    @IBOutlet weak var stc_icon_imageview: UIImageView!
    @IBOutlet weak var stc_title_label: UILabel!
    @IBOutlet weak var stc_subtitle_label: UILabel!
    @IBOutlet weak var stc_arrow_imageview: UIImageView!
    @IBOutlet weak var line: UIView!
    
    // 计算属性
    var type: SettingType = .clear {
        didSet{
            
            switch type {
                
            case .protocols:
                stc_icon_imageview.image = Asset.protocol.image
                stc_title_label.text = "用户协议"
                line.isHidden = true
                stc_subtitle_label.isHidden = true
                
            case .version:
                stc_icon_imageview.image = Asset.versionUpdate.image
                stc_title_label.text = "检查版本"
                line.isHidden = true
                stc_subtitle_label.isHidden = false
                ///app 版本号
                let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                stc_subtitle_label.text = "版本：v\(appVersion ?? "1.0")"
                
            case .clear:
                stc_icon_imageview.image = Asset.clearCache.image
                stc_title_label.text = "清理缓存"
                line.isHidden = true
                stc_subtitle_label.isHidden = false
                stc_subtitle_label.text = "缓存：\(ClearCache.share.cacheSize)"
            }
        }
    }
    
    var is_clear: Bool = false {
        
        didSet {
            if type == .clear {
                stc_subtitle_label.isHidden = false
                stc_subtitle_label.text = "缓存：\(ClearCache.share.cacheSize)"
            } else {
                stc_subtitle_label.isHidden = false
            }
            
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        line.isHidden = true
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        stc_icon_imageview.snp.remakeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(contentView.snp.left).offset(15)
            make.size.equalTo(CGSize(width: 18, height: 18))
        }
        
        stc_title_label.snp.remakeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(stc_icon_imageview.snp.right).offset(15)
            make.size.equalTo(CGSize(width: 80, height: 18))
        }
        
        stc_arrow_imageview.snp.remakeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(contentView.snp.right).offset(-15)
            make.size.equalTo(CGSize(width: 12, height: 12))
        }
        
        stc_subtitle_label.snp.remakeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(stc_arrow_imageview.snp.left).offset(-5)
            make.size.equalTo(CGSize(width: 100, height: 14))
        }
        
        line.snp.remakeConstraints { (make) in
            make.bottom.equalTo(contentView.snp.bottom)
            make.right.equalTo(contentView.snp.right)
            make.left.equalTo(stc_title_label.snp.left)
            make.height.equalTo(1)
        }
    }
        
    
    static var layoutHeight: CGFloat {
       
        let contentHeight: CGFloat = 50
        return contentHeight
    }
    
}
