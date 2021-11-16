//
//  PhoneNumberValidation.swift
//  Provider
//
//  Created by شموع صلاح الدين on 6/3/21.
//

import Foundation

class PhoneNumberValidation {
    
    static func isValidMobileNumber(mobile: String) -> String {
        
        if mobile.length != 9 && mobile.length != 10 {
            return ""
        } else if mobile.length == 10 && mobile.starts(with: "0") {
            print("PhoneNumberValidation \(String(mobile.dropFirst()))")
            return String(mobile.dropFirst())
        } else if mobile.length == 10 && !mobile.starts(with: "0") {
            return ""
        }
        
        return mobile
    }
    
    
    
}
