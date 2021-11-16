//
//  CashManagementOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/4/21.
//

import Foundation
class CashManagementOB: Codable {
    
    let id, shiftID: Int?
    let comment: String?
    let type: Int?
    let employeeName, amountFormat, typeName, addTime: String?

    enum CodingKeys: String, CodingKey {
        case id
        case shiftID = "shift_id"
        case comment, type
        case employeeName = "employee_name"
        case amountFormat = "amount_format"
        case typeName = "type_name"
        case addTime = "add_time"
    }

    init(id: Int?, shiftID: Int?, comment: String?, type: Int?, employeeName: String?, amountFormat: String?, typeName: String?, addTime: String?) {
        self.id = id
        self.shiftID = shiftID
        self.comment = comment
        self.type = type
        self.employeeName = employeeName
        self.amountFormat = amountFormat
        self.typeName = typeName
        self.addTime = addTime
    }
}
