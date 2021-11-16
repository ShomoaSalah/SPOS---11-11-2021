//
//  HomeVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit
import SVProgressHUD
import DropDown

class HomeVC: BaseVC {
    
    @IBOutlet weak var selectTypeLbl: UILabel!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var shiftClosedView: UIView!
    
    // variant
    // ...
    
    var fromALlItesm = false
    var fromDiscount = false
    var fromCategories = false
    var fromSearch = false
    
    private let itemsPerRow: CGFloat = 3
    @IBOutlet weak var allItemsView: UIView!
    private let sectionInsets = UIEdgeInsets(
        top: 6,
        left: 24,
        bottom: 6,
        right: 24)
    
    var imagesColor = [
        UIImage(named: "img-color1"),
        UIImage(named: "img-color2"),
        UIImage(named: "img-color3"),
        UIImage(named: "img-color4"),
        UIImage(named: "img-color5"),
        UIImage(named: "img-color6"),
        UIImage(named: "img-color7"),
        UIImage(named: "img-color8")
    ]
    
    var posID = 0
    var storeID = 0
    
    var categorieArray = [CategorieOB]()
    
    var homeObject: HomeOB?
    var itemsArray = [ItemsOB]()
    
    var discountArray = [DiscountsOB]()
    
    var currentPagee = 1
    var lastPagee = 0
    let refresher = UIRefreshControl()
    
    let dropDownHome = DropDown()
    var categoryArrayString = [String]()
    var categoryDics = [String:Int]()
    var categorySelectedIndex = 0
    
    var searchHomeArray = [SearchHomeOB]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fromALlItesm = true
        topView.isHidden = true
        collectionView.isHidden = true
        
        collectionView.refreshControl = refresher
        refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        addNotificationObserver(.openShift, #selector(openShift))
        
        if UserHelper.isLogin() {
            posID = UserHelper.lodeUser()!.posID ?? 0
            storeID = UserHelper.lodeUser()!.storeID ?? 0
            getProfile(pos_id: posID)
            getHomeee(pos_id: posID, current_page: currentPagee, fromAllItems: true, fromDiscounts: false, fromCategory: false)
        }
        
        initCV() 
        addRightButton()
        addLeftButton()
        searchView.isHidden = true
    }
    
    @objc func submitSearchInHome(){
        fromSearch = true
        fromCategories = false
        fromDiscount = false
        fromALlItesm = false
        //        if UserHelper.isLogin() {
        //            posID = UserHelper.lodeUser()!.posID ?? 0
        //
        //            searchInHome(pos_id: posID, name: searchView.txtSearch.text ?? "", current_page: currentPagee)
        //        }
        
        
        if searchView.txtSearch.text == "" {
            //            getDiscountList(current_page: currentPagee)
            if UserHelper.isLogin() {
                posID = UserHelper.lodeUser()!.posID ?? 0
                
                fromSearch = false 
                fromCategories = false
                fromDiscount = false
                fromALlItesm = true
                
                getHomeee(pos_id: posID, current_page: currentPagee, fromAllItems: true, fromDiscounts: false, fromCategory: false)
            }
        }else {
            
            
            if UserHelper.isLogin() {
                posID = UserHelper.lodeUser()!.posID ?? 0
                
                searchInHome(pos_id: posID, name: searchView.txtSearch.text ?? "", current_page: currentPagee)
            }
        }
    }
    
    @objc func refreshData(){
        
        if UserHelper.isLogin() {
            selectTypeLbl.text = "All items"
            posID = UserHelper.lodeUser()!.posID ?? 0
            getProfile(pos_id: posID)
            categoryArrayString.removeAll()
            getHomeee(pos_id: posID, current_page: currentPagee, fromAllItems: true, fromDiscounts: false, fromCategory: false)
        }
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        
        if ((scrollOffset + scrollViewHeight) >= (scrollContentSizeHeight)){
            print(currentPagee,lastPagee)
            if currentPagee < lastPagee{
                currentPagee += 1
                getHomeee(pos_id: posID, current_page: currentPagee, fromAllItems: true, fromDiscounts: false, fromCategory: false)
                collectionView.scrollToBottom()
            }
        }
    }
    
    
    func appendTwoItem()->[CategorieOB] {
        var categories = [CategorieOB]()
        
        let cat1 = CategorieOB(name: "All items", colorID: 0, userID: 0, id: -1, itemsCount: 0, kitchenPrintersExists: false, colorName: "", image: "", priceState: "", type: "", objectType: "")
        categories.append(cat1)
        
        let cat2 = CategorieOB(name: "Discounts", colorID: 0, userID: 0, id: 1, itemsCount: 0, kitchenPrintersExists: false, colorName: "", image: "", priceState: "", type: "", objectType: "")
        
        
        categories.append(cat2)
        
        return categories
    }
    
    @IBAction func selectType(_ sender: UIButton) {
        openDropMenu()
    }
    
    
    func openDropMenu(){
        
        dropDownHome.layer.cornerRadius = 10
        dropDownHome.backgroundColor = .white
        
        dropDownHome.anchorView = allItemsView
        dropDownHome.width = allItemsView.frame.width
        dropDownHome.bottomOffset = CGPoint(x: 100, y:(dropDownHome.anchorView?.plainView.bounds.height)!)
        
        dropDownHome.dataSource = self.categoryArrayString
        
        dropDownHome.selectionAction = { [unowned self] (index: Int, item: String) in
            
            selectTypeLbl.text = item
            
            switch item {
            case "All items":
                fromALlItesm = true
                fromDiscount = false
                fromCategories = false
                
                if UserHelper.isLogin() {
                    posID = UserHelper.lodeUser()!.posID ?? 0
                    getHomeee(pos_id: posID, current_page: currentPagee, fromAllItems: true, fromDiscounts: false, fromCategory: false)
                }
                
                break
            case "Discounts":
                fromDiscount = true
                fromALlItesm = false
                fromCategories = false
                
                getHomeee(pos_id: posID, current_page: currentPagee, fromAllItems: false, fromDiscounts: true, fromCategory: false)
                
                break
            default:
                fromCategories = true
                fromDiscount = false
                fromALlItesm = false
                getHomeee(pos_id: posID, current_page: currentPagee, fromAllItems: false, fromDiscounts: false, fromCategory: true)
                
                break
            }
            categorySelectedIndex = categoryDics[item] ?? 0
            categoryArrayString.removeAll()
            print("selectCategoryLbl \(categorySelectedIndex)")
            
        }
        
        dropDownHome.show()
        
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
    
    func addRightButton(){
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 40))
        viewFN.backgroundColor = .clear
        
        
        let button1 = UIButton(frame: CGRect(x: 0,y: 5, width: 18, height: 30))
        button1.setImage(UIImage(named: "ic-Bag"), for: .normal)
        
        let lblBadge = UILabel.init(frame: CGRect.init(x: -12, y: 5, width: 15, height: 15))
        lblBadge.backgroundColor = .clear//"202124".color
        lblBadge.clipsToBounds = true
        lblBadge.layer.cornerRadius = 7
        lblBadge.textColor = "202124".color
        lblBadge.font = .systemFont(ofSize: 12)
        lblBadge.textAlignment = .center
        lblBadge.text = "12"
        button1.addSubview(lblBadge)
        
        
        button1.addTarget(self, action: #selector(didTapOnTicket), for: .touchUpInside)
        
        
        
        let button2 = UIButton(frame: CGRect(x: 26,y: 8, width: 24, height: 24))
        button2.setImage(UIImage(named: "ic-swap"), for: .normal)
        
        button2.addTarget(self, action: #selector(didTapOnAddNewClient), for: .touchUpInside)
        
        
        let button3 = UIButton(frame: CGRect(x: 58,y: 8, width: 24, height: 24))
        button3.setImage(UIImage(named: "ic-Iconly-Bulk-Filter"), for: .normal)
        
        button3.addTarget(self, action: #selector(didTapOnList), for: .touchUpInside)
        
        
        viewFN.addSubview(button1)
        viewFN.addSubview(button2)
        viewFN.addSubview(button3)
        
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    
    @objc func didTapOnList(){
        let vc = UIStoryboard.init(name: "TicketSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "TopListVC") as! TopListVC
        
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func didTapOnAddNewClient(){
        let vc = UIStoryboard.init(name: "TicketSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddCustomerToTicketVC") as! AddCustomerToTicketVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapOnTicket(){
        let vc = UIStoryboard.init(name: "TicketSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "TicketVC") as! TicketVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openScannerView(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "TicketSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "BarcodeVC") as! BarcodeVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    @IBAction func openSearch(_ sender: Any) {
        
        UIView.transition(with: searchView, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: { [self] in
                            searchView.isHidden = false
                            
                          })
        searchView.txtSearch.addTarget(self, action: #selector(submitSearchInHome), for: .editingChanged)
        
    }
    
    
    @IBAction func openTransferTicket(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "TicketSB", bundle: nil).instantiateViewController(withIdentifier: "TransferTicket2VC") as! TransferTicket2VC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        print("viewDidAppear again openShift")
        addNotificationObserver(.reloadCategoriesInHome, #selector(reloadCategoriesInHome))
       
        addNotificationObserver(.closeShift, #selector(closeShift))
        addNotificationObserver(.deleteTicket, #selector(deleteTicket))
        
    }
    
    @objc func reloadCategoriesInHome(){
        getHomeee(pos_id: posID, current_page: currentPagee, fromAllItems: false, fromDiscounts: false, fromCategory: true)
    }
    
    @objc func openShift(){
        shiftClosedView.isHidden = true
        topView.isHidden = false
        collectionView.isHidden = false
    }
    
    @objc func closeShift(){
        shiftClosedView.isHidden = false
        topView.isHidden = true
        collectionView.isHidden = true
    }
    
    @objc func deleteTicket(){
        shiftClosedView.isHidden = false
        topView.isHidden = true
        collectionView.isHidden = true
    }
    
    @IBAction func openClosedShift(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "HomeDetailsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "OpenShiftHomeVC") as! OpenShiftHomeVC
        
        vc.pos_id = self.posID
        
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowOffset = CGSize(width: 0, height: 5)
        self.navigationController?.navigationBar.shadowColor = "CECECE".color.withAlphaComponent(0.5)
        self.navigationController?.navigationBar.shadowOpacity = 0.8
    }
    
    @IBAction func openCustomTicket(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "HomeDetailsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "PayTicketVC") as! PayTicketVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

//MARK: - CollectionView

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func initCV() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "HomeImageCVC", bundle: nil), forCellWithReuseIdentifier: "HomeImageCVC")
        collectionView.register(UINib(nibName: "HomeColorCVC", bundle: nil), forCellWithReuseIdentifier: "HomeColorCVC")
        collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if fromDiscount {
            return discountArray.count
        }else if fromALlItesm {
            print("itemsArray.count12e \(itemsArray.count)")
            return itemsArray.count
        }else if fromCategories {
            return categorieArray.count
        }else if fromSearch{
            return searchHomeArray.count
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if fromDiscount {
            //discountArray
            print("cellForItemAt fromDiscount")
            let item = discountArray[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeColorCVC", for: indexPath) as! HomeColorCVC
            
            cell.imageColor.backgroundColor = UIColor(hex: "#E0E0E0")
            cell.titleLbl.text = item.name
            cell.titleLbl.textColor = .black
            
            return cell
        } else if fromALlItesm {
            print("cellForItemAt fromALlItesm")
            let item = itemsArray[indexPath.row]
            
            if item.image != nil {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeImageCVC", for: indexPath) as! HomeImageCVC
                
                cell.homeImage.sd_setImage(with: URL(string: item.image ?? ""), placeholderImage: UIImage(named: "img-logo4"))
                cell.titleLbl.text = item.name
                
                
                return cell
                
            }else {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeColorCVC", for: indexPath) as! HomeColorCVC
                
                cell.imageColor.backgroundColor = UIColor(hex: item.colorName ?? "")
                cell.titleLbl.text = item.name
                
                if item.colorName == "#E0E0E0" {
                    cell.titleLbl.textColor = .black
                }else {
                    cell.titleLbl.textColor = .white
                }
                return cell
                
            }
            
        } else if fromCategories {
            
            print("cellForItemAt fromCategories")
            
            let item = categorieArray[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeColorCVC", for: indexPath) as! HomeColorCVC
            
            cell.imageColor.backgroundColor = UIColor(hex: "#E0E0E0")
            cell.titleLbl.text = item.name
            cell.titleLbl.textColor = .black
            
            return cell
        }else if fromSearch {
            
            print("cellForItemAt fromSearch")
            
            let item = searchHomeArray[indexPath.row]
            print("objectType \(item.objectType)")
            switch item.objectType {
            case "item":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeColorCVC", for: indexPath) as! HomeColorCVC
                
                cell.imageColor.backgroundColor = UIColor(hex: "#E0E0E0")
                cell.titleLbl.text = item.name
                cell.titleLbl.textColor = .black
                
                return cell
                
            case "discount":
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeColorCVC", for: indexPath) as! HomeColorCVC
                
                cell.imageColor.backgroundColor = UIColor(hex: "#E0E0E0")
                cell.titleLbl.text = item.name
                cell.titleLbl.textColor = .black
                
                return cell
                
            default:
                break
            }
            
            
        }
        
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if fromDiscount {
            
            let item = discountArray[indexPath.row]
            openSpecificView(store_id: self.storeID, type_id: item.id ?? 0, type: 2, priceState: item.amountValue ?? "")
        } else if fromALlItesm {
            
            let item = itemsArray[indexPath.row]
            print("fromALlItesm 1")
            
            openSpecificView(store_id: self.storeID, type_id: item.id ?? 0, type: 1, priceState: item.priceState!)
            
            
        } else if fromCategories {
            
            let item = categorieArray[indexPath.row]
            
            openSpecificView(store_id: self.storeID, type_id: item.id ?? 0, type: 1, priceState: item.priceState!)
            
        }else if fromSearch {
            
            let item = searchHomeArray[indexPath.row]
            
            switch item.objectType {
            case "item":
                openSpecificView(store_id: self.storeID, type_id: item.id ?? 0, type: 1, priceState: item.priceState!)
            break
            
            case "discount":
                openSpecificView(store_id: self.storeID, type_id: item.id ?? 0, type: 2, priceState: item.priceState!)
                break
            
            default:
                break
            }
            
            
        }
    }
    
    
    func openSpecificView(store_id: Int, type_id: Int, type: Int, priceState: String){
        
        
        if priceState.contains("variant") {
            //Show Details
            
            print("priceState contain variant")
            
            
            let vc = UIStoryboard.init(name: "HomeDetailsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeItemDetailsVC") as! HomeItemDetailsVC
            self.navigationItem.hideBackWord()
            self.navigationController?.pushViewController(vc, animated: true)
    
    
        }
        
//        else if !priceState.contains("variant")  {
//            print("priceState NON")
//            //Add to ticket Direct
//
//        }
        
        
        else if priceState.isEmptyStr {
           print("priceState isEmptyStr \(priceState)")
            //Add Price View
            let vc = UIStoryboard.init(name: "HomeDetailsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddNewPriceVC") as! AddNewPriceVC
           
            
            vc.store_id = store_id
            vc.type_id = type_id
            vc.type = type
                
            self.navigationItem.hideBackWord()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    
}


extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: 105, height: 105)
    }
    
}


//MARK: - Protocol

extension HomeVC: TopListProtocol{
    
    func didClose(addToClinet: Bool, transferTicketToEmployee: Bool) {
        if addToClinet {
            let vc = UIStoryboard.init(name: "TicketSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddCustomerToTicketVC") as! AddCustomerToTicketVC
            self.navigationItem.hideBackWord()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if transferTicketToEmployee {
            let vc = UIStoryboard.init(name: "TicketSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "TransferTicketsToEmployeVC") as! TransferTicketsToEmployeVC
            self.navigationItem.hideBackWord()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func didClose(addToClinet: Bool) {
        
    }
    
    
}


//MARK: - API Request

extension HomeVC {
    
    func getProfile(pos_id: Int)  {
        
        let requestUrl = APIConstant.profile + "\(pos_id)"
        print("requestUrl profile \(requestUrl)")
        
        SVProgressHUD.show()
        
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] (status, responesObject) in
            
            
            if status {
                
                do{
                    
                    let object = try JSONDecoder().decode(UserOB.self, from: responesObject?.data as! Data)
                    
                    print("object.isShift \(object.isShift!)")
                    
                    if object.isShiftMenu! {
                        postNotificationCenter(.closeShift)
                    }else {
                        postNotificationCenter(.openShift)
                    }
                    
//                    if object.isShift ?? false {
//                        postNotificationCenter(.openShift)
//                    }else {
//
//                    }
                    
                    
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
    
    func getHomeee(pos_id: Int,current_page: Int, fromAllItems: Bool, fromDiscounts: Bool, fromCategory: Bool)  {
        
        var requestUrl = ""
        
        if fromAllItems {
            requestUrl = APIConstant.getHome + "\(pos_id)&page=\(current_page)"
            print("requestUrl get Home fromAllItems \(requestUrl)")
        }
        if fromDiscounts {
            requestUrl = APIConstant.getHome + "\(pos_id)&discount_filter=1&page=\(current_page)"
            print("requestUrl get Home fromDiscounts \(requestUrl)")
        }
        if fromCategory {
            requestUrl = APIConstant.getHome + "\(pos_id)&category_id=\(categorySelectedIndex)&page=\(current_page)"
            print("requestUrl get Home fromCategory \(requestUrl)")
            
        }
        
        
        SVProgressHUD.show()
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] (status, responesObject) in
            
            if self.refresher.isRefreshing {
                self.refresher.endRefreshing()
            }
            
            if status {
                
                do{
                    
                    let object = try JSONDecoder().decode(HomeOB.self, from: responesObject?.data as! Data)
                    
                    if currentPagee == 1{
                        discountArray.removeAll()
                        itemsArray.removeAll()
                        categorieArray.removeAll()
                    }
              
                    
                    
                    discountArray.append(contentsOf: object.discounts ?? [DiscountsOB]())
                    itemsArray.append(contentsOf: object.items ?? [ItemsOB]())
                   // categorieArray.append(contentsOf: object.categories ?? [CategorieOB]())
                    initCV()
                    
                    categorieArray = self.appendTwoItem()
//                    categorieArray += object.categories ?? [CategorieOB]()
            
                    categorieArray.append(contentsOf: object.categories ?? [CategorieOB]())
                    
                    for category in categorieArray {
                        categoryArrayString.append(category.name ?? "")
                        categoryDics[category.name!] = category.id!
                        categorySelectedIndex = category.id!
                        print("categorieArray 1 \(categoryArrayString) ")
                        print("categorieArray 2 \(categoryDics) ")
                    }
                    
                    
                    dropDownHome.dataSource = categoryArrayString.removingDuplicates()
                    
                    print("ACCOUNT discountArray12 \(discountArray.count)")
                    print("ACCOUNT itemsArray12 \(itemsArray.count)")
                    print("ACCOUNT categorieArray12 \(categorieArray.count)")
                    
                    
                    let pages =  try! JSONDecoder().decode(PagesOB.self, from: responesObject?.pages as! Data)
                    
                    currentPagee = pages.currentPage!
                    lastPagee = pages.lastPage!
                    
                    
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
    
    func searchInHome(pos_id: Int, name: String, current_page: Int)  {
        
        let requestUrl = APIConstant.getHome + "\(pos_id)&name=\(name)&page=\(current_page)"
        print("requestUrl search In Home \(requestUrl)")
        
        
        SVProgressHUD.show()
        
        API.startRequest(url: requestUrl, method: .get, parameters: nil, viewCon: self) { [self] (status, responesObject) in
            
            if self.refresher.isRefreshing {
                self.refresher.endRefreshing()
            }
            
            if status {
                print("Success")
                do{
                    
                    let object = try JSONDecoder().decode([SearchHomeOB].self, from: responesObject?.data as! Data)
                    
                    if currentPagee == 1{
                        searchHomeArray.removeAll()
                        
                    }
                    print("object \(object.count)")
                    //                    categorieArray.append(contentsOf: object.categories ?? [CategorieOB]())
                    
                    searchHomeArray.append(contentsOf: object)
                    initCV()
                    collectionView.reloadData()
                    
                    let pages =  try! JSONDecoder().decode(PagesOB.self, from: responesObject?.pages as! Data)
                    
                    currentPagee = pages.currentPage!
                    lastPagee = pages.lastPage!
                    
                    
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
