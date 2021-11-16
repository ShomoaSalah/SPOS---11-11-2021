//
//  CategoriesVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit
import SVProgressHUD

class CategoriesVC: BaseVC {

    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var tableView: UITableView!
    var categorieArray = [CategorieOB]()
    
    var currentPagee = 1
    var lastPagee = 0
    let refresher = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.refreshControl = refresher
         refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        searchView.txtSearch.addTarget(self, action: #selector(searchInCategories), for: .editingChanged)
        getCategoriesFromServer(current_page: currentPagee)
        initTV()
        self.title = "الفئات"
        
    }
    
    @objc func searchInCategories(){
        
        submitSearcgFromCategories(name: searchView.txtSearch.text ?? "")
        if searchView.txtSearch.text == "" {
            getCategoriesFromServer(current_page: currentPagee)
        }
    }
    
    
    @objc func refreshData(){
        getCategoriesFromServer(current_page: currentPagee)
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
               
                getCategoriesFromServer(current_page: currentPagee)
                
                tableView.scrollToBottom()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        addNotificationObserver(.reloadCategories, #selector(reloadCategories))
    }
    
    
    
    @objc func reloadCategories() {
        getCategoriesFromServer(current_page: currentPagee)
    }
    
    
    @IBAction func createOneItem(_ sender: UIButton) {

        let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddNewCategoriesVC") as! AddNewCategoriesVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

}


extension CategoriesVC: UITableViewDataSource, UITableViewDelegate {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorieArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTVC", for: indexPath) as! CategoriesTVC
        cell.selectionStyle = .none
        
        let item = categorieArray[indexPath.row]
        cell.configure(data: item)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditNewCategoriesVC") as! EditNewCategoriesVC
        
        let item = categorieArray[indexPath.row]
        
        vc.categoryOB = item
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - API Request


extension CategoriesVC {
    
    
    func getCategoriesFromServer(current_page: Int) {
        SVProgressHUD.show()
        
        let requestUrl = APIConstant.getCategories + "?page=\(current_page)"
        print("requestUrl categories \(requestUrl)")
        
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
                
                if self.refresher.isRefreshing {
                    self.refresher.endRefreshing()
                }
                self.tableView.tableFooterView = nil
                
                do{
                    let object = try JSONDecoder().decode([CategorieOB].self, from: responseObject?.data as! Data)
                   
                    if currentPagee == 1{
                        categorieArray.removeAll()
                    }
                    
                    categorieArray.append(contentsOf: object)
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

    
    func submitSearcgFromCategories(name: String) {
       
        
        let requestUrl = APIConstant.getCategories + "?name=\(name)"
        print("requestUrl search categories \(requestUrl)")
        
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
               
                do{
                    let object = try JSONDecoder().decode([CategorieOB].self, from: responseObject?.data as! Data)
                 
                    categorieArray.removeAll()
                    categorieArray.append(contentsOf: object)
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
