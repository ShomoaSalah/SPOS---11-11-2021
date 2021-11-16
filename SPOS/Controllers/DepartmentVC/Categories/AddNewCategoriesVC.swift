//
//  AddNewCategoriesVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit
import SVProgressHUD


class AddNewCategoriesVC: BaseVC {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categorieNameTF: UITextField!
    var selectedColorID = 0
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    private let itemsPerRow: CGFloat = 4
    private let sectionInsets = UIEdgeInsets(
        top: 0,
        left: 8,
        bottom: 0,
        right: 8)
    
    
    
   
    var colorsArray = [ColorsOB]()
    var categorieOB: CategorieOB?
    var numberOfExcuteRequest = 0
    var selectedItemIDs = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        LoadingButton.startLoading(activityIndicator: loadingIndicator)
//        setBackButton()
        
        navigationItem.leftBarButtonItems = CustomBackButton.createWithImage(image: UIImage(named: "arrow_back_english")!, color: .clear, target: self, action: #selector(btnBackTapped))
        
        getColors()
        self.title = "إضافة فئة جديد"
        initCV()
        
    }
    
    func setBackButton() {
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        let backArrowImage = UIImage(named: "img-arrow-English")?.withAlignmentRectInsets(insets)
        
        
//        var backImg: UIImage = UIImage(systemName: "chevron.right")!
        UINavigationBar.appearance().backIndicatorImage = backArrowImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backArrowImage
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(btnBackTapped))
    
    }
    
    @objc func btnBackTapped() {
        //show user an alert for the unsaved data or you can pop/dismiss the view controller
        if numberOfExcuteRequest == 0 && !categorieNameTF.text!.isEmptyStr {
            self.showAlertWithCancel(title: "Unsaved Changes", message: "Are you sure you want to continue without saving changes?", okAction: "Continue") { alert in
                self.navigationController?.popViewController(animated: true)
            }
        }else {
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        numberOfExcuteRequest = 0
    }
    
    @IBAction func submit(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "SettingsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ItemsVC") as! ItemsVC

        vc.delegate = self
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addCategory(_ sender: UIButton) {
        
        
        guard let categorieName = categorieNameTF.text, !categorieName.isEmptyStr else {
            self.navigationController?.view.makeToast(NSLocalizedString("categorieNameRequired", comment: ""))
            return
        }
     
        guard selectedColorID != 0 else {
            self.navigationController?.view.makeToast(NSLocalizedString("colorRequired", comment: ""))
            return
        }
        
        addCategoryToServer(name: categorieNameTF.text!, color_id: selectedColorID, item_ids: selectedItemIDs)
        
    }
    
    
}

extension AddNewCategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func initCV() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "SelectColorImageCVC", bundle: nil), forCellWithReuseIdentifier: "SelectColorImageCVC")
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorsArray.count //imagesColor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectColorImageCVC", for: indexPath) as! SelectColorImageCVC
        let item = colorsArray[indexPath.row]
     
        
        cell.colorImage.backgroundColor = UIColor(hex: item.color!)

        if indexPath.row == 0 {
            cell.isSelected = true
            selectedColorID = item.id ?? 0
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredVertically)
            
            //            aqarIDs.append(item.uuid ?? "")
            //            aqarsTitle.append(item.categoryName ?? "")
            
            
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
        selectedColorID = item.id ?? 0
        
        
        //selectedColorID
        
        //        aqarSelectedID = item.uuid ?? ""
        //        aqarSelectedName = item.categoryName ?? ""
        //
        //
        //        aqarIDs.append(item.uuid ?? "")
        //        aqarsTitle.append(item.categoryName ?? "")
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! SelectColorImageCVC
        
        cell.setSelected(isSelected: false)
        
        let item = colorsArray[indexPath.row]
        
        //        aqarIDs = aqarIDs.filter {$0 != item.uuid}
        //        aqarsTitle = aqarIDs.filter {$0 != item.categoryName}
        
    }
    
}


extension AddNewCategoriesVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 77)
    }
    
    
}


//MARK: - API Request

extension AddNewCategoriesVC {
    
    func getColors() {
        
        API.getColorsList { [self]  colors, status, msg in
            
            LoadingButton.stopLoading(activityIndicator: loadingIndicator)
            loadingIndicator.isHidden = true
            
            if status {
           
                colorsArray = colors
                collectionView.reloadData()
            }else {
                self.navigationController?.view.makeToast(msg)
            }
        }
        
    }
    
    
    
    func addCategoryToServer(name: String, color_id: Int, item_ids: [Int])  {
        let urlRequest = APIConstant.addCategory
        print("urlRequest add Category \(urlRequest)")
        
        var params = [String:Any]()
        
        if selectedItemIDs.count == 0 {
            params["name"] = name
            params["color_id"] = color_id
        }else {
            params["name"] = name
            params["color_id"] = color_id
            params["item_ids"] = item_ids
            
//            for index in 0...item_ids.count-1 {
//                params["item_ids[\(index)]"] = item_ids[index]
//            }
            
        }
        
        print("PARAMS \(params)")
        SVProgressHUD.show()
        
        numberOfExcuteRequest += 1
        
        API.startRequest(url: urlRequest, method: .post, parameters: params, viewCon: self) { [self] (status, responesObject) in
            
            SVProgressHUD.dismiss()
            if status {
                
                do{
                    
                    let object = try JSONDecoder().decode(CategorieOB.self, from: responesObject?.data as! Data)
                    categorieOB = object
                    
                    print("categorieOB After Adding \(categorieOB?.itemsCount) ... \(categorieOB)")
                    
                    postNotificationCenter(.reloadCategories)
                    postNotificationCenter(.reloadCategoriesInHome)
                  
                    self.navigationController?.popViewController(animated: true)
                     
                    
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


//MARK: - Protocol

extension AddNewCategoriesVC: TransferItems {
    
    
    func didSelectItem(itemIDs: [Int]) {
        selectedItemIDs = itemIDs
        print("selectedItemIDs \(selectedItemIDs)")
    }
    
    
}
