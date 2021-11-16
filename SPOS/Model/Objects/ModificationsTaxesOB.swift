//
//  ModificationsTaxesOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/28/21.
//

import Foundation

class ModificationsTaxesOB: Codable {

    let modifications: [Modification]?
    let taxes: [Tax]?

    init(modifications: [Modification]?, taxes: [Tax]?) {
        self.modifications = modifications
        self.taxes = taxes
    }
}


// MARK: - Modification
class Modification: Codable {
    let id: Int?
    let name: String?
    let userID: Int?
    let optionsNameString: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case userID = "user_id"
        case optionsNameString = "options_name_string"
    }

    init(id: Int?, name: String?, userID: Int?, optionsNameString: String?) {
        self.id = id
        self.name = name
        self.userID = userID
        self.optionsNameString = optionsNameString
    }
}

// MARK: - Tax
class Tax: Codable {
    let id, userID: Int?
    let name: String?
    let tax: Int?
    let isChecked: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case name, tax
        case isChecked = "is_checked"
    }

    init(id: Int?, userID: Int?, name: String?, tax: Int?, isChecked: Bool?) {
        self.id = id
        self.userID = userID
        self.name = name
        self.tax = tax
        self.isChecked = isChecked
    }
}

