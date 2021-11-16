//
//  PinCodeOB.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/2/21.
//

import Foundation

class PinCodeOB: Codable {
    
    let pinCodes: [String]?
    let trackTimeState: Bool?

    enum CodingKeys: String, CodingKey {
        case pinCodes = "pin_codes"
        case trackTimeState = "track_time_state "
    }

    init(pinCodes: [String]?, trackTimeState: Bool?) {
        self.pinCodes = pinCodes
        self.trackTimeState = trackTimeState
    }
}
