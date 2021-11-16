//
//  DepartmentVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/30/21.
//

import UIKit
import SVProgressHUD

class DepartmentVC: BaseVC {
    
    var posID = 0
    var shiftID = 0
    var canOpenShiftDetails = false
    
    @IBOutlet weak var shiftView: UIView!
    @IBOutlet weak var noDataView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.title = "الأقسام"
        addLeftButton()
        
        
        if UserHelper.isLogin() {
            posID = UserHelper.lodeUser()!.posID ?? 0
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
    
    
    
    @IBAction func openAllItemsView(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "AllItemsVC") as! AllItemsVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func openCategoriesView(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "CategoriesVC") as! CategoriesVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func openDiscountsView(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "DiscountsVC") as! DiscountsVC
        
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func openCustomersView(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomersVC") as! CustomersVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openShiftView(_ sender: UIButton) {
        
        if UserHelper.isLogin() {
            posID = UserHelper.lodeUser()!.posID ?? 0
            getProfile(pos_id: posID)
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            
            let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ShiftVC") as! ShiftVC
            
            vc.canOpenShiftDetails = canOpenShiftDetails
            vc.shiftID = shiftID
            
            self.navigationItem.hideBackWord()
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
        
        
    }
    
}



//MARK: - API Request

extension DepartmentVC {
    
    func getProfile(pos_id: Int)  {
        
        let requestUrl = APIConstant.profile + "\(pos_id)"
        print("requestUrl profile \(requestUrl)")
        
        SVProgressHUD.show()
        
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] (status, responesObject) in
            
            
            if status {
                
                do{
                    
                    let object = try JSONDecoder().decode(UserOB.self, from: responesObject?.data as! Data)
                    shiftID = object.shiftID ?? 0
                    print("Completed \(object.isCompleted)")
                    print("getProfile \(object.isShiftMenu ?? false) ... \(object.isShift ?? false)")
                    
                    if object.isShiftMenu ?? false  {
                        shiftView.isHidden = false
                    }else {
                        shiftView.isHidden = true
                    }
                    
                    if object.isShift ?? false {
                        postNotificationCenter(.openShift)
                        canOpenShiftDetails = true
                       
                    }else {
                        postNotificationCenter(.closeShift)
                        canOpenShiftDetails = false
                    }
                    
                    
                    noDataView.isHidden = true
                }catch{
                    self.navigationController?.view.makeToast(error.localizedDescription)
                    print(error.localizedDescription)
                }
                
                
            }
            
            else{
                noDataView.isHidden = false
                self.navigationController?.view.makeToast((responesObject?.message!)!)
            }
            
        }
    }
    
}
