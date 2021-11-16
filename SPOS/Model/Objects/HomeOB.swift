//
//  HomeOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/3/21.
//

import Foundation

class HomeOB: Codable {
    
    let count: Int?
    let charge: String?
    let items: [ItemsOB]?
    let categories: [CategorieOB]?
    let discounts: [DiscountsOB]?
    
    init(count: Int?, charge: String?, items: [ItemsOB]?, categories: [CategorieOB]?, discounts: [DiscountsOB]?) {
        self.count = count
        self.charge = charge
        self.items = items
        self.categories = categories
        self.discounts = discounts
    }
}



class SearchHomeOB: Codable {
    let id: Int?
    let name: String?
    let colorID: Int?
    let colorName, image: String?
    let priceState, type, objectType: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case colorID = "color_id"
        case colorName = "color_name"
        case image
        case priceState = "price_state"
        case type
        case objectType = "object_type"
    }

    init(id: Int?, name: String?, colorID: Int?, colorName: String?, image: String?, priceState: String?, type: String?, objectType: String?) {
        self.id = id
        self.name = name
        self.colorID = colorID
        self.colorName = colorName
        self.image = image
        self.priceState = priceState
        self.type = type
        self.objectType = objectType
    }
}

