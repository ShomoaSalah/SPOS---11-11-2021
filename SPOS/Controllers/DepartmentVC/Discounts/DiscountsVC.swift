//
//  DiscountsVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit
import SVProgressHUD

class DiscountsVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: SearchView!
    
    var discountArray = [DiscountsOB]()
    var storeID = 0
    var posID = 0
    
    var currentPagee = 1
    var lastPagee = 0
    let refresher = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        searchView.txtSearch.addTarget(self, action: #selector(searchInDiscounts), for: .editingChanged)
        
        tableView.refreshControl = refresher
         refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        getDiscountList(current_page: currentPagee)
        if UserHelper.isLogin() {
            posID = UserHelper.lodeUser()!.posID ?? 0
            getProfile(pos_id: posID)
        }
        
        initTV()
        self.title = "الخصومات"
    }
    
    @objc func searchInDiscounts(){
        
        submitSearchDiscountList(name: searchView.txtSearch.text ?? "")

        if searchView.txtSearch.text == "" {
            getDiscountList(current_page: currentPagee)
            if UserHelper.isLogin() {
                posID = UserHelper.lodeUser()!.posID ?? 0
                getProfile(pos_id: posID)
            }
        }
    }
    
    
    @objc func refreshData(){
        getDiscountList(current_page: currentPagee)
        if UserHelper.isLogin() {
            posID = UserHelper.lodeUser()!.posID ?? 0
            getProfile(pos_id: posID)
        }
        
    }
    
    @IBAction func createOneItem(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddNewDiscountsVC") as! AddNewDiscountsVC
        vc.storeID = self.storeID
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        addNotificationObserver(.reloadDiscounts, #selector(reloadDiscounts))
    }
    
    
    
    @objc func reloadDiscounts() {
        getDiscountList(current_page: currentPagee)
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        
        if ((scrollOffset + scrollViewHeight) >= (scrollContentSizeHeight)){
            print(currentPagee,lastPagee)
            if currentPagee < lastPagee{
                currentPagee += 1
                self.tableView.tableFooterView = createSpinnerFooter()
                getDiscountList(current_page: currentPagee)
                tableView.scrollToBottom()
            }
        }
    }
    
}


extension DiscountsVC: UITableViewDataSource, UITableViewDelegate {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discountArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscountsTVC", for: indexPath) as! DiscountsTVC
        cell.selectionStyle = .none
        
        let item = discountArray[indexPath.row]
        cell.configure(data: item)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditNewDiscountsVC") as! EditNewDiscountsVC
      
        let item = discountArray[indexPath.row]
        
        vc.discountsOB = item
        vc.storeID = self.storeID
        
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - API Request

extension DiscountsVC {
  
    func getDiscountList(current_page: Int) {
        SVProgressHUD.show()
        
        let requestUrl = APIConstant.getDiscounts + "?page=\(current_page)"
        print("requestUrl get Discounts \(requestUrl)")
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
                
                if self.refresher.isRefreshing {
                    self.refresher.endRefreshing()
                }
                self.tableView.tableFooterView = nil
                
                do{
                    let object = try JSONDecoder().decode([DiscountsOB].self, from: responseObject?.data as! Data)
                   
                 
                    if currentPagee == 1{
                        discountArray.removeAll()
                    }
                    
                    
                    discountArray.append(contentsOf: object)
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
    
    func getProfile(pos_id: Int)  {
        
        let requestUrl = APIConstant.profile + "\(pos_id)"
        print("requestUrl profile \(requestUrl)")
        
        SVProgressHUD.show()
        
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] (status, responesObject) in
            
            
            if status {
                
                do{
                    
                    let object = try JSONDecoder().decode(UserOB.self, from: responesObject?.data as! Data)
                    storeID = object.storeID ?? 0

                    
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
    
    func submitSearchDiscountList(name: String) {
        //{{url}}/api/pos/discounts?name=discount1
        let requestUrl = APIConstant.getDiscounts + "?name=\(name)"
        print("requestUrl search Discounts \(requestUrl)")
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
                
            
                do{
                    let object = try JSONDecoder().decode([DiscountsOB].self, from: responseObject?.data as! Data)
                   
                 
                    discountArray.removeAll()
                    discountArray.append(contentsOf: object)
                    initTV()
                   
                    
                }catch{
                    self.view.makeToast(responseObject?.message ?? "")
                }
                
            }else {
                self.view.makeToast(responseObject?.message ?? "")
            }
        }
    }
    
}
