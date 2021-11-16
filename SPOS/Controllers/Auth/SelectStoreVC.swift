//
//  SelectStoreVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/24/21.
//

import UIKit
import SVProgressHUD

class SelectStoreVC: UIViewController {

    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var myStores = [MyStoresOB]()
    
    var selectedStoreName = ""
    var selectedStoreID = 0
    var selectedPOSCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTV()
        getStores()
        
        self.title = NSLocalizedString("SelectStore", comment: "")
        
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
    
    @IBAction func submitStore(_ sender: UIButton) {
        
        chooseStoreby(store_id: selectedStoreID)
    }
    

}

extension SelectStoreVC: UITableViewDelegate, UITableViewDataSource {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myStores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectStoreTVC", for: indexPath) as! SelectStoreTVC
        cell.selectionStyle = .none
        
        let item = myStores[indexPath.row]
        cell.configure(data: item)
        
        if indexPath.row == 0 {
//        if item.id  == country_uuid {
            cell.isSelected = true
            selectedStoreID = item.id ?? 0
            print("selectedStoreID \(selectedStoreID)")
            cell.selectedStoreImage.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
            }
            
        } else {
            cell.isSelected = false
            cell.selectedStoreImage.isHidden = true
        }
        cell.setSelected(cell.isSelected, animated: true)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SelectStoreTVC
        
        let item = myStores[indexPath.row]
        selectedStoreName = item.name ?? ""
        selectedStoreID = item.id ?? 0
        selectedPOSCount = item.posCount!
        print("selectedStoreID didSelectRowAt \(selectedStoreID)")
        print("selectedPOSCount \(selectedPOSCount)")
        cell.selectedStoreImage.isHidden = false
        cell.setSelected(true, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SelectStoreTVC
        cell.selectedStoreImage.isHidden = true
        cell.setSelected(false, animated: true)
    }
    
}




//MARK: - API Request

extension SelectStoreVC {
   
    func getStores() {
        SVProgressHUD.show()
        API.getStoresList { [self]  myStoresArray, status, msg in
            SVProgressHUD.dismiss()
            if status {
                myStores = myStoresArray
                tableView.reloadData()
                
            }else {
                self.navigationController?.view.makeToast(msg)
            }
        }
    }
    
    func chooseStoreby(store_id: Int) {
        
        let urlRequest = APIConstant.chooseStore
        print("urlRequest choose Store \(urlRequest)")
        
        var params = [String:Any]()
        params["store_id"] = store_id
        
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

