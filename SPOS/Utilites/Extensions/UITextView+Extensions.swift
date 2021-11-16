//
//  UITextView+Extensions.swift
//  Provider
//
//  Created by شموع صلاح الدين on 6/1/21.
//

import Foundation
import UIKit

extension UITextView{
   
    
    func addPAdding(leftRight: CGFloat,topBottom: CGFloat){
        self.isEditable = true
        self.textContainerInset = UIEdgeInsets(top: topBottom , left: leftRight, bottom: topBottom, right: leftRight)
    }
    
    func setFont(name:String,size:CGFloat){
        if name == ""{
            self.font = UIFont.systemFont(ofSize: size)

        }else{
            self.font = UIFont(name: name, size: size)
        }
    }
    
    
    func adjustUITextViewHeight()
    {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = false
    }
    
}
