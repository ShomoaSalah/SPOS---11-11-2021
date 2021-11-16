//
//  LoadingButton.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/24/21.
//

import Foundation
import UIKit

class LoadingButton {
    
    
    static func startLoading(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.startAnimating()
    }
    
    static func stopLoading(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.stopAnimating()
    }
    
    
}

