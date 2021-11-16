//
//  UserOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/24/21.
//

import Foundation

class UserOB: Codable {
 
    let id, ownerID, storeID: Int?
    let name: String?
    let isScan: Int?
    let wallet: Int?
    let mobile: String?
    let countryID: Int?
    let email, isCompleted: String?
    let agreementState: Bool?
    let pinCode: String?
    let backOffice: Int?
    let status: Bool?
    let token, role, nameOfStore, countryName: String?
    let backOfficeURL: String?
    let posID: Int?
    let pinCodeState: Int?
    let posName: String?
    let isShift: Bool?
    let isShiftMenu: Bool?
    let employeeName: String?
    let shiftID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case storeID = "store_id"
        case posName = "pos_name"
        case isShift = "is_shift"
        case shiftID = "shift_id"
        case isShiftMenu = "is_shift_menu"
        case pinCodeState = "pin_code_state"
        case name, wallet, mobile
        case countryID = "country_id"
        case email
        case isCompleted = "is_completed"
        case agreementState = "agreement_state"
        case pinCode = "pin_code"
        case backOffice = "back_office"
        case status, token, role
        case isScan = "is_scan"
        case nameOfStore = "name_of_store"
        case countryName = "country_name"
        case backOfficeURL = "back_office_url"
        case posID = "pos_id"
        case employeeName = "employee_name"
    }

    init(id: Int?, ownerID: Int?, storeID: Int?, name: String?, wallet: Int?, mobile: String?, countryID: Int?, email: String?, isCompleted: String?, agreementState: Bool?, pinCode: String?, backOffice: Int?, status: Bool?, token: String?, role: String?, nameOfStore: String?, countryName: String?, backOfficeURL: String?, posID: Int?, isScan: Int?, pinCodeState: Int?,
         posName: String?, isShift: Bool?, isShiftMenu: Bool?, employeeName: String?, shiftID: Int?) {
        self.id = id
        self.ownerID = ownerID
        self.posName = posName
        self.storeID = storeID
        self.name = name
        self.wallet = wallet
        self.mobile = mobile
        self.shiftID = shiftID
        self.pinCodeState = pinCodeState
        self.countryID = countryID
        self.email = email
        self.isCompleted = isCompleted
        self.agreementState = agreementState
        self.pinCode = pinCode
        self.backOffice = backOffice
        self.status = status
        self.token = token
        self.role = role
        self.nameOfStore = nameOfStore
        self.countryName = countryName
        self.backOfficeURL = backOfficeURL
        self.posID = posID
        self.isScan = isScan
        self.isShift = isShift
        self.isShiftMenu = isShiftMenu
        self.employeeName = employeeName
    }
}
