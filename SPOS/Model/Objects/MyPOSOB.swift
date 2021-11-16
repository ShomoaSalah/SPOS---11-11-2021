//
//  MyPOSOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/24/21.
//

import Foundation

class MyPOSOB: Codable {
    
    let id, ownerID: Int?
    let name, isCompleted: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case name
        case isCompleted = "is_completed"
    }
    
    init(id: Int?, ownerID: Int?, name: String?, isCompleted: String?) {
        self.id = id
        self.ownerID = ownerID
        self.name = name
        self.isCompleted = isCompleted
    }
}
