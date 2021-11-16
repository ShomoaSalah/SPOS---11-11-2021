//
//  MyStoresOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/24/21.
//

import Foundation

class MyStoresOB: Codable {
    let id, userID: Int?
    let name: String?
    let address, phone, datumDescription: String?
    let posCount: Int?
    let pivot: Pivot?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case name, address, phone
        case datumDescription = "description"
        case posCount = "POS_count"
        case pivot
    }

    init(id: Int?, userID: Int?, name: String?, address: String?, phone: String?, datumDescription: String?, posCount: Int?, pivot: Pivot?) {
        self.id = id
        self.userID = userID
        self.name = name
        self.address = address
        self.phone = phone
        self.datumDescription = datumDescription
        self.posCount = posCount
        self.pivot = pivot
    }
}

class Pivot: Codable {
    let userID, storeID: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case storeID = "store_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(userID: Int?, storeID: Int?, createdAt: String?, updatedAt: String?) {
        self.userID = userID
        self.storeID = storeID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
