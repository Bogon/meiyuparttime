//
//  UpdateInfoResponseModel.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/9/15.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

class UpdateInfoResponseModel: NSObject, Mappable {

    var isenable: Bool?
    var opencontent: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        isenable            <- map["isenable"]
        opencontent         <- map["opencontent"]
    }
    
    override init() {
        super.init()
    }

}
