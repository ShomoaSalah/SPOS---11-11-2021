//
//  SplashAnimationVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/23/21.
//

import UIKit

class SplashAnimationVC: UIViewController {
    
    
    @IBOutlet weak var logoSmallImage: UIImageView!
    @IBOutlet weak var logoLargeImage: UIImageView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoLargeImage.isHidden = true
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIView.AnimationOptions.curveEaseIn, animations: { [self] in
            
            // HERE
            logoSmallImage.transform = CGAffineTransform.identity.scaledBy(x: 2, y: 2) // Scale your image
            //            logoSmallImage.transform = CGAffineTransform.identity
            
        }) { [self] (finished) in
            UIView.animate(withDuration: 0.5, animations: { [self] in
                //                logoSmallImage.transform = CGAffineTransform.identity // undo in 1 seconds
                logoSmallImage.isHidden = true
                logoLargeImage.isHidden = false
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    checkUserLogin()
                }
                
                
                
            })
        }
    }
    
    
    func checkUserLogin() {
        
        if UserHelper.isLogin() {
            
            SplashAnimationVC.checkUserState(isCompleted: UserHelper.lodeUser()?.isCompleted ?? "", object: UserHelper.lodeUser()!, view: self)
            
        }else {
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationItem.hideBackWord()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.setNavClear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.setNavClear()
    }
    
    
    static func checkUserState(isCompleted: String, object: UserOB?, view: UIViewController)  {
        
        
        
        let newObject: UserOB?
        
        
        if object != nil {
            print("object is nil \(object?.token)")
            newObject = UserOB(id: object?.id, ownerID: object?.ownerID, storeID: object?.storeID, name: object?.name, wallet: object?.wallet, mobile: object?.mobile, countryID: object?.countryID, email: object?.email, isCompleted: object?.isCompleted, agreementState: object?.agreementState, pinCode: object?.pinCode, backOffice: object?.backOffice, status: object?.status, token: object?.token, role: object?.role, nameOfStore: object?.nameOfStore, countryName: object?.countryName, backOfficeURL: object?.backOfficeURL, posID: object?.posID, isScan: object?.isScan, pinCodeState: object?.pinCodeState, posName: object?.posName, isShift: object?.isShift, isShiftMenu: object?.isShiftMenu, employeeName: object?.employeeName, shiftID: object?.shiftID)
            
        }else {
            print("object")
            print("object \(UserHelper.lodeUser()?.token)")
            newObject = UserHelper.lodeUser()
        }
        
        
        
        switch isCompleted {
        case "completed":
            
            let vc = UIStoryboard.init(name: "HomeSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomTabBar") as! CustomTabBar
            UserHelper.saveUser(user: object!)
            print("Done")
            vc.modalPresentationStyle = .fullScreen
            view.present(vc, animated: true, completion: nil)
            
            break
            
        case "no_pos_devices_available":
            
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomAlertMessageVC") as! CustomAlertMessageVC
            UserHelper.saveUser(user: newObject!)
            vc.backOfficeURL = object?.backOfficeURL ?? ""
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            
            view.present(vc, animated: true, completion: nil)
            break
            
        case "choose_store":
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SelectStoreVC") as! SelectStoreVC
            //            UserHelper.saveUser(user: object)
            UserHelper.saveUser(user: newObject!)
            print("Done")
            view.navigationItem.hideBackWord()
            view.navigationController?.pushViewController(vc, animated: true)
            break
            
        case "choose_pos":
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SelectPOSVC") as! SelectPOSVC
            UserHelper.saveUser(user: newObject!)
            vc.selectedStoreID = object?.storeID ?? 0
            
            view.navigationItem.hideBackWord()
            view.navigationController?.pushViewController(vc, animated: true)
            break
            
        case "enter_pin_code":
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomPinCodeVC") as! CustomPinCodeVC
            UserHelper.saveUser(user: newObject!)
            
            vc.pos_id = UserHelper.lodeUser()?.posID ?? 0
            
            view.navigationItem.hideBackWord()
            view.navigationController?.pushViewController(vc, animated: true)
            break
            
        default:
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            view.navigationItem.hideBackWord()
            view.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
}
