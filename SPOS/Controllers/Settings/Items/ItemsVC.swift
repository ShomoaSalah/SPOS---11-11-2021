//
//  ItemsVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/30/21.
//

import UIKit
import SVProgressHUD

protocol TransferItems {
    func didSelectItem(itemIDs: [Int])
}


class ItemsVC: BaseVC, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: SearchView!
    
    
    var arrSelectedIndex = [IndexPath]()
    
    var itemsArray = [ItemsOB]()
    var storeID = 0
    var delegate: TransferItems?
    var itemIDs = [Int]()
    
    var fromEditing = false
    var category_id = 0
    
    
    var itemsArrayAfterSearching = [ItemsOB]()
    var searchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "العناصر"
        initTV()
        addRightButton()
        

        searchView.txtSearch.delegate = self
        searchView.txtSearch.addTarget(self, action: #selector(EditingChange), for: .editingChanged)
        
        
        
        
        if fromEditing {
            if UserHelper.isLogin() {
                storeID = UserHelper.lodeUser()!.storeID ?? 61
                getItemsWithCategoryForEditing(store_id: storeID, category_id: category_id)
            }
        }else {
            if UserHelper.isLogin() {
                storeID = UserHelper.lodeUser()!.storeID ?? 61
                getItemsWithCategory(store_id: storeID)
            }
        }
    }
    
    
    //MARK: - Filtering Content -
    //while typing
    @objc func EditingChange()  {
        itemsArrayAfterSearching = itemsArray.filter { text in
            return text.name?.lowercased().contains(searchView.txtSearch.text!) ?? false
        }
        if itemsArrayAfterSearching.count == 0 {
            searchActive = false
            self.view.makeToast(NSLocalizedString("SeachNotFound", comment: ""))
        } else {
            searchActive = true
        }
        
        tableView.reloadData()
    }
    
    //when pressed on Done Keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
        itemsArrayAfterSearching = itemsArray.filter { text in
            return text.name?.lowercased().contains(searchView.txtSearch.text!) ?? false
        }
        
        if(itemsArrayAfterSearching.count == 0){
            searchActive = false
            self.view.makeToast(NSLocalizedString("SeachNotFound", comment: ""))
        } else {
            searchActive = true
        }
        
        tableView.reloadData()
    }
    
    //
    
    @objc func searchInItems(){
        
//        if searchView.txtSearch.text == "" {
//
//            if fromEditing {
//                if UserHelper.isLogin() {
//                    storeID = UserHelper.lodeUser()!.storeID ?? 61
//                    getItemsWithCategoryForEditing(store_id: storeID, category_id: category_id)
//                }
//            }else {
//                if UserHelper.isLogin() {
//                    storeID = UserHelper.lodeUser()!.storeID ?? 61
//                    getItemsWithCategory(store_id: storeID)
//                }
//            }
//
//        }else {
//            //Search
//
//        }
    }
    
    func addRightButton(){
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 77, height: 40))
        viewFN.backgroundColor = .clear
        
        let button1 = UIButton(frame: CGRect(x: 0,y: 8, width: 80, height: 30))
        button1.setTitle("تحديد الكل", for: .normal)
        button1.setTitleColor("0CA7EE".color, for: .normal)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button1.addTarget(self, action: #selector(didTapOnSelectAll), for: .touchUpInside)
        
        viewFN.addSubview(button1)
        
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    var iconClick = false
    @objc func didTapOnSelectAll(){
        if(iconClick == true) {
            tableView.reloadData()
        } else {
            tableView.reloadData()
        }
        
        iconClick = !iconClick
    }
    
    
    @IBAction func submitSaving(_ sender: UIButton) {
        
        self.delegate?.didSelectItem(itemIDs: itemIDs)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
}

extension ItemsVC: UITableViewDataSource, UITableViewDelegate {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchActive {
            return itemsArrayAfterSearching.count
        }
        else {
            return itemsArray.count
        }
         
       
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsTVC", for: indexPath) as! ItemsTVC
        cell.selectionStyle = .none
        
        let item: ItemsOB?
        
        if searchActive {
//            return itemsArrayAfterSearching.count
            item = itemsArrayAfterSearching[indexPath.row]
        }
        else {
            item = itemsArray[indexPath.row]
        }
        
        
        cell.configure(data: item!)
        
        if fromEditing {
            
            if itemIDs.contains(item?.id ?? 0) {
                cell.isSelected = true
                cell.itemSelectedImage.image = UIImage(named: "ic-checkGreen-Box")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
                }
            } else {
                cell.isSelected = false
            }
            cell.setSelected(cell.isSelected, animated: true)
            cell.layoutSubviews()
             
        }
        
        else {
            if indexPath.row == 0 {
                cell.isSelected = true
                cell.itemSelectedImage.image = UIImage(named: "ic-checkGreen-Box")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
                }
            } else {
                cell.isSelected = false
            }

            cell.setSelected(cell.isSelected, animated: true)
            cell.layoutSubviews()
        }
        
        
       
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let cell = cell as! ItemsTVC
//        if iconClick {
//            cell.itemSelectedImage.image = UIImage(named: "ic-checkGreen-Box")
//        }else {
//            cell.itemSelectedImage.image = UIImage(named: "ic-Box")
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ItemsTVC
        
        let item: ItemsOB?
        
        if searchActive {
            item = itemsArrayAfterSearching[indexPath.row]
        }
        else {
            item = itemsArray[indexPath.row]
        }
        
        
        if arrSelectedIndex.contains(indexPath) {
            arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
            cell.itemSelectedImage.image = UIImage(named: "ic-Box")
            tableView.deselectRow(at: indexPath, animated: false)
            
            itemIDs =  itemIDs.filter {$0 != item?.id}
            print("itemIDs 2 \(itemIDs)")
            cell.setSelected(false, animated: true)
        }
        else {
            arrSelectedIndex.append(indexPath)
            cell.itemSelectedImage.image = UIImage(named: "ic-checkGreen-Box")
            itemIDs.append(item?.id ?? 0)
            print("itemIDs 1 \(itemIDs)")
            cell.setSelected(true, animated: true)
        }
    }
    
    
    
}



//MARK: - Database

extension ItemsVC {
    

    func getItemsWithCategory(store_id: Int) {
        
        SVProgressHUD.show()
      
        let requestUrl = APIConstant.getItemsWithCategory + "?store_id=\(store_id)"
        print("requestUrl get Items With Category \(requestUrl)")
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
                do{
                    let object = try JSONDecoder().decode([ItemsOB].self, from: responseObject?.data as! Data)
                    itemsArray = object
                    
                    tableView.reloadData()
                }catch{
                    self.view.makeToast(responseObject?.message ?? "")
                }
                
            }else {
                self.view.makeToast(responseObject?.message ?? "")
            }
        }
        
        
    }
    
    func getItemsWithCategoryForEditing(store_id: Int, category_id: Int) {
        
        SVProgressHUD.show()

        let requestUrl = APIConstant.getItemsWithCategory + "?category_id=\(category_id)&store_id=\(store_id)"
        print("requestUrl get Items With Category \(requestUrl)")
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
                do{
                    let object = try JSONDecoder().decode([ItemsOB].self, from: responseObject?.data as! Data)
                    itemsArray = object
                    tableView.reloadData()
                    
                    if itemsArray.count > 0 {
                        
                        
                        for index in 0...itemsArray.count-1 {
                            
                            if itemsArray[index].isChecked ?? false {
                                itemIDs.append(itemsArray[index].id ?? 0)
                            }
                           
                        }
                    }
                    
                    print("itemIDs \(itemIDs)")
                   
                }catch{
                    self.view.makeToast(responseObject?.message ?? "")
                }
                
            }else {
                self.view.makeToast(responseObject?.message ?? "")
            }
        }
        
        
    }
    
}
