//
//  CategorieOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/25/21.
//

import Foundation

class CategorieOB: Codable {

    let name: String?
    let colorID, userID, id, itemsCount: Int?
    let kitchenPrintersExists: Bool?
    let colorName: String?
    let image: String?
    let priceState, type, objectType: String?

    
    enum CodingKeys: String, CodingKey {
        case name
        case colorID = "color_id"
        case userID = "user_id"
        case id
        case itemsCount = "items_count"
        case kitchenPrintersExists = "kitchen_printers_exists"
        case colorName = "color_name"
        case image
        case priceState = "price_state"
        case type
        case objectType = "object_type"
    }

    init(name: String?, colorID: Int?, userID: Int?, id: Int?, itemsCount: Int?, kitchenPrintersExists: Bool?, colorName: String?, image: String?, priceState: String?, type: String?, objectType: String?) {
        self.name = name
        self.colorID = colorID
        self.userID = userID
        self.id = id
        self.itemsCount = itemsCount
        self.kitchenPrintersExists = kitchenPrintersExists
        self.colorName = colorName
        
        self.image = image
        self.priceState = priceState
        self.type = type
        self.objectType = objectType
        
    }
}
