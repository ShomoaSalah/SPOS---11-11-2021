//
//  SignUpVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/28/21.
//

import UIKit
import DropDown
import SVProgressHUD
import ActiveLabel

class SignUpVC: UIViewController {
    
    
    @IBOutlet weak var termsLbl: ActiveLabel!
    
    @IBOutlet weak var emailTF: HSUnderLineTextField!
    @IBOutlet weak var passwordTF: HSUnderLineTextField!
    @IBOutlet weak var businessNameTF: HSUnderLineTextField!
    @IBOutlet weak var accpectTermsBtn: UIButton!
    @IBOutlet weak var countrySelectedLbl: UILabel!
    @IBOutlet weak var countryView: UIView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    let dropDownCountry = DropDown()
    var countriess = [CountriesOB]()
    var countryDics = [String:Int]()
    
    var countryArrayString = [String]()
    var countrySelectedIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        LoadingButton.startLoading(activityIndicator: loadingIndicator)
        
//        let stringTerms = "انا اوافق على شروط الاستخدام وقرأت وأعترف بسياسة الخصوصية"
//        let attributedString = NSMutableAttributedString(string: stringTerms)
//        attributedString.addLink("https://....", linkColor: .red, text: "teeeeest")
//        termsTV.attributedText = attributedString
//
//        
//        
//        let customType = ActiveType.custom(pattern: "\\swith\\b") //Regex that looks for "with"
//        termsLbl.enabledTypes = [.url, customType]
//        termsLbl.text = "انا اوافق على شروط الاستخدام وقرأت وأعترف بسياسة الخصوصية"
////        termsLbl.customColor[customType] = UIColor.purple
////        termsLbl.customSelectedColor[customType] = UIColor.green
////        termsLbl.handle
//        termsLbl.handleCustomTap(for: customType) { element in
//            print("Custom type tapped: \(element)")
//        }
        
//        termsLbl.cust
        
        termsLbl.customize { label in
            label.text = "انا اوافق على شروط الاستخدام وقرأت وأعترف بسياسة الخصوصية"
            label.textColor = .black 
            label.URLColor = UIColor(red: 85.0/255, green: 238.0/255, blue: 151.0/255, alpha: 1)
            label.handleURLTap {_ in 
                
                //self.alert("URL", message: $0.absoluteString)
                print("handleURLTap UILabel")
            }
        }
        getCountries()
    }
    
   
    
    
    @IBAction func selectCountry(_ sender: UIButton) {
        openCountryMenu()
    }
    
  
    
    func openCountryMenu(){
        
        dropDownCountry.layer.cornerRadius = 10
        dropDownCountry.backgroundColor = .white
        
        dropDownCountry.anchorView = countryView
        dropDownCountry.width = 320
        dropDownCountry.bottomOffset = CGPoint(x: 0, y:(dropDownCountry.anchorView?.plainView.bounds.height)!)
        
        dropDownCountry.dataSource = self.countryArrayString
        
        dropDownCountry.selectionAction = { [unowned self] (index: Int, item: String) in
            
            countrySelectedLbl.text = item
            countrySelectedIndex = countryDics[item] ?? 0
            print("countrySelectedIndex \(countrySelectedIndex)")
            
        }
        dropDownCountry.show()
    }
    
    
    
    @IBAction func submitRegister(_ sender: UIButton) {
        
        guard let email = emailTF.text, !email.isEmptyStr else {
            self.navigationController?.view.makeToast(NSLocalizedString("emailRequired", comment: ""))
            return
        }
        guard let password = passwordTF.text, !password.isEmptyStr else {
            self.navigationController?.view.makeToast(NSLocalizedString("passwordRequired", comment: ""))
            return
        }
        guard let businessName = businessNameTF.text, !businessName.isEmptyStr else {
            self.navigationController?.view.makeToast(NSLocalizedString("businessNameRequired", comment: ""))
            return
        }
        guard countrySelectedIndex != 0 else {
            self.navigationController?.view.makeToast(NSLocalizedString("countryIDRequired", comment: ""))
            return
        }
        guard checkedInt != 0 else {
            self.navigationController?.view.makeToast(NSLocalizedString("checkedIntRequired", comment: ""))
            return
        }
        
      
        userRegisterRequest(email: emailTF.text!, password: passwordTF.text!, business_name: businessNameTF.text!, country_id: countrySelectedIndex, agreement_state: checkedInt)
        
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
    
    
    @IBAction func backView(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    var checked = true
    var checkedInt = 0
    
    @IBAction func tick(_ sender: UIButton) {
        if checked {
            sender.setImage(UIImage(named:"img-Check"), for: .normal)
            checked = false
            checkedInt = 1
        }
        else {
            sender.setImage(UIImage(named:"img-Uncheck"), for: .normal)
            checked = true
            checkedInt = 0
        }
    }
    
}


//MARK: - API Request

extension SignUpVC {
   
    func getCountries() {
        API.getCountriesList { [self] countries, status, msg in
            
            
            LoadingButton.stopLoading(activityIndicator: loadingIndicator)
            loadingIndicator.isHidden = true
            
            if status {
                countriess = countries
                
                for country in countriess {
                    countryArrayString.append(country.name!)
                    countryDics[country.name!] = country.id
                    countrySelectedIndex = country.id!
                    
                    
                }
                dropDownCountry.dataSource = countryArrayString
                
                
            }else {
                self.navigationController?.view.makeToast(msg)
            }
        }
    }
    
    
    
    func userRegisterRequest(email: String, password: String, business_name: String, country_id: Int, agreement_state: Int) {
        
        let urlRequest = APIConstant.register
        print("urlRequest register \(urlRequest)")
        
        var params = [String:Any]()
        params["business_name"] = business_name
        params["email"] = email
        params["password"] = password
        params["country_id"] = country_id
        params["agreement_state"] = agreement_state
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
