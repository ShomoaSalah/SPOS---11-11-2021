//
//  SetNewPasswordVC.swift
//  SPOS 
//
//  Created by شموع صلاح الدين on 9/23/21.
//

import UIKit
import SVProgressHUD

class SetNewPasswordVC: UIViewController {

    @IBOutlet weak var confirmNewPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    
    var codeNew = 0
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("newpassword", comment: "")
      
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
  
    var iconClick = true
    @IBAction func showHidePassword(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            
            if(iconClick == true) {
                newPasswordTF.isSecureTextEntry = false
                sender.setImage(UIImage(named: "img-showPassword"), for: .normal)
            } else {
                newPasswordTF.isSecureTextEntry = true
                sender.setImage(UIImage(named: "img-hidePassword"), for: .normal)
            }
            break
            
        case 1:
            
            if(iconClick == true) {
                confirmNewPasswordTF.isSecureTextEntry = false
                sender.setImage(UIImage(named: "img-showPassword"), for: .normal)
            } else {
                confirmNewPasswordTF.isSecureTextEntry = true
                sender.setImage(UIImage(named: "img-hidePassword"), for: .normal)
            }
            break
            
        default:
            break
        }
       
        
        iconClick = !iconClick
    }
    

    
    @IBAction func submitNewPassword(_ sender: UIButton) {
        
        guard !newPasswordTF.text!.isEmptyStr else {
            self.navigationController?.view.makeToast(NSLocalizedString("password", comment: ""))
            return
        }
        
        guard !confirmNewPasswordTF.text!.isEmptyStr else {
            self.navigationController?.view.makeToast(NSLocalizedString("passwordConfirmation", comment: ""))
            return
        }
        
        
        
        if newPasswordTF.text == confirmNewPasswordTF.text {
            
           //API Request
            submitResetPassword(email: email, code: codeNew.description, password: newPasswordTF.text!, c_password: confirmNewPasswordTF.text!)
        }else {
            self.navigationController?.view.makeToast(NSLocalizedString("passwordNotMatch", comment: ""))
            
        }
        
    }
}

//MARK: - API Request

extension SetNewPasswordVC {
    
    
    func submitResetPassword(email: String, code: String, password: String, c_password: String) {
        
        let urlRequest = APIConstant.resetPassword
        print("urlRequest reset Password \(urlRequest)")
        
        var params = [String:Any]()
        params["email"] = email
        params["code"] = code
        params["password"] = password
        params["c_password"] = c_password
        
        print("PARAMS \(params)")
        
        SVProgressHUD.show()
        
        
        API.startRequest(url: urlRequest, method: .post, parameters: params, viewCon: self) { [self] (status, responesObject) in
            
            SVProgressHUD.dismiss()
            if status {
                
                self.showAlert(title: "", message: (responesObject?.message)!, okAction: "OK") { alert in
                    self.navigationController?.popToViewController(ofClass: LoginVC.self, animated: true)
                }
                
            }
            
            else{
                self.navigationController?.view.makeToast((responesObject?.message!)!)
            }
            
        }
    }
}
