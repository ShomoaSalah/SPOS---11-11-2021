//
//  UIViewController+Extension.swift
//  Provider
//
//  Created by شموع صلاح الدين on 4/3/21.
//

import Foundation
import UIKit
//import Presentr


extension UIViewController {

    
    
    
//    func popUpPresenter() -> Presentr {
//
//        let presenter: Presentr = {
//                    let width = ModalSize.full
//                    let height = ModalSize.fluid(percentage: 0.20)
//                    let center = ModalCenterPosition.customOrigin(origin: CGPoint(x: 0, y: 0))
//                    let customType = PresentationType.custom(width: width, height: height, center: center)
//
//                    let customPresenter = Presentr(presentationType: customType)
//                    customPresenter.transitionType = .crossDissolve
//                    customPresenter.dismissTransitionType = .crossDissolve
//                    customPresenter.roundCorners = false
//        //            customPresenter.backgroundColor = .green
//        //            customPresenter.backgroundOpacity = 0.5
//                    customPresenter.dismissOnSwipe = true
//            customPresenter.dismissOnSwipeDirection = .top
//            customPresenter.presentationType = .fullScreen
//                    return customPresenter
//                }()
//
//        return presenter
//    }
    
    func showToast(message: String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.numberOfLines = 0
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.4, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
    func showAlert(title: String, message:String, okAction: String = "Ok".localized, completion: ((UIAlertAction) -> Void)? = nil ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okAction, style: .default, handler: completion))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //simple alert
        func showCustomAlert(title: String, message:String, okAction: String = "Ok", completion: ((UIAlertAction) -> Void)? = nil ) {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: okAction, style: .default, handler:  { (alert) in

                
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
                
                
                
            }))
            
            present(alert, animated: true, completion: nil)
        }
      
    /*
    
     */
      func showAlertWithCancel(title: String, message:String, okAction: String = "Ok", completion: ((UIAlertAction) -> Void)? = nil ) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: okAction, style: .default, handler: completion))
          alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: { (alert) in
//              self.dismiss(animated: true, completion: nil)
          }))
           present(alert, animated: true, completion: nil)
       }
       
       func showAlertNoInternt() {
           showAlert(title: "", message: "No Internet Connection")
       }
    
    
    
    
    func addNotificationObserver(_ name: NSNotification.Name,_ selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    
    func postNotificationCenter(_ name: NSNotification.Name, _ object: Any? = nil) {
        NotificationCenter.default.post(name: name, object: object)
    }
    
    func removeNotificationObserver(_ name: NSNotification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }
    
    
    
}
