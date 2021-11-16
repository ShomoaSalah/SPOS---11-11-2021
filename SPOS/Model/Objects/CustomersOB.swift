//
//  CustomersOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/11/21.
//

import Foundation

class CustomersOB: Codable {
    let id: Int?
    let name, contacts: String?
    let lastVisitDate: String?

    enum CodingKeys: String, CodingKey {
        case id, name, contacts
        case lastVisitDate = "last_visit_date"
    }

    init(id: Int?, name: String?, contacts: String?, lastVisitDate: String?) {
        self.id = id
        self.name = name
        self.contacts = contacts
        self.lastVisitDate = lastVisitDate
    }
}
