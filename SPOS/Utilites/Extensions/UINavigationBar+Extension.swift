//
//  UINavigationBar+Extension.swift
//  AqarAfterDeletetion
//
//  Created by شموع صلاح الدين on 8/15/21.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    func setNavClear() {
      
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        
        
    }
    
    func setNavUNClear() {

        self.setBackgroundImage(UIColor.clear.colorToImage(), for: .default)
        self.layoutIfNeeded()
        
        
    }
   
    func installBlurEffect() {
         isTranslucent = true
         setBackgroundImage(UIImage(), for: .default)
         let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
         var blurFrame = bounds
         blurFrame.size.height += statusBarHeight
         blurFrame.origin.y -= statusBarHeight
         let blurView  = UIVisualEffectView(effect: UIBlurEffect(style: .light))
         blurView.isUserInteractionEnabled = false
         blurView.frame = blurFrame
//        blurView.backgroundColor = .orange
         blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         addSubview(blurView)
         blurView.layer.zPosition = -1
     }
    
  
    
}

