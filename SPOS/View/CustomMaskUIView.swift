//
//  CustomMaskUIView.swift
//  SPOS Dashboard
//
//  Created by شموع صلاح الدين on 9/23/21.
//

import Foundation
import UIKit

class CustomMaskUIView: UIView { //Gradients + Corners
    @IBInspectable
    public var startColor: UIColor = .white {
        didSet {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    public var endColor: UIColor = .white {
        didSet {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    public var isRounded: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    public var isHorizontalGradiant: Bool = false {
        didSet{
            setNeedsDisplay()
        }
    }
    
    var CornerRadius: CGFloat = 5
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [self.startColor.cgColor, self.endColor.cgColor]
        return gradientLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if (isHorizontalGradiant){
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        }else{
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        }
        gradientLayer.frame = bounds
        self.layer.cornerRadius = isRounded ? self.frame.size.height / 2 : 5
        
        self.roundCorners(radius: self.CornerRadius)
        
    }
    
    enum RoundType: String {
        case lowerRightCorner = "lowerRightCorner"
        case lowerLeftCorner = "lowerLeftCorner"
        case lowerCorner = "lowerCorner"
        case topRightCorner = "topRightCorner"
        case topLeftCorner = "topLeftCorner"
        case topCorner = "topCorner"
        case allCournerWithoutTopRightCorner = "allCournerWithoutTopRightCorner"
        case allCournerWithoutTopLeftCorner = "allCournerWithoutTopLeftCorner"
        case allCournerWithoutBottomRightCorner = "allCournerWithoutBottomRightCorner"
        case allCourner = "allCourner"
        case allCournerWithoutBottomleftCorner = "allCournerWithoutBottomleftCorner"
        case topLeftCornerAndLowerRightCorner = "topLeftCornerAndLowerRightCorner"
        case topRightCornerAndLowerLeftCorner = "topRightCornerAndLowerLeftCorner"
        case topRightCornerAndlowerRightCorner = "topRightCornerAndlowerRightCorner"
        case topLeftCornerAndlowerLeftCorner = "topLeftCornerAndlowerLeftCorner"
        case none = "None"
    }
    
    var roundshapeType: RoundType = .allCourner

    func roundCorners(radius: CGFloat) {
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = radius
            switch roundshapeType  {
            case .lowerRightCorner :
                self.layer.maskedCorners = [.layerMaxXMaxYCorner]
                break
            case .lowerLeftCorner :
                self.layer.maskedCorners = [.layerMinXMaxYCorner]
                break
            case .lowerCorner :
                self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                break
            case .topRightCorner :
                self.layer.maskedCorners = [.layerMaxXMinYCorner]
                break
            case .topLeftCorner :
                self.layer.maskedCorners = [.layerMinXMinYCorner]
                break
            case .topCorner :
                self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                break
            case .allCournerWithoutTopRightCorner:
                self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
                break
            case .allCournerWithoutTopLeftCorner:
                self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
                break
            case .allCournerWithoutBottomRightCorner:
                self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner]
                break
            case .allCournerWithoutBottomleftCorner:
                self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner]
                break
            case .topLeftCornerAndLowerRightCorner:
                self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
                break
            case .topRightCornerAndLowerLeftCorner:
                self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
                break
            case .topRightCornerAndlowerRightCorner:
                self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                break
            case .topLeftCornerAndlowerLeftCorner:
                self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
                break
            case .none:
                break
            case .allCourner:
                self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
                break
            }
        } else {
            switch roundshapeType  {
            case .lowerRightCorner :
                self.roundLowerVersion(corners: [.bottomRight], radius: radius)
                break
            case .lowerLeftCorner :
                self.roundLowerVersion(corners: [.bottomLeft], radius: radius)
                break
            case .lowerCorner :
                self.roundLowerVersion(corners: [.bottomLeft, .bottomRight], radius: radius)
                break
            case .topRightCorner :
                self.roundLowerVersion(corners: [.topRight], radius: radius)
                break
            case .topLeftCorner :
                self.roundLowerVersion(corners: [.topLeft], radius: radius)
                break
            case .topCorner :
                self.roundLowerVersion(corners: [.topRight, .topLeft], radius: radius)
                break
            case .allCournerWithoutTopRightCorner:
                self.roundLowerVersion(corners: [.bottomLeft, .bottomRight, .topLeft], radius: radius)
                break
            case .allCournerWithoutTopLeftCorner:
                self.roundLowerVersion(corners: [.bottomLeft, .bottomRight, .topRight], radius: radius)
                break
            case .allCournerWithoutBottomRightCorner:
                self.roundLowerVersion(corners: [.topRight, .topLeft, .bottomLeft], radius: radius)
                break
            case .allCournerWithoutBottomleftCorner:
                self.roundLowerVersion(corners: [.topRight, .topLeft, .bottomRight], radius: radius)
                break
            case .none:
                break
            case .topLeftCornerAndLowerRightCorner:
                self.roundLowerVersion(corners: [.topLeft, .bottomRight], radius: radius)
                break
            case .topRightCornerAndLowerLeftCorner:
                self.roundLowerVersion(corners: [.topRight, .bottomLeft], radius: radius)
                break
            case .topRightCornerAndlowerRightCorner:
                self.roundLowerVersion(corners: [.topRight, .bottomRight], radius: radius)
                break
            case .topLeftCornerAndlowerLeftCorner:
                self.roundLowerVersion(corners: [.topLeft, .bottomLeft], radius: radius)
                break
            case .allCourner:
                self.roundLowerVersion(corners: [.topLeft, .bottomLeft, .topRight, .bottomRight], radius: radius)
                break
            }
        }
        self.clipsToBounds = true
    }
    
    func roundLowerVersion(corners: UIRectCorner, radius: CGFloat) {
        let bounds = self.bounds
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
}
