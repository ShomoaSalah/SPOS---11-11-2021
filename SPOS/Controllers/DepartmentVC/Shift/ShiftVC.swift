//
//  ShiftVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit
import SVProgressHUD

class ShiftVC: BaseVC {
    
    @IBOutlet weak var openAgainShiftMenuView: UIView!
    @IBOutlet weak var amountTF: UITextField!
    
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var shiftNumberLbl: UILabel!
    @IBOutlet weak var openedTimeFormatLbl: UILabel!
    
    @IBOutlet weak var startingCashLbl: UILabel!
    @IBOutlet weak var cashPaymentLbl: UILabel!
    @IBOutlet weak var cashRefundsLbl: UILabel!
    @IBOutlet weak var paidInLbl: UILabel!
    @IBOutlet weak var paidOutLbl: UILabel!
    @IBOutlet weak var expectedCashAmountLbl: UILabel!
    @IBOutlet weak var expectedCashAmountStateLbl: UILabel!
    
    @IBOutlet weak var grossSalesLbl: UILabel!
    @IBOutlet weak var refundsLbl: UILabel!
    @IBOutlet weak var discountsLbl: UILabel!
    @IBOutlet weak var netSalesLbl: UILabel!
    @IBOutlet weak var taxesLbl: UILabel!
    @IBOutlet weak var totalTenderedLbl: UILabel!
    
    var canOpenShiftDetails = false
    
    
    var shiftObject: Shift?
    var cashDrawerObject: CashDrawer?
    var salesSummary: SalesSummary?
    var shiftID = 0
    var posID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "المناوبة"
//        print("canOpenShiftDetails")
        if canOpenShiftDetails {
            openAgainShiftMenuView.isHidden = true
            showShift(shift_id: shiftID)
        }else {
            openAgainShiftMenuView.isHidden = false
            noDataView.isHidden = false
        }
        
        
       
        addRightButton() 
    }
   
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        addNotificationObserver(.reloadShift, #selector(reloadShift))
    }
    
    @objc func reloadShift() {
        openAgainShiftMenuView.isHidden = false
        noDataView.isHidden = false
    }
    
    @IBAction func submitOpenShift(_ sender: UIButton) {
        
        if UserHelper.isLogin() {
            posID = UserHelper.lodeUser()!.posID ?? 0
            submitOpenShift(pos_id: posID, amount: amountTF.text ?? "")
        }
        
    }
    
    
    
    func addRightButton() {
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 28))
        viewFN.backgroundColor = .clear
        
        let button1 = UIButton(frame: CGRect(x: 0,y: -4, width: 24, height: 28))
        button1.setImage(UIImage(named: "img-shift"), for: .normal)
        button1.contentMode = .scaleAspectFill
        button1.addTarget(self, action: #selector(didTapOnShiftBtn), for: .touchUpInside)
        
        viewFN.addSubview(button1)
        
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    @objc func didTapOnShiftBtn(){
        //ShiftListVC
        let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ShiftListVC") as! ShiftListVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func didTapOnCash(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "CashManagementVC") as! CashManagementVC
        vc.shiftID = self.shiftID
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func didTapOnShiftClosure(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ShiftClosureVC") as! ShiftClosureVC
        vc.shiftID = self.shiftID
        vc.expectedCashAmount = cashDrawerObject?.expectedCashAmount ?? ""
        
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}



//MARK: - API Request

extension ShiftVC {
    
    
    func showShift(shift_id: Int)  {
        
        let requestUrl = APIConstant.showShift + "\(shift_id)"
        print("requestUrl show Shift \(requestUrl)")
        
        SVProgressHUD.show()
       
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] (status, responesObject) in
          
            if status {
                noDataView.isHidden = true
                
                do{
                    
                    let object = try JSONDecoder().decode(ShiftOB.self, from: responesObject?.data as! Data)
                    
                    shiftObject = object.shift
                    cashDrawerObject = object.cashDrawer
                    salesSummary = object.salesSummary
                   
                    fillShiftObject(by: shiftObject!)
                    fillCashDrawerObject(by: cashDrawerObject!)
                    fillSalesSummaryObject(by: salesSummary!)
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
    
    
    func fillShiftObject(by shiftObject: Shift) {
        shiftNumberLbl.text = shiftObject.shiftNumber?.description ?? "0"
        openedTimeFormatLbl.text = shiftObject.openedTimeFormat ?? "0"
    }
    
    func fillCashDrawerObject(by cashDrawerObject: CashDrawer) {
        
        startingCashLbl.text = cashDrawerObject.startingCash ?? "0"
        cashPaymentLbl.text = cashDrawerObject.cashPayment ?? "0"
        cashRefundsLbl.text = cashDrawerObject.cashRefunds ?? "0"
        paidInLbl.text = cashDrawerObject.paidIn ?? "0"
        paidOutLbl.text = cashDrawerObject.paidOut ?? "0"
        expectedCashAmountLbl.text = cashDrawerObject.expectedCashAmount ?? "0"
        expectedCashAmountStateLbl.text = cashDrawerObject.expectedCashAmountState?.description ?? "0"
    }
    
    func fillSalesSummaryObject(by salesSummary: SalesSummary) {
      
        grossSalesLbl.text = salesSummary.grossSales ?? "0"
        refundsLbl.text = salesSummary.refunds ?? "0"
        discountsLbl.text = salesSummary.discounts ?? "0"
        netSalesLbl.text = salesSummary.netSales ?? "0"
        taxesLbl.text = salesSummary.taxes ?? "0"
        totalTenderedLbl.text = salesSummary.totalTendered ?? "0"
    }
    
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
                
                openAgainShiftMenuView.isHidden = true
                //noDataView.isHidden = true
                showShift(shift_id: shiftID)
                
//                do{
//
//                    let object = try JSONDecoder().decode(ShiftOB.self, from: responesObject?.data as! Data)
//
//
//                    postNotificationCenter(.openShift)
//                    self.navigationController?.popToViewController(ofClass: CustomTabBar.self, animated: true)
//
//
//
//                }catch{
//                    self.navigationController?.view.makeToast(error.localizedDescription)
//                    print(error.localizedDescription)
//                }
                
            }
            
            else{
                self.navigationController?.view.makeToast((responesObject?.message!)!)
            }
            
        }
    }
    
}
