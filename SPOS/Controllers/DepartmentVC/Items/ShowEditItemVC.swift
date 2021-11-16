//
//  ShowEditItemVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/1/21.
//

import UIKit
import SVProgressHUD
import DropDown


class ShowEditItemVC: BaseVC {

    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var addImageContainerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionContainerView: UIView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorTitleLbl: UILabel!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var imageTitleLbl: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectCategoryLbl: UILabel!
    @IBOutlet weak var categoryView: UIView!
    
    
    @IBOutlet weak var eachView: UIView!
    @IBOutlet weak var eachTitleLbl: UILabel!
    @IBOutlet weak var volumeView: UIView!
    @IBOutlet weak var volumeTitleLbl: UILabel!
    
    let dropDownCategory = DropDown()
    var categoryArrayString = [String]()
    //category_id
    var categoryDics = [String:Int]()
    var storeID = 0
    var imageSelected: UIImage?
    
    
    @IBOutlet weak var nameTF: UITextField!
    var categorySelectedIndex = 0
    var selectSoldBy = ""
    var storeTracking = 0
    var colorSelectedID = 0
    var modificationsID = [Int]()
    var taxesID = [Int]()
    var selectImageOrColor = ""
    
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var skuTF: UITextField!
    @IBOutlet weak var barcodeTF: UITextField!
    @IBOutlet weak var expireDateTF: UITextField!
    @IBOutlet weak var inStockTF: UITextField!
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var storeTrackingSwitch: UISwitch!
    var datePicker = UIDatePicker()
    
    var itemObject: ItemsOB?
    var selectedItemID = 0
    
    var colorsArray = [ColorsOB]()
    var modificationsTaxesArray = [ModificationsTaxesOB]()
    var modificationsArray = [Modification]()
    var taxArray = [Tax]()
    var titleArray = ["Modifications", "Taxes"]
    var categorieArray = [CategorieOB]()
    var imagePicker: ImagePickerCamera!
    
    private let itemsPerRow: CGFloat = 4
    private let sectionInsets = UIEdgeInsets(
        top: 0,
        left: 8,
        bottom: 0,
        right: 8)
    var store_id = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        print("colorSelectedID \(colorSelectedID)")
        self.imagePicker = ImagePickerCamera(presentationController: self, delegate: self)
        
        self.title = "تعديل العنصر"
        
        if UserHelper.isLogin() {
            storeID = UserHelper.lodeUser()!.storeID ?? 0
            
            showAllItem(item_id: selectedItemID, store_id: storeID)
//            showAllItem(item_id: selectedItemID, store_id: 33)
        }
        
        selectSoldBy = "each"
        initTV()
        getCategoriesFromServer()
        createDatePicker()
        initCV()
        getColors()
        
        if UserHelper.isLogin() {
            store_id = UserHelper.lodeUser()!.storeID ?? 0
            getModificationsAndTaxes(item_id: selectedItemID, store_id: store_id)
        }
        
        
        LoadingButton.startLoading(activityIndicator: loadingIndicator)
        
       addImageContainerView.isHidden = true
       collectionContainerView.isHidden = false
        
        if storeTrackingSwitch.isOn {
            inStockTF.isEnabled = true
        }else {
            inStockTF.isEnabled = false
        }
        
        storeTrackingSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)

    }
    
    @objc func switchChanged(mySwitch: UISwitch) {
        if mySwitch.isOn {
            storeTracking = 1
        }else {
            storeTracking = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addNotificationObserver(.reloadCategories, #selector(reloadCategories))

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        addNotificationObserver(.reloadCategories, #selector(reloadCategories))
    }
    
    @objc func reloadCategories() {
        print("reloadCategories")
        getCategoriesFromServer()
        dropDownCategory.reloadAllComponents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//        removeNotificationObserver(.reloadCategories)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(true)
//        removeNotificationObserver(.reloadCategories)
    }
    
    
    func appendTwoItem()->[CategorieOB] {
        var categories = [CategorieOB]()
        
        let cat1 = CategorieOB(name: "No Category", colorID: 0, userID: 0, id: 1, itemsCount: 0, kitchenPrintersExists: false, colorName: "", image: "", priceState: "", type: "", objectType: "")
        
        categories.append(cat1)
        
        
        
        
        categories.append(cat1)
        
        let cat2 = CategorieOB(name: "Create Category", colorID: 0, userID: 0, id: 0, itemsCount: 0, kitchenPrintersExists: false, colorName: "", image: "", priceState: "", type: "", objectType: "")
        
        
        categories.append(cat2)
        
        return categories
    }
    
    
    func createDatePicker(){
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([doneBtn], animated: true)
        //assign toolbar
        expireDateTF.inputAccessoryView = toolBar
        
        //assign date picker to the text field
        expireDateTF.inputView = datePicker
        
        //datePicker mode
        datePicker.datePickerMode = .date
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
    }
     
    @objc func donePressed(){
        
        //Formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
      
        let selectedDate = datePicker.date
        expireDateTF.text = selectedDate.getYYYYMMDD()
        
        self.view.endEditing(true)
    }
    
    
    @IBAction func selectSoldBy(_ sender: UIButton) {
        //in: each|volume
        //tag > 0: each بالوحدة
        //, 1: volume بالوزن
        switch sender.tag {
        case 0:
            eachView.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            eachTitleLbl.textColor = "0CA7EE".color
            
            volumeView.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            volumeTitleLbl.textColor = "C3C5CE".color
            selectSoldBy = "each"
            
            break
        case 1:
            
            volumeView.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            volumeTitleLbl.textColor = "0CA7EE".color
            
            eachView.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            eachTitleLbl.textColor = "C3C5CE".color
            selectSoldBy = "volume"
            
            break
        default:
            break
        }
        
    }
    
    
    @IBAction func selectImageOrColor(_ sender: UIButton) {
        
        //tag > 0: Color, 1: Image
        switch sender.tag {
        case 0:
            selectImageOrColor = "color"
            colorView.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            colorTitleLbl.textColor = "0CA7EE".color
            imageView.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            imageTitleLbl.textColor = "C3C5CE".color
            addImageContainerView.isHidden = true
            collectionContainerView.isHidden = false
            break
            
        case 1:
            selectImageOrColor = "image"
            imageView.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            imageTitleLbl.textColor = "0CA7EE".color
            colorView.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            colorTitleLbl.textColor = "C3C5CE".color
            addImageContainerView.isHidden = false
            collectionContainerView.isHidden = true
            loadingIndicator.isHidden = true
            break
            
        default:
            break
        }
        
    }
    

    @IBAction func selectCategory(_ sender: UIButton) {
        openCategoryMenu()
    }
    
    

    func openCategoryMenu(){
        
        dropDownCategory.layer.cornerRadius = 10
        dropDownCategory.backgroundColor = .white
        
        dropDownCategory.anchorView = categoryView
        dropDownCategory.width = 320
        dropDownCategory.bottomOffset = CGPoint(x: 0, y:(dropDownCategory.anchorView?.plainView.bounds.height)!)
        
        dropDownCategory.dataSource = self.categoryArrayString
        
        dropDownCategory.selectionAction = { [unowned self] (index: Int, item: String) in
            
            selectCategoryLbl.text = item
            
            switch item {
            case "No Category":
                categorySelectedIndex = 1
                break
            case "Create Category":
                let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddNewCategoriesVC") as! AddNewCategoriesVC
                self.navigationItem.hideBackWord()
                self.navigationController?.pushViewController(vc, animated: true)
                break
            default:
                break
            }
            categorySelectedIndex = categoryDics[item] ?? 0
            print("selectCategoryLbl \(categorySelectedIndex)")
            
        }
        
        dropDownCategory.show()
    }
    
    
    @IBAction func deleteItem(_ sender: UIButton) {
        submitDeleteItem(itemID: selectedItemID)
    }
    @IBAction func submitUpdating(_ sender: UIButton) {
        
        
//        UpdateNewItem
        
        var inStockInt = 0
        if storeTracking == 1 {
            if !inStockTF.text!.isEmptyStr {
                inStockInt = Int(inStockTF.text!)!
            }
        }else {
            inStockInt = 0
        }
       
        UpdateNewItem(item_id: selectedItemID, name:  (nameTF.text ?? itemObject?.name)!, category_id: (categorySelectedIndex ?? itemObject?.categoryID)!, sold_by: (selectSoldBy ?? itemObject?.soldBy)!, price: priceTF.text ?? itemObject?.priceState, cost: amountTF.text ?? itemObject?.cost?.description, sku: (skuTF.text ?? itemObject?.sku)!, bar_code: barcodeTF.text ?? itemObject?.barCode, date_expire: (expireDateTF.text ?? itemObject?.dateExpire)!, store_tracking: (storeTracking ?? itemObject?.storeTracking)!, in_stock: (inStockInt ?? itemObject?.inStock)!, color_id: colorSelectedID ?? itemObject?.colorID, image: (itemImage.image ?? itemObject?.image?.toImage()) ?? UIImage(), store_id: storeID, modifications_id: modificationsID, taxes_id: taxesID)
    }
    
    @IBAction func submitCameraAction(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
}



extension ShowEditItemVC: UITableViewDataSource, UITableViewDelegate {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "AddItemSectionTVC", bundle: nil), forCellReuseIdentifier: "AddItemSectionTVC") //Section
        tableView.register(UINib(nibName: "ModificationsTVC", bundle: nil), forCellReuseIdentifier: "ModificationsTVC") //Cell #1
        tableView.register(UINib(nibName: "TaxesTVC", bundle: nil), forCellReuseIdentifier: "TaxesTVC") //Cell #2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return modificationsArray.count
        }else if section == 1 {
            return taxArray.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cellHeader = tableView.dequeueReusableCell(withIdentifier: "AddItemSectionTVC") as! AddItemSectionTVC

        let item = titleArray[section]
        cellHeader.titleLbl.text = item
        
        return cellHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 39.0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ModificationsTVC", for: indexPath) as! ModificationsTVC
            cell.selectionStyle = .none
            let item = modificationsArray[indexPath.row]
            cell.configure(data: item)
            
            cell.enableModificationSwitch.isOn = true
            cell.enableModificationSwitch.tag = indexPath.row
            cell.enableModificationSwitch.addTarget(self, action: #selector(enableModification), for: .valueChanged)

            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaxesTVC", for: indexPath) as! TaxesTVC
            cell.selectionStyle = .none
            let item = taxArray[indexPath.row]
            cell.configure(data: item)

            if item.isChecked ?? true {
                taxesID.append(item.id ?? 0)
            }
            
            cell.enableTaxSwitch.tag = indexPath.row
            cell.enableTaxSwitch.addTarget(self, action: #selector(enableTax), for: .valueChanged)
           
            return cell
        }
        
    }
    
    
    @objc func enableModification(_ sender: UISwitch) {
        let item = modificationsArray[sender.tag]
        
        if sender.isOn {
            modificationsID.append(item.id ?? 0)
        }else {
            modificationsID = modificationsID.filter {$0 != item.id ?? 0}
        }
        print("modificationsID \(modificationsID)")
    }
     
    @objc func enableTax(_ sender: UISwitch){
        let item = taxArray[sender.tag]
        
        if sender.isOn {
            
            taxesID.append(item.id ?? 0)
        }else {
            taxesID = taxesID.filter {$0 != item.id ?? 0}
        }
        print("taxesID \(taxesID)")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //modificationsID
        
        if indexPath.section == 0 {
            
            let cell = tableView.cellForRow(at: indexPath) as! ModificationsTVC
            let item = modificationsArray[indexPath.row]
        
//            modificationsID.append(<#T##newElement: Int##Int#>)
            
        } else {
            
            let cell = tableView.cellForRow(at: indexPath) as! TaxesTVC
            let item = taxArray[indexPath.row]

        }
        
    }
    
    
}


extension ShowEditItemVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func initCV() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "SelectColorImageCVC", bundle: nil), forCellWithReuseIdentifier: "SelectColorImageCVC")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectColorImageCVC", for: indexPath) as! SelectColorImageCVC
        let item = colorsArray[indexPath.row]
        
        cell.colorImage.backgroundColor = UIColor(hex: item.color!)
        
        if item.id  == colorSelectedID {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredVertically)
            colorSelectedID = item.id ?? 0
            
        }else {
            cell.isSelected = false
        }
        
        cell.setSelected(isSelected: cell.isSelected)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SelectColorImageCVC
        
        cell.setSelected(isSelected: true)
        let item = colorsArray[indexPath.row]
        colorSelectedID = item.id ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! SelectColorImageCVC
        
        cell.setSelected(isSelected: false)
        
        let item = colorsArray[indexPath.row]
        
        //        aqarIDs = aqarIDs.filter {$0 != item.uuid}
        //        aqarsTitle = aqarIDs.filter {$0 != item.categoryName}
        
    }
    
}


extension ShowEditItemVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        print("widthPerItem \(widthPerItem)")

        return CGSize(width: widthPerItem, height: 77)
    }

}


//MARK: - API Request


extension ShowEditItemVC {
    
    
    func getCategoriesFromServer() {
        SVProgressHUD.show()
        
        API.getCategoriesList { [self] categories, status, msg in
            SVProgressHUD.dismiss()
            if status {
                
                categorieArray.removeAll()
                categorieArray = self.appendTwoItem()
                categorieArray += categories
                
                for category in categorieArray {
                    
                    categoryArrayString.append(category.name ?? "")
                    categoryDics[category.name!] = category.id!
                    categorySelectedIndex = category.id!
                    print("categorieArray 1 \(categoryArrayString) ")
                    print("categorieArray 2 \(categoryDics) ")
                }
                
               
                dropDownCategory.dataSource = categoryArrayString
                
                
                
                
                tableView.reloadData()
            }else {
                self.navigationController?.view.makeToast(msg)
            }
            
        }
    }
    
    func getColors() {
        
        API.getColorsList { [self]  colors, status, msg in
            
            LoadingButton.stopLoading(activityIndicator: loadingIndicator)
            loadingIndicator.isHidden = true
            
            if status {
                
                colorsArray = colors
                collectionView.reloadData()
                
            } else {
                self.navigationController?.view.makeToast(msg)
            }
        }
        
    }
    
    func getModificationsAndTaxes(item_id: Int, store_id: Int)  {
        
        SVProgressHUD.show()
        
        let requestUrl = APIConstant.getModificationsAndTaxes + "?item_id=\(item_id)&store_id=\(store_id)"
        print("requestUrl get Modifications & Taxes By item ID \(requestUrl)")
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
                do{
                    
                    let object = try JSONDecoder().decode(ModificationsTaxesOB.self, from: responseObject?.data as! Data)

                    modificationsArray = object.modifications ?? [Modification]()
                    taxArray = object.taxes ?? [Tax]()
                    
                   
                    tableView.reloadData()

                }catch{
                    self.view.makeToast(responseObject?.message ?? "")
                }
                
            }else {
                self.view.makeToast(responseObject?.message ?? "")
            }
        }
    }
    
    func showAllItem(item_id: Int, store_id: Int) {
        

        let urlRequest = APIConstant.showItem + "\(item_id)&store_id=\(store_id)"
        print("urlRequest show Item \(urlRequest)")
        
        SVProgressHUD.show()
        
        API.startRequest(url: urlRequest, method: .get, parameters: nil, viewCon: self) { [self] status, responseObject in
            
            if status {
                do{
                    let object = try JSONDecoder().decode(ItemsOB.self, from: responseObject?.data as! Data)
                    itemObject = object
                    
                    nameTF.text = itemObject?.name ?? ""
                    selectCategoryLbl.text = itemObject?.categoryName ?? ""
                    categorySelectedIndex = itemObject?.categoryID ?? -1
                    
                    categorySelectedIndex = itemObject?.categoryID ?? -1
                    selectSoldBy = itemObject!.soldBy ?? "each"
                    
                    switch itemObject!.soldBy {
                    case "volume":
                        volumeView.setBorder(width: 0.5, color: "0CA7EE".cgColor)
                        volumeTitleLbl.textColor = "0CA7EE".color
                        eachView.setBorder(width: 0.5, color: "C3C5CE".cgColor)
                        eachTitleLbl.textColor = "C3C5CE".color
                        break
                    case "each":
                        eachView.setBorder(width: 0.5, color: "0CA7EE".cgColor)
                        eachTitleLbl.textColor = "0CA7EE".color
                        volumeView.setBorder(width: 0.5, color: "C3C5CE".cgColor)
                        volumeTitleLbl.textColor = "C3C5CE".color
                        break
                    default:
                        break
                    }
                    
                    priceTF.text = itemObject?.priceState
                    amountTF.text = itemObject?.cost?.description
                    skuTF.text = itemObject?.sku
                    barcodeTF.text = itemObject?.barCode
                    expireDateTF.text = itemObject?.dateExpire
                    
                    
                    switch itemObject!.storeTracking {
                    case 0:
                        storeTrackingSwitch.isOn = false
                        break
                    case 1:
                        storeTrackingSwitch.isOn = true
                        break
                    default:
                        break
                    }
                    inStockTF.text = itemObject!.inStock?.description
                    
                    
                    if itemObject?.image != nil {
                        selectImageOrColor = "image"
                        
                        itemImage.sd_setImage(with: URL(string: itemObject?.image ?? ""), placeholderImage: UIImage(named: "img-logo4"))

                        imageView.setBorder(width: 0.5, color: "0CA7EE".cgColor)
                        imageTitleLbl.textColor = "0CA7EE".color
                        colorView.setBorder(width: 0.5, color: "C3C5CE".cgColor)
                        colorTitleLbl.textColor = "C3C5CE".color
                        addImageContainerView.isHidden = false
                        collectionContainerView.isHidden = true
                        loadingIndicator.isHidden = true
                    }
                    
                    if itemObject!.colorName != nil {
                        selectImageOrColor = "color"
                        
                        colorSelectedID = itemObject!.colorID ?? 0
                        
                        colorView.setBorder(width: 0.5, color: "0CA7EE".cgColor)
                        colorTitleLbl.textColor = "0CA7EE".color
                        imageView.setBorder(width: 0.5, color: "C3C5CE".cgColor)
                        imageTitleLbl.textColor = "C3C5CE".color
                        addImageContainerView.isHidden = true
                        collectionContainerView.isHidden = false
                    }
                    
                    
                    noDataView.isHidden = true
                }catch{
                    noDataView.isHidden = false
                    self.view.makeToast(responseObject?.message ?? "")
                }
                
            }else {
                noDataView.isHidden = false
                self.view.makeToast(responseObject?.message ?? "")
            }
        }
    }
    
    func UpdateNewItem(item_id: Int, name: String, category_id: Int, sold_by: String, price: String?, cost: String?, sku: String, bar_code: String?, date_expire: String, store_tracking: Int, in_stock: Int, color_id: Int?, image: UIImage, store_id: Int, modifications_id: [Int]?, taxes_id: [Int]?) {
        
        let urlRequest = APIConstant.editItem
        print("urlRequest edit Item \(urlRequest)")
        
        var params = [String:Any]()
        params["item_id"] = item_id
        params["name"] = name
        params["category_id"] = category_id
        
        params["sold_by"] = sold_by
        params["price"] = price
        params["cost"] = cost
        params["sku"] = sku
        params["bar_code"] = bar_code
        params["date_expire"] = date_expire
        params["store_tracking"] = store_tracking
        params["in_stock"] = in_stock
       
        params["store_id"] = store_id
        
        if modifications_id!.count != 0 {
            for index in 0...modifications_id!.count-1 {
                params["modifications_id[\(index)]"] = modifications_id![index]
            }
        }
       
        if taxes_id!.count != 0 {
            for index in 0...taxes_id!.count-1 {
                params["taxes_id[\(index)]"] = taxes_id![index]
            }
        }
       
        
        
        print("PARAMS \(params)")
        SVProgressHUD.show()
     
        var headers = [String:String]()
        
        if UserHelper.isLogin(){
            
            let token = (UserHelper.lodeUser()?.token)!
            headers["Authorization"] = "Bearer \(token)"
//            headers["Authorization"] = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNWQ3ZjNmMjZjN2RjMjVkYTZmZGUwMzYzZGUwYWE2YmYxNjQyNzdkYzQ4NDZlODcxMjlhMzRlMmU0OGMwZDkzOGZjN2U5NWQ2OTdkZTNiNDkiLCJpYXQiOjE2MzUxNDU0NDEuMDE2ODA5OTQwMzM4MTM0NzY1NjI1LCJuYmYiOjE2MzUxNDU0NDEuMDE2ODE0OTQ3MTI4Mjk1ODk4NDM3NSwiZXhwIjoxNjY2NjgxNDQxLjAwNjExNTkxMzM5MTExMzI4MTI1LCJzdWIiOiI0NCIsInNjb3BlcyI6W119.YCplWOaICZZQx6GTTwzGVGVotVVnnSVtLvVQNPL7uCGo_jJFwhxDZuboODj7myV4aAu9SstvoJ7GvUBnfJQi8K2hOSYg-OC1XPXpsVdFFz-PG8AOHEoPR6cIEDH4UhrLtNZqPhC3acvK4tfNVeUtEA8FZdF5dExC8NjCRt9E9rjHDYyuPSHmovHd3pi5Trr1OSCketMsLNCoxMLBt9M0BZTkxBX1n4J2sqXrUnST05FD9qtAUUwdcsumMniuiyeiLLYbD5CUGrelY3VYzzstFeqQngJh-ogJOMA4ipzkQjFh8r_sEmf9aFLfSGkqPBwXk1t4WZAwK0kNN-7BEkzBehYZPJq2OgM5F6W6tcEXQXkyAZ11U57U5JtEBqeiZ-G0A0JPawV4ZHUqbjYK2uX1cY7qfE3DnmJCMqdCZUGfjy0rkau19kyIAX4XYgLD1bp_G3B45II1sviGW2KEuLFOxOqOWvWWkMppHp-Ryof7JhVF5CMsfY5e_NxnS6Ee_w1CdA5fzF_K6q66F8Gk4mf7Y_h9_CKbpzFjFKJr3EoClMbaUrXRhC3EBCOgZmJFPzoq5MtMH8cyIP1EdjTCw3tpg3uxSRh6zPXIV2_DajQ2hutCBfpygOKaeUStB4RaC-XjwUknAM4znIycZh7asYJfEt1N3qycdfm9KsnmhuqlfGY"
            print("Headers: ", headers)
            
        }
        
      
        if itemImage.image != nil {
            
            API.submitAddItem(url: urlRequest, params, auth: headers, "image", image, viewCon: self) { [self] (status, responesObject) in
                
                if status {
                    
                    self.view.makeToast(responesObject?.message)
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        postNotificationCenter(.reloadItems)
                        self.navigationController?.popViewController(animated: true)
                    }
                    //
                }
                
                else{
                    
                    print("ERROR \(responesObject?.errors?[0])")
//                    self.view.makeToast(responesObject!.errors[0])
                }
                
                
            }
            
        }else {
            
            params["color_id"] = color_id
            
            API.startRequest(url: urlRequest, method: .post, parameters: params, viewCon: self) { [self] (status, responesObject) in
                
                if status {
                    self.view.makeToast(responesObject?.message)
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        postNotificationCenter(.reloadItems)
                        self.navigationController?.popViewController(animated: true)
                    }
                }else {
                    self.view.makeToast(responesObject?.message)
                }
            }
        }
        
        
        
    }
    
    
    
    func submitDeleteItem(itemID: Int) {
        
        let urlRequest = APIConstant.deleteItem + "?item_ids[0]=\(itemID)"
        print("urlRequest delete item \(urlRequest)")
        
        SVProgressHUD.show()
        
        API.startRequest(url: urlRequest, method: .delete, parameters: nil, viewCon: self) { [self] (status, responesObject) in
            
            if status {
                self.view.makeToast(responesObject?.message)
                postNotificationCenter(.reloadItems)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
            
            else{
                self.navigationController?.view.makeToast((responesObject?.message!)!)
            }
            
        }
    }
    
}




//MARK: - Using Camera & PhotoAlbum

extension ShowEditItemVC: ImagePickerDelegate {
    func didSelect(video: URL?) {
        //
    }
    
  
    
   
    
    
    func didSelect(image: UIImage?) {
        
        if image != nil {
            imageSelected = image
            itemImage.image = image
        }else {
            return
        }
        
        
        
    }
    
    
    
}
