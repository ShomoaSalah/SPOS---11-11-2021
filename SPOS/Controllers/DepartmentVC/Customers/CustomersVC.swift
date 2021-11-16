//
//  CustomersVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit
import SVProgressHUD


class CustomersVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: SearchView!
    
    var currentPagee = 1
    var lastPagee = 0
    let refresher = UIRefreshControl()
    var customersArray = [CustomersOB]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTV()
        self.title = "العملاء"
        
        tableView.refreshControl = refresher
        refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        
        
    }
    
    
    @objc func refreshData(){
        
      
    }
    
    

    @IBAction func createOneItem(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddNewCustomersVC") as! AddNewCustomersVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

}



extension CustomersVC: UITableViewDataSource, UITableViewDelegate {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customersArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomersTVC", for: indexPath) as! CustomersTVC
        cell.selectionStyle = .none
        
        
        //customersArray
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditNewCustomersVC") as! EditNewCustomersVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK: - API Request

extension CustomersVC {
    
    func showCustomers(current_page: Int) {
        SVProgressHUD.show()
        
        let requestUrl = APIConstant.getCustomers + "?page=\(current_page )"
        print("requestUrl get Customers \(requestUrl)")
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
                
                if self.refresher.isRefreshing {
                    self.refresher.endRefreshing()
                }
                self.tableView.tableFooterView = nil
                
                do{
                    let object = try JSONDecoder().decode([CustomersOB].self, from: responseObject?.data as! Data)
                   
                 
                    if currentPagee == 1{
                        customersArray.removeAll()
                    }
                    
                    
                    customersArray.append(contentsOf: object)
                    initTV()
                    
                    
                    let pages =  try! JSONDecoder().decode(PagesOB.self, from: responseObject?.pages as! Data)
                    
                    currentPagee = pages.currentPage!
                    lastPagee = pages.lastPage!
                    
                    
                }catch{
                    self.view.makeToast(responseObject?.message ?? "")
                }
                
            }else {
                self.view.makeToast(responseObject?.message ?? "")
            }
        }
    }
    
}
