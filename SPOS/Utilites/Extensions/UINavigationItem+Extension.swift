//
//  UINavigationItem+Extension.swift
//  Provider
//
//  Created by شموع صلاح الدين on 3/16/21.
//

import Foundation
import UIKit

extension UINavigationItem {
    func hideBackWord()  {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.backBarButtonItem = backItem
    }
}

