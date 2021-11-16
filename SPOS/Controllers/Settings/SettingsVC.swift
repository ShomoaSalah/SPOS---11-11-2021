//
//  SettingsVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/29/21.
//

import UIKit
import SVProgressHUD

class SettingsVC: BaseVC {

    @IBOutlet weak var emailLbl: UILabel!
    
    var posID = 0
    let delegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()

        addLeftButton()
        
        if UserHelper.isLogin() {
            posID = UserHelper.lodeUser()!.posID ?? 0
            print("POSID \(posID)")
            getProfile(pos_id: posID)
        }
        
    }
   
    func addLeftButton() {
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 86, height: 28))
        viewFN.backgroundColor = .clear
        
        
        let button1 = UIButton(frame: CGRect(x: 0,y: -4, width: 40, height: 28))
        button1.setImage(UIImage(named: "img-logo4"), for: .normal)
        button1.contentMode = .scaleAspectFill
        
        let button2 = UIButton(frame: CGRect(x: 44,y: -4, width: 28, height: 28))
        button2.setImage(UIImage(named: "img-logo445"), for: .normal)
        button2.contentMode = .scaleAspectFill
      
        viewFN.addSubview(button1)
        viewFN.addSubview(button2)
        
        
        
        let leftBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowOffset = CGSize(width: 0, height: 5)
        self.navigationController?.navigationBar.shadowColor = "CECECE".color.withAlphaComponent(0.5)
        self.navigationController?.navigationBar.shadowOpacity = 0.8
        
    }

    @IBAction func openPrintersView(_ sender: UIButton) {
       
        
        let vc = UIStoryboard.init(name: "SettingsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "PrintersVC") as! PrintersVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openCustomerShowView(_ sender: UIButton) {
       
        let vc = UIStoryboard.init(name: "SettingsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomerShowVC") as! CustomerShowVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openTaxView(_ sender: UIButton) {
       
        let vc = UIStoryboard.init(name: "SettingsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "TaxVC") as! TaxVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //GeneralVC
    
    @IBAction func openGeneralView(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "SettingsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "GeneralVC") as! GeneralVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func submitLogOut(_ sender: UIButton) {
        
        if UserHelper.isLogin() {
            posID = UserHelper.lodeUser()!.posID ?? 0
            submitLogout(fcm_token: "1233", pos_id: posID)
        }
        
        
    }
    
}

//MARK: - API Request

extension SettingsVC {
    
    
    func submitLogout(fcm_token: String, pos_id: Int) {
        
        let urlRequest = APIConstant.logout
        print("urlRequest logout \(urlRequest)")
        
        var params = [String:Any]()
        params["fcm_token"] = "1234444"
        params["pos_id"] = pos_id
        
        print("PARAMS \(params)")
        SVProgressHUD.show()
        
        
        API.startRequest(url: urlRequest, method: .post, parameters: params, viewCon: self) { [self] (status, responesObject) in
            
            SVProgressHUD.dismiss()
            if status {
                
                do{
                    
                    //let object = try JSONDecoder().decode(UserOB.self, from: responesObject?.data as! Data)
                    UserHelper.deletUser()
                    self.delegate.presentLoginViewController(animated: true)
                    
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
    
    
    func getProfile(pos_id: Int)  {
        
        let requestUrl = APIConstant.profile + "\(pos_id)"
        print("requestUrl profile \(requestUrl)")
        
        SVProgressHUD.show()
        
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] (status, responesObject) in
            
            
            if status {
                
                do{
                    
                    let object = try JSONDecoder().decode(UserOB.self, from: responesObject?.data as! Data)
                    emailLbl.text = object.email ?? ""
                    
                    
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
