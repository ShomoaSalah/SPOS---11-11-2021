//
//  Date+Extension.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/28/21.
//

import Foundation

extension Date {
    //Helpful Link:
    //https://stackoverflow.com/a/33343958
    
    func getYYYYMMDD() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        dateFormatter.locale = Locale(identifier: "en_us")
        let date = dateFormatter.date(from: self.description)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date!)
    }
    
    func getYYYYMMDD2() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss z"
        dateFormatter.locale = Locale(identifier: "en_us")
        let date = dateFormatter.date(from: self.description)
        dateFormatter.dateFormat = "HH:mm z"
        return dateFormatter.string(from: date!)
    }
    
    
    func getTimeOnly() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        dateFormatter.locale = Locale(identifier: "en_us")
        let date = dateFormatter.date(from: self.description)
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: date!)
    }
    
    var totalSeconds:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())/1000
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}

