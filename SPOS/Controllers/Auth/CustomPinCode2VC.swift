//
//  ViewController.swift
//  CustomPin
//
//  Created by شموع صلاح الدين on 10/7/21.
//

import UIKit
import InputViews
import SVProgressHUD

extension UIColor{
    convenience init(rgb: UInt, alphaVal: CGFloat) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: alphaVal
        )
    }
}


protocol CustomPinCodeProtocol {
     
    func didClose(object: TimeClockOB, fromBackgroundStype: Bool)
}

class CustomPinCodeVC: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var sposLogoImage: UIImageView!
    @IBOutlet weak var logOutBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var stackNew: UIStackView!
    
    var delegate: CustomPinCodeProtocol?
    
    
    var codeWrittenByUser = ""
    var codeFromServer = [String]()
    var trackTimeState = false
    var pos_id = 0
    var fromBackgroundStype = false
    @IBOutlet var otpTFNew: [NoCutPasteTextField]! {
        didSet {
            
          
            
            otpTFNew[0].resignFirstResponder()
            
            guard otpTFNew != nil else { return }
           
            let array = [
                "1", "2", "3",
                "4", "5", "6",
                "7", "8", "9",
                "", "0", "إزالة",
            ]

            let inputView = CollectionInputView<String>(height: 484.0)

            inputView.items = { return array }
            inputView.didSelect = { [self] string in
             
                if string == "إزالة" {
                    
                    if otpTFNew[0].isFirstResponder {
                        print("isFirstResponder 0")
                        otpTFNew[0].text = ""
                        
                        otpTFNew[0].layer.borderWidth = 1
                        otpTFNew[0].layer.borderColor = UIColor(rgb: 0xC3C5CE, alphaVal: 1).cgColor
                        otpTFNew[0].layer.cornerRadius = 4
                        otpTFNew[0].backgroundColor = .white
                        
                    }else if otpTFNew[1].isFirstResponder {
                        print("isFirstResponder 1")
                        otpTFNew[0].becomeFirstResponder()
                        otpTFNew[1].text = ""
                        otpTFNew[1].layer.borderWidth = 1
                        otpTFNew[1].layer.borderColor = UIColor(rgb: 0xC3C5CE, alphaVal: 1).cgColor
                        otpTFNew[1].layer.cornerRadius = 4
                        otpTFNew[1].backgroundColor = .white
                    }else if otpTFNew[2].isFirstResponder {
                        print("isFirstResponder 2")
                        otpTFNew[1].becomeFirstResponder()
                        otpTFNew[2].text = ""
                        otpTFNew[2].layer.borderWidth = 1
                        otpTFNew[2].layer.borderColor = UIColor(rgb: 0xC3C5CE, alphaVal: 1).cgColor
                        otpTFNew[2].layer.cornerRadius = 4
                        otpTFNew[2].backgroundColor = .white
                        
                    }else if otpTFNew[3].isFirstResponder {
                        otpTFNew[3].text = ""
                        otpTFNew[2].becomeFirstResponder()
                        otpTFNew[3].layer.borderWidth = 1
                        otpTFNew[3].layer.borderColor = UIColor(rgb: 0xC3C5CE, alphaVal: 1).cgColor
                        otpTFNew[3].layer.cornerRadius = 4
                        otpTFNew[3].backgroundColor = .white
                        
                    }
                    
                }else if string == "" {
                    sposLogoImage.isHidden = true
                    stackNew.isHidden = false
                    
                    logOutBtn.backgroundColor = "FF4E54".color
                    logInBtn.applyGradientUIButton(colours: ["0386E8".color, "0CA7EE".color], gradientOrientation: .horizontal)
                
                    
                } else {
                    
                    
                      if otpTFNew[0].isFirstResponder {
                          print("isFirstResponder 0")
                          otpTFNew[1].becomeFirstResponder()
                          otpTFNew[0].text = string
                         
                          otpTFNew[0].layer.borderWidth = 1
                          otpTFNew[0].layer.borderColor = UIColor(rgb: 0x0CA7EE, alphaVal: 1).cgColor
                          otpTFNew[0].layer.cornerRadius = 4
                          otpTFNew[0].backgroundColor = UIColor(rgb: 0x0CA7EE, alphaVal: 0.1)
                          otpTFNew[0].textColor = UIColor(rgb: 0x0CA7EE, alphaVal: 1)
                          
                      }else if otpTFNew[1].isFirstResponder {
                          print("isFirstResponder 1")
                          otpTFNew[2].becomeFirstResponder()
                          otpTFNew[1].text = string
                          otpTFNew[1].layer.borderWidth = 1
                          otpTFNew[1].layer.borderColor = UIColor(rgb: 0x0CA7EE, alphaVal: 1).cgColor
                          otpTFNew[1].layer.cornerRadius = 4
                          otpTFNew[1].backgroundColor = UIColor(rgb: 0x0CA7EE, alphaVal: 0.1)
                          otpTFNew[1].textColor = UIColor(rgb: 0x0CA7EE, alphaVal: 1)
                      }else if otpTFNew[2].isFirstResponder {
                          print("isFirstResponder 2")
                          otpTFNew[3].becomeFirstResponder()
                          otpTFNew[2].text = string
                          otpTFNew[2].layer.borderWidth = 1
                          otpTFNew[2].layer.borderColor = UIColor(rgb: 0x0CA7EE, alphaVal: 1).cgColor
                          otpTFNew[2].layer.cornerRadius = 4
                          otpTFNew[2].backgroundColor = UIColor(rgb: 0x0CA7EE, alphaVal: 0.1)
                          otpTFNew[2].textColor = UIColor(rgb: 0x0CA7EE, alphaVal: 1)
                          
                      }else if otpTFNew[3].isFirstResponder {
                          otpTFNew[3].text = string
                          otpTFNew[3].layer.borderWidth = 1
                          otpTFNew[3].layer.borderColor = UIColor(rgb: 0x0CA7EE, alphaVal: 1).cgColor
                          otpTFNew[3].layer.cornerRadius = 4
                          otpTFNew[3].backgroundColor = UIColor(rgb: 0x0CA7EE, alphaVal: 0.1)
                          otpTFNew[3].textColor = UIColor(rgb: 0x0CA7EE, alphaVal: 1)

                      }
                    
                }
                
                
                if !otpTFNew.isEmpty {
                    codeWrittenByUser = getCode()
                    print("codeWrittenByUser \(codeWrittenByUser)")
                        
                    
                    
//                    if enableTimeClock {
                        logInBtn.backgroundColor = "FF4E54".color
                        logInBtn.setBorder(width: 0.5, color: "FF4E54".cgColor)
                        logInBtn.setTitleColor(.white, for: .normal)
                        
                        logOutBtn.backgroundColor = "0CA7EE".color
                        logOutBtn.setBorder(width: 0.5, color: "0CA7EE".cgColor)
                        logOutBtn.setTitleColor(.white, for: .normal)
//                    }else {
//
//
//                        logInBtn.backgroundColor = "C3C5CE".color
//                        logInBtn.setBorder(width: 0.5, color: "C3C5CE".cgColor)
//                        logInBtn.setTitleColor(.black, for: .normal)
//
//                        logOutBtn.backgroundColor = "C3C5CE".color
//                        logOutBtn.setBorder(width: 0.5, color: "C3C5CE".cgColor)
//                        logOutBtn.setTitleColor(.black, for: .normal)
//
//
//                    }
                    
                }
                
                
                if codeFromServer.contains(codeWrittenByUser) {
                    if enableTimeClock {
                        //time_clock
                        //enterTimeClock
                        
                        /*
                         enableLogInTimeClock = true
                         enableLogOutTimeClock = false
                         */
//                        if enableLogInTimeClock {
//                            enterTimeClock(pin_code: codeWrittenByUser, clock_type: 1, pos_id: self.pos_id)
//                        }else if enableLogOutTimeClock {
//                            enterTimeClock(pin_code: codeWrittenByUser, clock_type: 2, pos_id: self.pos_id)
//                        }
                        
                    }else {
                        postPinCode(pin_code: codeWrittenByUser)
                    }
                   
                }else {
                    self.view.makeToast("Pin Code not found")
                }
         
            }
            
            inputView.text = { string in return string }
 
            otpTFNew.forEach { field in
                
                
                field.delegate = self
                field.inputView = inputView
                
                field.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
                
                field.inputView?.superview?.heightAnchor.constraint(equalToConstant: 484).isActive = true
                field.inputAccessoryView = AccessoryView(height: 0.5, backgroundColor: .lightGray)
                
            }
            
        }
    }
        
    func getCode() -> String {
        var code = ""
        
        for tf in otpTFNew {
            if let number = tf.text {
                code += number
            }
        }
        print("NewCode \(code)")
        return code
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPinCodes()
        stackNew.isHidden = true
        
        
    }
    
    
    
    @objc func textFieldDidChange(textField: UITextField) {
        
        let text = textField.text
        let index = textField.tag + 1
        
        print("textFieldDidChange")
        if text?.utf16.count == 1 && index < 4 {
            otpTFNew[index].becomeFirstResponder()
        } else if text?.utf16.count == 1 {
            self.view.endEditing(true)
        }
        
    }
    
    
    var enableTimeClock = false
    
    @IBAction func submit(_ sender: UIButton) {
        enableTimeClock = true
        sposLogoImage.isHidden = true
        stackNew.isHidden = false
        /*
         logInBtn
         logOutBtn
         */
    }
    
    var enableLogInTimeClock = false
    var enableLogOutTimeClock = false
    
    @IBAction func submitLogIn(_ sender: UIButton) {
//        enableLogInTimeClock = true
//        enableLogOutTimeClock = false
        
        if !otpTFNew.isEmpty {
            codeWrittenByUser = getCode()
            enterTimeClock(pin_code: codeWrittenByUser, clock_type: 1, pos_id: self.pos_id)
        }
        
    }
    
    
    @IBAction func submitLogOut(_ sender: UIButton) {
//        enableLogInTimeClock = false
//        enableLogOutTimeClock = true
        if !otpTFNew.isEmpty {
            codeWrittenByUser = getCode()
            enterTimeClock(pin_code: codeWrittenByUser, clock_type: 2, pos_id: self.pos_id)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        otpTFNew[0].text = ""
        otpTFNew[1].text = ""
        otpTFNew[2].text = ""
        otpTFNew[3].text = ""
        
        otpTFNew[0].becomeFirstResponder()
        otpTFNew[0].layer.borderWidth = 1
        otpTFNew[0].layer.borderColor = UIColor(rgb: 0xC3C5CE, alphaVal: 1).cgColor
        otpTFNew[0].layer.cornerRadius = 4
        otpTFNew[0].backgroundColor = .white
        
        otpTFNew[1].layer.borderWidth = 1
        otpTFNew[1].layer.borderColor = UIColor(rgb: 0xC3C5CE, alphaVal: 1).cgColor
        otpTFNew[1].layer.cornerRadius = 4
        otpTFNew[1].backgroundColor = .white
        
        otpTFNew[2].layer.borderWidth = 1
        otpTFNew[2].layer.borderColor = UIColor(rgb: 0xC3C5CE, alphaVal: 1).cgColor
        otpTFNew[2].layer.cornerRadius = 4
        otpTFNew[2].backgroundColor = .white
        
        otpTFNew[3].layer.borderWidth = 1
        otpTFNew[3].layer.borderColor = UIColor(rgb: 0xC3C5CE, alphaVal: 1).cgColor
        otpTFNew[3].layer.cornerRadius = 4
        otpTFNew[3].backgroundColor = .white
        
    }
}


//MARK: - API Request

extension CustomPinCodeVC {
    
    
    func getPinCodes() {
        
        let requestUrl = APIConstant.getPinCode
        print("requestUrl get PinCode \(requestUrl)")
        
        SVProgressHUD.show()
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] (status, responesObject) in
            
            if status {
                
                do{
                    let object = try JSONDecoder().decode(PinCodeOB.self, from: responesObject?.data as! Data)
                    codeFromServer = object.pinCodes ?? [String]()
                    trackTimeState = object.trackTimeState ?? false
                  
                    
                    
                }catch{
                    self.view.makeToast(responesObject?.message ?? "")
                }
                
            }
            
            else{
                self.navigationController?.view.makeToast((responesObject?.message!)!)
            }
            
        }
    }
    
    func postPinCode(pin_code: String) {
     
        
        let urlRequest = APIConstant.postPinCode
        print("urlRequest post Pin Code \(urlRequest)")
        
        var params = [String:Any]()
        params["pin_code"] = pin_code
       
        
        print("PARAMS \(params)")
        SVProgressHUD.show()
        
        
        API.startRequest(url: urlRequest, method: .post, parameters: params, viewCon: self) { [self] (status, responesObject) in
            
            SVProgressHUD.dismiss()
            if status {
                
                
                if fromBackgroundStype {
                    print("fromBackgroundStype 123")
                    self.dismiss(animated: true, completion: nil)
                }else {
                    let vc = UIStoryboard.init(name: "HomeSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomTabBar") as! CustomTabBar
                
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
                
             
            }
            
            else{
                self.navigationController?.view.makeToast((responesObject?.message!)!)
            }
            
        }
        
    }
   
    func enterTimeClock(pin_code: String, clock_type: Int, pos_id: Int) {
     
        let urlRequest = APIConstant.submitTimeClock
        print("urlRequest submit Time Clock \(urlRequest)")
        
        var params = [String:Any]()
        params["pin_code"] = pin_code
        params["pos_id"] = pos_id
        params["clock_type"] = clock_type
        
        print("PARAMS \(params)")
        SVProgressHUD.show()
        
        
        API.startRequest(url: urlRequest, method: .post, parameters: params, viewCon: self) { [self] (status, responesObject) in
            
            SVProgressHUD.dismiss()
            if status {
                
                
                do{
                    
                    let object = try JSONDecoder().decode(TimeClockOB.self, from: responesObject?.data as! Data)
                    
                    
                    switch clock_type {
                    case 1://timeClockObject
                        
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EntetTimeCheckInVC") as! EntetTimeCheckInVC
                        
                        vc.timeClockObject = object
                        vc.fromBackgroundStype = self.fromBackgroundStype
                        
                        
                        //TimeClockOB fromBackgroundStype
                        if fromBackgroundStype {
                            vc.modalPresentationStyle = .fullScreen
                            self.dismiss(animated: true) {
                                self.delegate?.didClose(object: object, fromBackgroundStype: true)
                            }
//                            self.present(vc, animated: true, completion: nil)
                        } else {
                            self.navigationItem.hideBackWord()
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                        
                        
                        
                        break
                    case 2:
                        
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EntetTimeCheckOutVC") as! EntetTimeCheckOutVC
                        
                        vc.timeClockObject = object
                        vc.fromBackgroundStype = self.fromBackgroundStype
                        if fromBackgroundStype {
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        }else{
                            self.navigationItem.hideBackWord()
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                        
                        
                        break
                        
                    default:
                        break
                    }
                    
                    
                 
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
