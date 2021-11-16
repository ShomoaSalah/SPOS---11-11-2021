//
//  ShiftIsClosedVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit
import SVProgressHUD

class ShiftIsClosedVC: BaseVC {

    @IBOutlet weak var amountTF: UITextField!
    
    var posID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "إقفال المناوبة"
       
    }
 
    @IBAction func submitOpenShift(_ sender: UIButton) {
        
        if UserHelper.isLogin() {
            posID = UserHelper.lodeUser()!.posID ?? 0
            submitOpenShift(pos_id: posID, amount: amountTF.text ?? "")
        }
    }
    
}


extension ShiftIsClosedVC {
    
    
    func submitOpenShift(pos_id: Int, amount: String?) {
        
        
        let urlRequest = APIConstant.openShift
        print("urlRequest open Shift \(urlRequest)")
        
        var params = [String:Any]()
        params["pos_id"] = pos_id
        params["amount"] = amount
        
        print("PARAMS \(params)")
        SVProgressHUD.show()
        
        
        API.startRequest(url: urlRequest, method: .post, parameters: params, viewCon: self) { [self] (status, responesObject) in
            
            SVProgressHUD.dismiss()
            if status {
                
                do{
                    
                    let object = try JSONDecoder().decode(ShiftOB.self, from: responesObject?.data as! Data)
                 
                    
                    postNotificationCenter(.openShift)
                    self.navigationController?.popToViewController(ofClass: CustomTabBar.self, animated: true)
                    
                    
                    
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
