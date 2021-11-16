//
//  EditNewDiscountsVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit
import SVProgressHUD

class EditNewDiscountsVC: BaseVC {

    
    @IBOutlet weak var percentageTitleLbl: UILabel!
    @IBOutlet weak var percentageView: UIView!
    @IBOutlet weak var priceTitleLbl: UILabel!
    @IBOutlet weak var priceView: UIView!
    
    
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    
    var discountsOB: DiscountsOB?
    var storeID = 0
    var selectedType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("storeID \(storeID)")
        setData()
        self.title = "تعديل خصم"
        if UserHelper.isLogin() {
            storeID = UserHelper.lodeUser()!.storeID ?? 0
        }
    }
    
    
    func setData() {
        amountTF.text = discountsOB?.amountValue
        nameTF.text = discountsOB?.name
        
        switch discountsOB?.type {
        case "percentage":
            percentageView.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            percentageTitleLbl.textColor = "0CA7EE".color
            
            priceView.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            priceTitleLbl.textColor = "C3C5CE".color
            
            selectedType = "percentage"
            break
        case "fixed":
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

    @IBAction func submitDelete(_ sender: UIButton) {
        deleteDiscount(discountID: discountsOB?.id ?? 0)
    }
    
    @IBAction func submitEditDiscount(_ sender: UIButton) {
        
        editDiscount(discount_id: discountsOB!.id!, amount: (amountTF.text ?? discountsOB?.amountValue)!, type: selectedType, name: (nameTF.text ?? discountsOB?.name)!)
    }
    
    
    
}

//MARK: - API Request

extension EditNewDiscountsVC {
    
    
    func deleteDiscount(discountID: Int) {
        
        let urlRequest = APIConstant.deleteDiscount + "?discount_ids[0]=\(discountID)"
        print("urlRequest delete Discount \(urlRequest)")
        
        SVProgressHUD.show()
        
        API.startRequest(url: urlRequest, method: .delete, parameters: nil, viewCon: self) { [self] (status, responesObject) in
            
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
    
   
    func editDiscount(discount_id: Int, amount: String, type: String, name: String) {
        
        let urlRequest = APIConstant.editDiscount
        print("urlRequest edit Discount \(urlRequest)")
        
        var params = [String:Any]()
        params["discount_id"] = discount_id
        params["amount"] = amount
        params["type"] = type
        params["name"] = name
        
        print("PARAMS \(params)")
        
        
        SVProgressHUD.show()
        
        
        API.startRequest(url: urlRequest, method: .put, parameters: params, viewCon: self) { [self] (status, responesObject) in
            
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
