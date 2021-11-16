//
//  AllItemsVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/30/21.
//

import UIKit
import SVProgressHUD

class AllItemsVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: SearchView!
    
    var itemsArray = [ItemsOB]()
    var storeID = 0
    var currentPagee = 1
    var lastPagee = 0
    let refresher = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = refresher
         refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        searchView.txtSearch.addTarget(self, action: #selector(searchInAllItems), for: .editingChanged)
        
        
        initTV()
        addRightButton() 
        self.title = "العناصر"
        
        searchView.isHidden = true
        
        if UserHelper.isLogin() {
            storeID = UserHelper.lodeUser()!.storeID ?? 0
            getItemsFromServer(storeID: storeID, current_page: currentPagee)
        }
        
    }
    
    
    @objc func searchInAllItems(){
        
        
        if searchView.txtSearch.text == "" {
            if UserHelper.isLogin() {
                storeID = UserHelper.lodeUser()!.storeID ?? 0
                submitSearchInItems(storeID: storeID, name: searchView.txtSearch.text ?? "")
                getItemsFromServer(storeID: storeID, current_page: currentPagee)
            }
        }
    }
    
    @objc func refreshData(){
        if UserHelper.isLogin() {
            storeID = UserHelper.lodeUser()!.storeID ?? 0
            getItemsFromServer(storeID: storeID, current_page: currentPagee)
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        addNotificationObserver(.reloadItems, #selector(reloadItems))
    }
    
    
    
    @objc func reloadItems() {
        if UserHelper.isLogin() {
            storeID = UserHelper.lodeUser()!.storeID ?? 0
            getItemsFromServer(storeID: storeID, current_page: currentPagee)
        }
    }
    
    
    
    
    @IBAction func openSearch(_ sender: Any) {
        
        UIView.transition(with: searchView, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: { [self] in
                            searchView.isHidden = false
                          })
        
    }
    
    
    

    
    func addRightButton() {
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 28))
        viewFN.backgroundColor = .clear
        
        
        let button1 = UIButton(frame: CGRect(x: 0,y: -4, width: 40, height: 28))
        button1.setImage(UIImage(named: "img-barcode"), for: .normal)
        button1.contentMode = .scaleAspectFill
        
       
      
        viewFN.addSubview(button1)
      
        
        
        
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
  
    
    @IBAction func createOneItem(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "CreateNewItemTestVC") as! CreateNewItemTestVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
        
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
                if UserHelper.isLogin() {
                    storeID = UserHelper.lodeUser()!.storeID ?? 0
                    getItemsFromServer(storeID: storeID, current_page: currentPagee)
                }
                tableView.scrollToBottom()
            }
        }
    }
    
    
}



extension AllItemsVC: UITableViewDataSource, UITableViewDelegate {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllItemsTVC", for: indexPath) as! AllItemsTVC
        cell.selectionStyle = .none
        
        let item = itemsArray[indexPath.row]
        cell.configure(data: item)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ShowEditItemVC") as! ShowEditItemVC
        
        let item = itemsArray[indexPath.row]
        vc.selectedItemID = item.id!
        
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK: - API Request

extension AllItemsVC {
    
    
    
    func getItemsFromServer(storeID: Int, current_page: Int) {
        SVProgressHUD.show()
        //?page=1&store_id=33
        let requestUrl = APIConstant.getAllItems + "?page=\(current_page)&store_id=\(storeID)"
        print("requestUrl get All Items \(requestUrl)")
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
                
                if self.refresher.isRefreshing {
                    self.refresher.endRefreshing()
                }
                self.tableView.tableFooterView = nil
                
                do{
                    let object = try JSONDecoder().decode([ItemsOB].self, from: responseObject?.data as! Data)
                   
                    
                    if currentPagee == 1{
                        itemsArray.removeAll()
                    }
                    
                    
                    itemsArray.append(contentsOf: object)
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
    
    
    func submitSearchInItems(storeID: Int, name: String) {
      
   
        let requestUrl = APIConstant.getAllItems + "?name=\(name)&store_id=\(storeID)"
        print("requestUrl get All Items \(requestUrl)")
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
                
             
                do{
                    let object = try JSONDecoder().decode([ItemsOB].self, from: responseObject?.data as! Data)
                   
                    itemsArray.removeAll()
                    itemsArray.append(contentsOf: object)
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
