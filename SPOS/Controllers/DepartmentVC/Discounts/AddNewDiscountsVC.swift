//
//  AddNewDiscountsVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit
import SVProgressHUD

class AddNewDiscountsVC: BaseVC {
    
    @IBOutlet weak var percentageTitleLbl: UILabel!
    @IBOutlet weak var percentageView: UIView!
    
    @IBOutlet weak var discountNameTF: UITextField!
    @IBOutlet weak var discountAmountTF: UITextField!
    
    var storeID = 0
    var selectedType = ""
    
    @IBOutlet weak var priceTitleLbl: UILabel!
    @IBOutlet weak var priceView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "إنشاء خصم"
        selectedType = "percentage"
        
        if UserHelper.isLogin() {
            storeID = UserHelper.lodeUser()!.storeID ?? 0
        }
        
    }
    
    
    @IBAction func selectOne(_ sender: UIButton) {
        
        
        switch sender.tag {
        case 0:
            
            percentageView.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            percentageTitleLbl.textColor = "0CA7EE".color
            priceView.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            priceTitleLbl.textColor = "C3C5CE".color
            selectedType = "percentage"
            break
     
        case 1:
            
            priceView.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            priceTitleLbl.textColor = "0CA7EE".color
            percentageView.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            percentageTitleLbl.textColor = "C3C5CE".color
            selectedType = "fixed"
            break

        default:
            break
        }
        
        
    }
    
    @IBAction func addNewDiscount(_ sender: UIButton) {
      
        guard let discountName = discountNameTF.text, !discountName.isEmptyStr else {
            self.navigationController?.view.makeToast(NSLocalizedString("discountNameRequired", comment: ""))
            return
        }
        guard !selectedType.isEmptyStr else {
            self.navigationController?.view.makeToast(NSLocalizedString("selectedTypeRequired", comment: ""))
            return
        }
//        guard storeID != 0 else {
//            self.navigationController?.view.makeToast(NSLocalizedString("storeRequired", comment: ""))
//            return
//        }
        
        addNewDiscount(store_id: storeID, amount: discountAmountTF.text!, type: selectedType, name: discountNameTF.text!)

    }
    
    
    
}

//MARK: - API Request

extension AddNewDiscountsVC {
    
   
    
    func addNewDiscount(store_id: Int, amount: String, type: String, name: String) {
        
        let urlRequest = APIConstant.addDiscount
        print("urlRequest add Discount \(urlRequest)")
        
        var params = [String:Any]()
        params["store_id"] = store_id
        params["amount"] = amount
        params["type"] = type
        params["name"] = name
        
        print("PARAMS \(params)")
        SVProgressHUD.show()
        
        
        API.startRequest(url: urlRequest, method: .post, parameters: params, viewCon: self) { [self] (status, responesObject) in
            
            SVProgressHUD.dismiss()
            if status {
                
                self.view.makeToast(responesObject?.message)
                postNotificationCenter(.reloadDiscounts)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.navigationController?.popViewController(animated: true)
                    
                }
            }
            
            else{
                self.navigationController?.view.makeToast((responesObject?.message!)!)
            }
            
        }
    }
    
}
    

