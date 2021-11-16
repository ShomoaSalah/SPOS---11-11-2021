//
//  ColorsOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/25/21.
//

import Foundation


class ColorsOB: Codable {
    let id: Int?
    let color: String?

    init(id: Int?, color: String?) {
        self.id = id
        self.color = color
    }
}
