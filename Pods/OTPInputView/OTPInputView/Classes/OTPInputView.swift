//
//  OTPInputView.swift
//  Abhishek Rathi - iOS
//  work.abhirathi@gmail.com
//
//  Created by Abhishek.Rathi on 30/08/19.
//  Copyright © 2019 Abhishek.Rathi. All rights reserved.
//

import UIKit



public protocol OTPViewDelegate {
    func didFinishedEnterOTP(otpNumber: String)
    func otpNotValid()
}

@IBDesignable public class OTPInputView: UIView {
    
    @IBInspectable var maximumDigits: Int = 4
    @IBInspectable var backgroundColour: UIColor = .white
    @IBInspectable var borderColour: UIColor = .gray
    @IBInspectable var shadowColour: UIColor = .clear
    @IBInspectable var textColor: UIColor = .black
    @IBInspectable var font: UIFont = UIFont.boldSystemFont(ofSize: 23)
    public var delegateOTP: OTPViewDelegate?
    
    override public func prepareForInterfaceBuilder() {
        setupTextFields()
    }
    
    override public func awakeFromNib() {
        setupTextFields()
    }
    
    fileprivate func setupTextFields() {
        backgroundColor = .white
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor)
            ])
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        
        for tag in 1...maximumDigits {
            let textField = OTPTextField()
            textField.tag = tag //set Tag to textField
            stackView.addArrangedSubview(textField)  // Add to stackView
            setupTextFieldStyle(textField)  // set the style accordingly
        }
    }
    
    fileprivate func setupTextFieldStyle(_ textField: UITextField) {
        textField.delegate = self // set up textfield delegate
        textField.backgroundColor = UIColor.white
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 195, green: 197, blue: 206, alpha: 0).cgColor//UIColor.blue.cgColor
        textField.contentHorizontalAlignment = .center
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 4
   //     textField.dropShadow(shadowOpacity: 0.6, shadowColor: shadowColour)
        textField.textColor = textColor
        textField.font = font
    }
}

extension OTPInputView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var nextTag = 0
        
        if string.checkBackspace()
        {
            textField.deleteBackward()
            return false
        } else if string.count == 1
        {
            textField.text = string
            nextTag = textField.tag + 1
        } else if string.count == maximumDigits
        {
            var otpPasted = string
            for tag in 1...maximumDigits {
                guard let textfield = viewWithTag(tag) as? UITextField else { continue }
                textfield.text = String(otpPasted.removeFirst())
            }
            otpFetch()
        }
        
        if let nextTextfield = viewWithTag(nextTag) as? OTPTextField {
            nextTextfield.becomeFirstResponder()
        } else {
            if nextTag > maximumDigits {
                otpFetch()
            }
            endEditing(true)
        }
        return false
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        print("editing")
    }
    
    
    public func otpFetch() {
        var otp = ""
        for tag in 1...maximumDigits {
            guard let textfield = viewWithTag(tag) as? UITextField else { continue }
            otp += textfield.text!
        }
        
        // Check if OTP is complete, i.e equals to maxDigits allowed
        if otp.count == maximumDigits {
            delegateOTP?.didFinishedEnterOTP(otpNumber: otp)
        } else {
            delegateOTP?.otpNotValid()
        }
    }

}

extension String {
    func checkBackspace() -> Bool {
        if let char = self.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                return true
            }
            return false
        }
        return false
    }
}

extension UIView {
    func dropShadow( shadowRadius: CGFloat = 2.0, offsetSize: CGSize = CGSize(width: 2, height: 5), shadowOpacity: Float = 0.5, shadowColor: UIColor = UIColor.lightGray ) {
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = offsetSize
        layer.shadowRadius = shadowRadius
    }
    
}



