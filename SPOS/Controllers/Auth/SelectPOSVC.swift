//
//  SelectPOSVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/24/21.
//

import UIKit
import SVProgressHUD

class SelectPOSVC: UIViewController {
    
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var myPOS = [MyPOSOB]()
    
    var selectedStoreName = ""
    var selectedStoreID = 0
    var selectedPOSID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTV()
        getPOS(storeID: selectedStoreID)
        self.title = NSLocalizedString("SelectPOS", comment: "")
        continueBtn.applyGradientUIButton(colours: ["0386E8".color, "0CA7EE".color], gradientOrientation: .horizontal)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowOffset = CGSize(width: 0, height: 10)
        self.navigationController?.navigationBar.shadowColor = "CECECE".color.withAlphaComponent(0.5)
        self.navigationController?.navigationBar.shadowOpacity = 0.8
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowOffset = CGSize(width: 0, height: 0)
        self.navigationController?.navigationBar.shadowColor = .clear
        self.navigationController?.navigationBar.shadowOpacity = 0.0
        
    }
    
    @IBAction func submitPOS(_ sender: UIButton) {
        choosePOSby(pos_id: selectedPOSID)
    }
    
}



extension SelectPOSVC: UITableViewDelegate, UITableViewDataSource {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPOS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPOSTVC", for: indexPath) as! SelectPOSTVC
        cell.selectionStyle = .none
        
        let item = myPOS[indexPath.row]
        cell.configure(data: item)
        
        if indexPath.row == 0 {
            //        if item.id  == country_uuid {
            cell.isSelected = true
            selectedPOSID = item.id ?? 0
            cell.selectedPOSImage.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
            }
            
        } else {
            cell.isSelected = false
            cell.selectedPOSImage.isHidden = true
        }
        cell.setSelected(cell.isSelected, animated: true)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! SelectPOSTVC
        
        
        let item = myPOS[indexPath.row]
        selectedPOSID = item.id ?? 0
        selectedStoreName = item.name ?? ""
        selectedStoreID = item.id ?? 0
        cell.selectedPOSImage.isHidden = false
        cell.setSelected(true, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SelectPOSTVC
        cell.selectedPOSImage.isHidden = true
        cell.setSelected(false, animated: true)
    }
    
}




//MARK: - API Request

extension SelectPOSVC {
    
    //?store_id=33
    func getPOS(storeID: Int) {
        
        
        let requestUrl = APIConstant.myPOS + "?store_id=\(storeID)"
        print("requestUrl get myPOS \(requestUrl)")
        
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self](status, responesObject) in
            if status {
                do{
                    
                    let object = try JSONDecoder().decode([MyPOSOB].self, from: responesObject?.data as! Data)
                    myPOS = object
                    
                    tableView.reloadData()
                    
                }catch{
                    self.view.makeToast(responesObject?.message ?? "")
                }
                
            }else{
                self.view.makeToast(responesObject?.message ?? "")
            }
        }
        
    }
    
    
    func choosePOSby(pos_id: Int) {
        
        let urlRequest = APIConstant.choosePos
        print("urlRequest choose POS \(urlRequest)")
        
        var params = [String:Any]()
        params["pos_id"] = pos_id
        params["fcm_token"] = "qwqw"
        params["device"] = "ios"
        
        print("PARAMS \(params)")
        
        SVProgressHUD.show()
        API.startRequest(url: urlRequest, method: .post, parameters: params, viewCon: self) { [self] (status, responesObject) in
            
            SVProgressHUD.dismiss()
            if status {
                
                do{
                    
                    let object = try JSONDecoder().decode(UserOB.self, from: responesObject?.data as! Data)
                     
                    if UserHelper.lodeUser()?.token == "" {
                        UserHelper.saveUser(user: object)
                    }
                    
                  
                    
                    SplashAnimationVC.checkUserState(isCompleted: object.isCompleted ?? "", object: object, view: self)
                    
                    
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
