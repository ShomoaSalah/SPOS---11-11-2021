//
//  UIButton+Extension.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/5/21.
//

import Foundation
import UIKit

extension UIButton {
    
    // Set Gradient To Any View
    typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)
    
    enum GradientOrientation {
        case topRightBottomLeft
        case topLeftBottomRight
        case horizontal
        case vertical
        
        var startPoint : CGPoint {
            get { return points.startPoint }
        }
        
        var endPoint : CGPoint {
            get { return points.endPoint }
        }
        
        var points : GradientPoints {
            get {
                switch(self) {
                case .topRightBottomLeft:
                    return (CGPoint.init(x: 0.0,y: 1.0), CGPoint.init(x: 1.0,y: 0.0))
                case .topLeftBottomRight:
                    return (CGPoint.init(x: 0.0,y: 0.0), CGPoint.init(x: 1,y: 1))
                case .horizontal:
                    return (CGPoint.init(x: 0.0,y: 0.5), CGPoint.init(x: 1.0,y: 0.5))
                case .vertical:
                    return (CGPoint.init(x: 0.0,y: 0.0), CGPoint.init(x: 0.0,y: 1.0))
                }
            }
        }
    }
    
    
    func applyGradientUIButton(colours: [UIColor], gradientOrientation orientation: GradientOrientation) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        gradient.cornerRadius = 5
        self.layer.insertSublayer(gradient, at: 0)
    }
}
