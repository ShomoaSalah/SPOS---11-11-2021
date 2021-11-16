//
//  LoginVC.swift
//  SPOS 
//
//  Created by شموع صلاح الدين on 9/23/21.
//

import UIKit
import SVProgressHUD


class LoginVC: UIViewController {
    
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.applyGradientUIButton(colours: ["0386E8".color, "0CA7EE".color], gradientOrientation: .horizontal)
        
        //REMOVE BACK INDICATOR
        self.navigationController?.navigationBar.backIndicatorImage = UIImage()
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
        
    }
    
    
    
    
    var iconClick = true
    @IBAction func showHidePassword(_ sender: UIButton) {
        if(iconClick == true) {
            passwordTF.isSecureTextEntry = false
            sender.setImage(UIImage(named: "eyeIcon"), for: .normal)
        } else {
            passwordTF.isSecureTextEntry = true
            sender.setImage(UIImage(named: "img-hidePassword"), for: .normal)
        }
        
        iconClick = !iconClick
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.setNavClear()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.setNavUNClear()
    }
    
    @IBAction func submitLogin(_ sender: UIButton) {
        
        guard let email = emailTF.text, !email.isEmptyStr else {
            self.navigationController?.view.makeToast(NSLocalizedString("emailRequired", comment: ""))
            return
        }
        guard let password = passwordTF.text, !password.isEmptyStr else {
            self.navigationController?.view.makeToast(NSLocalizedString("passwordRequired", comment: ""))
            return
        }
        
        userloginRequest(email: emailTF.text!, password: passwordTF.text!)
        
    }
    
    
    @IBAction func didTapCreateAccount(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func goToForgetPasswordView(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ForgetPasswordVC") as! ForgetPasswordVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


//MARK: - API Request

extension LoginVC {
    
    func userloginRequest(email: String, password: String) {
        
        let urlRequest = APIConstant.login
        print("urlRequest login \(urlRequest)")
        
        var params = [String:Any]()
        params["email"] = email
        params["password"] = password
        params["fcm_token"] = "1234444"
        params["device"] = "ios"
        
        print("PARAMS \(params)")
        SVProgressHUD.show()
        
        
        API.startRequest(url: urlRequest, method: .post, parameters: params, viewCon: self) { [self] (status, responesObject) in
            
            SVProgressHUD.dismiss()
            if status {
                
                do{
                    
                    let object = try JSONDecoder().decode(UserOB.self, from: responesObject?.data as! Data)
                    SplashAnimationVC.checkUserState(isCompleted: object.isCompleted ?? "", object: object, view: self)
                    
                }catch{
                    self.navigationController?.view.makeToast(error.localizedDescription)
                    print(error.localizedDescription)
                }
            }
            
            else{
                self.navigationController?.view.makeToast((responesObject?.message!)!)
            }
            
        }
    }
    
}
