//
//  UINavigationController+Extension.swift
//  AqarAfterDeletetion
//
//  Created by شموع صلاح الدين on 8/16/21.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
    
    
}

