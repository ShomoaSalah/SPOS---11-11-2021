//
//  OpenShiftHomeVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit
import SVProgressHUD

class OpenShiftHomeVC: BaseVC {

    var pos_id = 0
    
    @IBOutlet weak var amountTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "فتح المناوبة"
    }
    

    @IBAction func submitOpen(_ sender: UIButton) {
        
        let amountInt = Int(amountTF.text!)
        submitOpenShift(pos_id: pos_id, amount: amountInt ?? 0)
      
    }
    

}


//MARK:  - API Request

extension OpenShiftHomeVC {
    
    func submitOpenShift(pos_id: Int, amount: Int?) {
        
        
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
                    self.navigationController?.popViewController(animated: true)
                    
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
