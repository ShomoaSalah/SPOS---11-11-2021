//
//  PaymentDoneVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/4/21.
//

import UIKit

class CashPaymentDoneVC: BaseVC {

    @IBOutlet weak var sendByEmailView: UIView!
    @IBOutlet weak var sendByMobileView: UIView!
    
    @IBOutlet weak var sendByEmailBtn: UIButton!
    @IBOutlet weak var sendByMobileBtn: UIButton!
    
    @IBOutlet weak var sendingMobileDoneImage: UIImageView!
    @IBOutlet weak var sendingEmailDoneImage: UIImageView!
    
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "تم الدفع"
        
        sendByMobileView.isHidden = true
        sendByEmailView.isHidden = true
        
        emailTF.addTarget(self, action: #selector(showSubmitSendingEmail), for: .editingChanged)
        mobileTF.addTarget(self, action: #selector(showSubmitSendingMobile), for: .editingChanged)
        
    }
    
    @objc func showSubmitSendingEmail(){
        sendByEmailView.isHidden = false
        sendingEmailDoneImage.isHidden = true
    }
    
    //
    
    @IBAction func submitSendingEmail(_ sender: UIButton) {
        sendingEmailDoneImage.isHidden = false
        sendByEmailBtn.isHidden = true
    }

    @objc func showSubmitSendingMobile(){
        sendByMobileView.isHidden = false
        sendingMobileDoneImage.isHidden = true
    }
    @IBAction func submitSendingMobile(_ sender: UIButton) {
        sendingMobileDoneImage.isHidden = false
       
        sendByMobileBtn.isHidden = true
    }
    
    
    @IBAction func backToHome(_ sender: UIButton) {
        
        let tabViewController = UIStoryboard.init(name: "HomeSB", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBar") as! CustomTabBar
        
      
        tabViewController.selectedIndex = 0
        UIApplication.shared.keyWindow?.rootViewController = tabViewController
        
    }
    
}
