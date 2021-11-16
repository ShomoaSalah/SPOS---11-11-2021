//
//  TimeClockOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/9/21.
//

import Foundation

class TimeClockOB: Codable {
    
    let clockType: Int?
    let employeeName: String?
    let clockInTime: String?
    let clockOutTime: String?
    
    enum CodingKeys: String, CodingKey {
        case clockType = "clock_type"
        case employeeName = "employee_name"
        case clockInTime = "clock_in_time"
        case clockOutTime = "clock_out_time"
    }
    
    init(clockType: Int?, employeeName: String?, clockInTime: String?, clockOutTime: String?) {
        self.clockType = clockType
        self.employeeName = employeeName
        self.clockInTime = clockInTime
        self.clockOutTime = clockOutTime
    }
}
