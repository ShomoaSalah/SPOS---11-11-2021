//
//  ForgetPasswordVC.swift
//  SPOS 
//
//  Created by شموع صلاح الدين on 9/23/21.
//

import UIKit
import SVProgressHUD

class ForgetPasswordVC: UIViewController {
    
    @IBOutlet weak var emailTF: HSUnderLineTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("ForgetPassword", comment: "")
        
        
        
        
    }
    
    
    @IBAction func submit(_ sender: UIButton) {
        
        
        guard let email = emailTF.text, !email.isEmptyStr else {
            self.navigationController?.view.makeToast(NSLocalizedString("emailRequired", comment: ""))
            return
        }
        
        submitSendCode(email: emailTF.text!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowOffset = CGSize(width: 0, height: 10)
        self.navigationController?.navigationBar.shadowColor = "CECECE".color.withAlphaComponent(0.5)
        self.navigationController?.navigationBar.shadowOpacity = 0.8
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowOffset = CGSize(width: 0, height: 0)
        self.navigationController?.navigationBar.shadowColor = .clear
        self.navigationController?.navigationBar.shadowOpacity = 0.0
        
    }
    
    
}



//MARK: - API Request

extension ForgetPasswordVC {
    
    
    func submitSendCode(email: String) {
        
        let urlRequest = APIConstant.sendCode
        print("urlRequest send Code \(urlRequest)")
        
        var params = [String:Any]()
        params["email"] = email
        
        print("PARAMS \(params)")
        SVProgressHUD.show()
        
        
        API.startRequest(url: urlRequest, method: .post, parameters: params, viewCon: self) { [self] (status, responesObject) in
            
            SVProgressHUD.dismiss()
            if status {
                
                self.showAlert(title: "", message: (responesObject?.message)!, okAction: "OK") { alert in
                    
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "VerificationCodeVC") as! VerificationCodeVC
                    
                    vc.email1 = email
                    
                    self.navigationItem.hideBackWord()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                 
                
            }
            
            else{
                self.navigationController?.view.makeToast((responesObject?.message!)!)
            }
            
        }
    }
}
