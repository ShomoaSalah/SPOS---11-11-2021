//
//  Notification+Extension.swift
//  AqarAfterDeletetion
//
//  Created by شموع صلاح الدين on 8/16/21.
//

import Foundation
import UIKit

extension Notification.Name {
    
    static let reloadCategories = Notification.Name("reloadCategories")
    static let reloadCategoriesInHome = Notification.Name("reloadCategoriesInHome")
    static let reloadDiscounts = Notification.Name("reloadDiscounts")
    static let reloadItems = Notification.Name("reloadItems")
   
    
    static let openPinCodeVC = Notification.Name("openPinCodeVC")
    
    static let reloadShift = Notification.Name("reloadShift")
    
    static let selectAll = Notification.Name("selectAll")
    static let openShift = Notification.Name("openShift")
    static let closeShift = Notification.Name("closeShift")
    static let customTicket = Notification.Name("customTicket")
    
    
    static let openTicket = Notification.Name("openTicket")
    static let deleteTicket = Notification.Name("deleteTicket")
}

