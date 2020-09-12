//
//  JobTypeVosInfoHandle.swift
//  meiyuparttime
//
//  Created by Senyas on 2020/8/30.
//  Copyright © 2020 Senyas Technology Co., Ltd. All rights reserved.
//

import Foundation

struct JobTypeVosInfoHandle {
    
    static internal let share = JobTypeVosInfoHandle()
    private init() {}
    
    //MARK: - 职位是否已入库
    /// 职位是否已入库
    ///
    /// - Returns Bool: true: 已入库 false：未入库
    func isExist() -> Bool {
        return getJobTypeVosInfoList().count == 0 ? false : true
    }
    
    //MARK: - 更换选中的职位类型
    /// 更换选中的职位类型
    ///
    /// - Parameter JobTypeVosInfoModel: 职位类型信息, 必填数据
    /// - Returns nil: 无返回值
    func setSelectedJobTypeVosInfo(selectedInfo value: JobTypeVosInfoModel) {
        /// 1.将所有的设置为未选中
        CityInfoModel.helper.update(toDB: JobTypeVosInfoModel.self, set: "isSelected=0", where: "isSelected=1")
        
        /// 2.选中，修改该条记录
        JobTypeVosInfoModel.helper.update(toDB: JobTypeVosInfoModel.self, set: "isSelected=1", where: "jobId=\(value.jobId)")
    }
    
    //MARK: - 查询所有的职位类型数据
    /// 查询所有的职位类型数据
    ///
    /// - Returns: [JobTypeVosInfoModel]: 返回城市信息数组
    func getJobTypeVosInfoList() -> [JobTypeVosInfoModel] {
        let helper = JobTypeVosInfoModel.helper
        let sql: String = "select * from JobTypeVosInfoModel"
        let list: [JobTypeVosInfoModel] = helper.search(withSQL: sql, to: JobTypeVosInfoModel.self) as! [JobTypeVosInfoModel]
        return list
    }
    
    //MARK: - 查询已选中的职位类型数据
    /// 查询已默认选中的查询已选中的职位类型数据
    ///
    /// - Returns: (Bool, CityInfoModel?): (返回当前选中的城市信息)
    func selectedJobTypeVosInfo() -> JobTypeVosInfoModel? {
        let helper = JobTypeVosInfoModel.helper
        let sql: String = "select * from JobTypeVosInfoModel where isSelected=1"
        let list: [JobTypeVosInfoModel] = helper.search(withSQL: sql, to: JobTypeVosInfoModel.self) as! [JobTypeVosInfoModel]
        return list.count != 0 ? list.first : nil
    }
    
    //MARK: - 使用事务插入插入多个职位类型数据
    /// 使用事务插入插入多个职位类型数据
    ///
    /// - Parameter value: 非必填数据
    /// - Returns: 无返回值
    func insertCityList(jobTypeVosInfoList value: [JobTypeVosInfoModel]?) {
        guard let _job_type_vos_info_list = value else { return }
        /// 使用事务插入数据
        JobTypeVosInfoModel.helper.execute { (_helper) -> Bool in
            var insertSucceed: Bool = true
            
            for (_, job_type_vos_info) in _job_type_vos_info_list.enumerated() {
                insertSucceed = _helper.insert(toDB: job_type_vos_info)
            }
            
            return insertSucceed
        }
    }
    
    //MARK: - 使用事务插入职位类型数据
    /// 使用事务插入职位类型数据
    ///
    /// - Parameter value: 非必填数据
    /// - Returns: 无返回值
    func insert(jobTypeVosInfo value: JobTypeVosInfoModel?) {
        guard let job_type_vos_info = value else { return }
        /// 使用事务插入数据
        JobTypeVosInfoModel.helper.execute { (_helper) -> Bool in
            let insertSucceed = _helper.insert(toDB: job_type_vos_info)
            return insertSucceed
        }
    }
    
}
