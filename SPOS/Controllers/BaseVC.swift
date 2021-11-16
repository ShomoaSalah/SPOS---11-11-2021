//
//  BaseVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/9/21.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addNotificationObserver(.openPinCodeVC, #selector(openPinCodeVC))
        
    }
    
    
    @objc func openPinCodeVC(){
        
        if UserHelper.isLogin() {
            SplashAnimationVC.checkUserState(isCompleted: UserHelper.lodeUser()?.isCompleted ?? "", object: UserHelper.lodeUser(), view: self)
        }
     
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomPinCodeVC") as! CustomPinCodeVC
//        
//        vc.pos_id = UserHelper.lodeUser()?.posID ?? 0
//        vc.fromBackgroundStype = true
//        vc.delegate = self
//        vc.modalPresentationStyle = .fullScreen
//        
//        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    

   
}


extension BaseVC: CustomPinCodeProtocol {
    func didClose(object: TimeClockOB, fromBackgroundStype: Bool) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EntetTimeCheckInVC") as! EntetTimeCheckInVC
        
        vc.timeClockObject = object
        vc.fromBackgroundStype = fromBackgroundStype
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
}
