//
//  VerificationCodeVC.swift
//  SPOS 
//
//  Created by شموع صلاح الدين on 9/23/21.
//

import UIKit
import PinCodeTextField
import Toast_Swift
import SVProgressHUD


class VerificationCodeVC: UIViewController {

    @IBOutlet weak var codeTF: PinCodeTextField!
    @IBOutlet weak var resendCodeBtn: UIButton!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    var timer:Timer?
    var timeLeft = 0
    var timesResendNumber = 0
    var codeWrittenByUser = ""
    var email1 = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("verificationCode", comment: "")
        emailLbl.text = email1
        
         setup()
         codeTF.keyboardType = .numberPad
         codeTF.delegate = self
         codeTF.becomeFirstResponder()
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
    
    
    func setup() {
        resendCodeBtn.isHidden = true
        timerLbl.isHidden = false
        timeLeft = 60
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    @objc func onTimerFires() {
        timeLeft -= 1
        timerLbl.text = "00:\(String(format: "%02d", timeLeft)) "
        if timeLeft <= 0 {
            resendCodeBtn.isHidden = false
            timerLbl.isHidden = true
            stopTimer()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    
    @IBAction func submitResendVerificationCode(_ sender: UIButton) {
        
        if timesResendNumber == 3 {
            resendCodeBtn.isHidden = true
            timerLbl.isHidden = false
            timerLbl.text = "لا يمكن اعادة ارسال الكود أكثر من 3 مرات"
        }else {
          
           //API request
            submitVerificationCode(email: email1, code: codeWrittenByUser)
        }
        
        timesResendNumber = timesResendNumber + 1
        
    }
    
  

    
    @IBAction func submitCode(_ sender: UIButton) {
        
  
        
        stopTimer()

        guard !codeTF.text!.isEmptyStr else {
            self.view.makeToast(NSLocalizedString("PleaseTypeVerificationCode", comment: ""))
           return
        }
        
        
        //API request
        
        submitVerificationCode(email: email1, code: codeWrittenByUser)
    }
    
    
    
    
    

}



//MARK: - API Request 

extension VerificationCodeVC {
    
    func submitVerificationCode(email: String, code: String) {
        
        let urlRequest = APIConstant.verifyCode
        print("urlRequest verifyCode \(urlRequest)")
        
        var params = [String:Any]()
        params["email"] = email
        params["code"] = code
        
        print("PARAMS \(params)")
        SVProgressHUD.show()
        
        
        API.startRequest(url: urlRequest, method: .post, parameters: params, viewCon: self) { [self] (status, responesObject) in
            
            SVProgressHUD.dismiss()
            if status {
             
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SetNewPasswordVC") as! SetNewPasswordVC
                
                vc.codeNew = responesObject?.data as! Int
                vc.email = email
                print("Code New \(responesObject?.data)")
                self.navigationItem.hideBackWord()
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
            else{
                self.navigationController?.view.makeToast((responesObject?.message!)!)
            }
            
        }
    }

   
    
}

//MARK: - Pin Code Delegate

extension VerificationCodeVC: PinCodeTextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: PinCodeTextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: PinCodeTextField) {
        
    }
    
    func textFieldValueChanged(_ textField: PinCodeTextField) {
        let value = textField.text ?? ""
        print("value changed: textFieldValueChanged \(value)")
    }
    
    func textFieldShouldEndEditing(_ textField: PinCodeTextField) -> Bool {
        let value = textField.text ?? ""
        codeWrittenByUser = value
        print("value changed: ShouldEndEditing \(codeWrittenByUser)")
        return true
    }
    
    func textFieldShouldReturn(_ textField: PinCodeTextField) -> Bool {
        let value = textField.text ?? ""
        print("value changed: ShouldReturn \(value)")
        return true
    }
    
}

