//
//  CountriesOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/24/21.
//

import Foundation

class CountriesOB: Codable {
    let id: Int?
    let image: String?
    let code: String?
    let status: Int?
    let name: String?

    init(id: Int?, image: String?, code: String?, status: Int?, name: String?) {
        self.id = id
        self.image = image
        self.code = code
        self.status = status
        self.name = name
    }
}
