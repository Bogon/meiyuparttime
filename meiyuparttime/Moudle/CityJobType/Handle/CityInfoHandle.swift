//
//  CityInfoHandle.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/30.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation

struct CityInfoHandle {
    internal static let share = CityInfoHandle()
    private init() {}

    // MARK: - 城市是否存在

    /// 城市是否存在
    ///
    /// - Returns Bool: true: 已入库 false：未入库
    func isExist() -> Bool {
        return getCityInfoList().count == 0 ? false : true
    }

    // MARK: - 更换选中的城市

    /// 更换选中的城市
    ///
    /// - Parameter CityInfoModel: 城市数据, 必填数据
    /// - Returns nil: 无返回值
    func setSelectedCityInfo(selectedCityInfo value: CityInfoModel) {
        /// 1.将所有的设置为未选中
        CityInfoModel.helper.update(toDB: CityInfoModel.self, set: "isSelected=0", where: "isSelected=1")

        /// 2.选中，修改该条记录
        CityInfoModel.helper.update(toDB: CityInfoModel.self, set: "isSelected=1", where: "cityId=\(value.cityId)")
    }

    // MARK: - 查询所有的城市信息

    /// 查询所有的城市信息
    ///
    /// - Returns: [CityInfoModel]: 返回城市信息数组
    func getCityInfoList() -> [CityInfoModel] {
        let helper = CityInfoModel.helper
        let sql: String = "select * from CityInfoModel"
        let list: [CityInfoModel] = helper.search(withSQL: sql, to: CityInfoModel.self) as! [CityInfoModel]
        return list
    }

    // MARK: - 查询已选中的城市数据

    /// 查询已默认选中的城市数据
    ///
    /// - Returns: (Bool, CityInfoModel?): (返回当前选中的城市信息)
    func selectedCityInfo() -> CityInfoModel? {
        let helper = CityInfoModel.helper
        let sql: String = "select * from CityInfoModel where isSelected=1"
        let list: [CityInfoModel] = helper.search(withSQL: sql, to: CityInfoModel.self) as! [CityInfoModel]
        return list.count != 0 ? list.first : nil
    }

    // MARK: - 使用事务插入插入多个城市

    /// 使用事务插入插入多个城市
    ///
    /// - Parameter value: 非必填数据
    /// - Returns: 无返回值
    func insertCityList(cityInfoList value: [CityInfoModel]?) {
        guard let _city_info_list = value else { return }
        /// 使用事务插入数据
        CityInfoModel.helper.execute { (_helper) -> Bool in
            var insertSucceed: Bool = true

            for (_, _city_info) in _city_info_list.enumerated() {
                if _city_info.cityName == "北京市" { // 默认选中北京
                    _city_info.isSelected = true
                } else {
                    _city_info.isSelected = false
                }
                insertSucceed = _helper.insert(toDB: _city_info)
            }

            return insertSucceed
        }
    }

    // MARK: - 使用事务插入城市数据

    /// 使用事务插入城市数据
    ///
    /// - Parameter value: 非必填数据
    /// - Returns: 无返回值
    func insert(cityInfo value: CityInfoModel?) {
        guard let _city_info = value else { return }
        if _city_info.cityName == "北京市" { // 默认选中北京
            _city_info.isSelected = true
        } else {
            _city_info.isSelected = false
        }
        /// 使用事务插入数据
        CityInfoModel.helper.execute { (_helper) -> Bool in
            let insertSucceed = _helper.insert(toDB: _city_info)
            return insertSucceed
        }
    }
}
