//
//  CashManagementVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit
import SVProgressHUD



class CashManagementVC: BaseVC {

    @IBOutlet weak var commentTF: UITextField!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var payInPayOutTitleLbl: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    
    var cashManagementArray = [CashManagementOB]()
    var shiftID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showCashManagement(shift_id: shiftID)
        initTV()
        self.title = "إدارة النقدية"
        
    }
    

    @IBAction func submitPayInAction(_ sender: UIButton) {
        
        guard let amount = amountTF.text, !amount.isEmptyStr else {
            self.navigationController?.view.makeToast(NSLocalizedString("amountRequired", comment: ""))
            return
        }
       
        
        addCashManagements(shift_id: shiftID, amount: amountTF.text!, comment: commentTF.text ?? "", type: 1)
        
    }
    
    
    @IBAction func submitPayOutAction(_ sender: UIButton) {
        
        guard let amount = amountTF.text, !amount.isEmptyStr else {
            self.navigationController?.view.makeToast(NSLocalizedString("amountRequired", comment: ""))
            return
        }
       
        
        addCashManagements(shift_id: shiftID, amount: amountTF.text!, comment: commentTF.text ?? "", type: 2)
        
    }
    
    
    
}

//MARK: - TableView

extension CashManagementVC: UITableViewDataSource, UITableViewDelegate {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cashManagementArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CashManagementTVC", for: indexPath) as! CashManagementTVC
        cell.selectionStyle = .none
        
        let item = cashManagementArray[indexPath.row]
        cell.configure(data: item)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = UIStoryboard.init(name: "ReceiptsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReceiptsDetailsVC") as! ReceiptsDetailsVC
//        self.navigationItem.hideBackWord()
//        self.navigationController?.pushViewController(vc, animated: true)
  
    }
    
}


//MARK: - API Request

extension CashManagementVC {
    
    func showCashManagement(shift_id: Int)  {
        
        let requestUrl = APIConstant.getCashManagements + "\(shift_id)"
        print("requestUrl get Cash Managements \(requestUrl)")
        
        SVProgressHUD.show()
       
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] (status, responesObject) in
          
            if status {
                noDataView.isHidden = true
                
                do{
                    
                    let object = try JSONDecoder().decode([CashManagementOB].self, from: responesObject?.data as! Data)
                    cashManagementArray = object
                    
                    if cashManagementArray.count == 0 {
                        payInPayOutTitleLbl.isHidden = false
                        tableView.layoutTableHeaderView()
                    }
                        //
                    tableView.reloadData()
                 
                    
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
    
    func addCashManagements(shift_id: Int, amount: String, comment: String?, type: Int)  {
        
        let urlRequest = APIConstant.addCashManagements
        print("urlRequest addCashManagements \(urlRequest)")
        
        var params = [String:Any]()
        params["shift_id"] = shift_id
        params["amount"] = amount
        params["comment"] = comment
        params["type"] = type
        
        print("PARAMS \(params)")
        SVProgressHUD.show()
        
        
        API.startRequest(url: urlRequest, method: .post, parameters: params, viewCon: self) { [self] (status, responesObject) in
            
            SVProgressHUD.dismiss()
            if status {
                
                do{
                    _ = try JSONDecoder().decode([CashManagementOB].self, from: responesObject?.data as! Data)
                    
                    showCashManagement(shift_id: shift_id)
                    
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
