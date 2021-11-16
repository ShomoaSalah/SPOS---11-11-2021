//
//  ShiftClosureVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit
import SVProgressHUD

class ShiftClosureVC: BaseVC {

    @IBOutlet weak var differenceLbl: UILabel!
    @IBOutlet weak var expectedCashAmountTF: UITextField!
    @IBOutlet weak var actualCashAmountTF: UITextField!
    
    var shiftID = 0
    var expectedCashAmount = ""
    var difference = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        expectedCashAmountTF.text = expectedCashAmount
        
        print("expectedCashAmountTF.text! \(expectedCashAmount.description)")
        
        expectedCashAmountTF.isUserInteractionEnabled = false
        
        actualCashAmountTF.addTarget(self, action: #selector(calculateDifference), for: .editingDidEnd)
        self.title = "إقفال المناوبة"
    }
    
  
    
    @objc func calculateDifference(){
        
        let actualCashAmountInt = Int(actualCashAmountTF.text!)
        
        if expectedCashAmount == "0.00" {
            differenceLbl.text = actualCashAmountInt?.description
        }else {
            
            let expectedCashAmountInt = Int(expectedCashAmount)
            difference = actualCashAmountInt!
            difference -= expectedCashAmountInt!
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                differenceLbl.text = "\(difference)"
            }
            
        }
        
      
        
    }
    
    @IBAction func didTapOnShiftClosure(_ sender: UIButton) {
        
        submitCLoseShift(shift_id: shiftID, actual_cash_amount: actualCashAmountTF.text ?? "")
        
    }
    


}


extension ShiftClosureVC {
    
    func submitCLoseShift(shift_id: Int, actual_cash_amount: String?) {
        
        let urlRequest = APIConstant.closeShift
        print("urlRequest close Shift \(urlRequest)")
        
        var params = [String:Any]()
        params["shift_id"] = shift_id
        params["actual_cash_amount"] = actual_cash_amount
        
        print("PARAMS \(params)")
        
        SVProgressHUD.show()
        
        API.startRequest(url: urlRequest, method: .post, parameters: params, viewCon: self) { [self] (status, responesObject) in
            
            SVProgressHUD.dismiss()
            if status {
                
                postNotificationCenter(.reloadShift)
                
                postNotificationCenter(.closeShift)
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    self.navigationController?.popViewController(animated: true)
                }
                
//                let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ShiftIsClosedVC") as! ShiftIsClosedVC
//                self.navigationItem.hideBackWord()
//                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            else{
                self.navigationController?.view.makeToast((responesObject?.message!)!)
            }
            
        }
    }
    
}
