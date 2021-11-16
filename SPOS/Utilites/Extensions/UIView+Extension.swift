//
//  UIView+Extension.swift
//  Provider
//
//  Created by شموع صلاح الدين on 3/16/21.
//

import Foundation
import UIKit

extension UIView {
    
  
    
    @IBInspectable var cornerRadius: CGFloat {
        set{
            self.layer.cornerRadius = newValue
        }
        
        get {
            return self.layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        set {
            self.layer.borderColor = newValue.cgColor
        }
        get {
            
            
            return  UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
        }
    }
    
    @IBInspectable var setBorder: CGFloat {
        set{
            self.layer.borderWidth = newValue
        }
        
        get {
            return self.layer.borderWidth
        }
    }
    
    
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            
            layer.shadowRadius = newValue
        }
    }
    
    
    @IBInspectable
    var shadowOffset : CGSize{
        
        get{
            return layer.shadowOffset
        }set{
            
            layer.shadowOffset = newValue
        }
    }
    
    
    @IBInspectable
    var shadowColor : UIColor{
        get{
            return UIColor.init(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable
    var shadowOpacity : Float {
        
        get{
            return layer.shadowOpacity
        }
        set {
            
            layer.shadowOpacity = newValue
            
        }
    }
    
    
    func roundCorners(cornerRadius: Double) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func setRounded() {
        let radius = self.frame.height / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    func setRounded(radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
 
    
    func setBorderGray() {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
    }
    func setBorder(width:CGFloat,color:CGColor) {
        self.layer.borderColor = color
        self.layer.borderWidth = width
    }

    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    
    /// Width of view.
    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    /// Height of view.
    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    
    
}



extension UIView {
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        }
        return self.topAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.leftAnchor
        }
        return self.leftAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.rightAnchor
        }
        return self.rightAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        }
        return self.bottomAnchor
    }
    
}
