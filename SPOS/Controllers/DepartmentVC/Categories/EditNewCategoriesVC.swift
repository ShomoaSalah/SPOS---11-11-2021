//
//  EditNewCategoriesVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit
import SVProgressHUD

class EditNewCategoriesVC: BaseVC {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    var categoryOB: CategorieOB?
    var selectedColorID = 0
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var colorsArray = [ColorsOB]()
  
    private let itemsPerRow: CGFloat = 4
    private let sectionInsets = UIEdgeInsets(
        top: 0,
        left: 8,
        bottom: 0,
        right: 8)
    
  
    var selectedItemIDs = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTF.text = categoryOB?.name ?? ""
        getColors()
        LoadingButton.startLoading(activityIndicator: loadingIndicator)

        
        self.title = "تعديل الفئة"
        initCV()
        
    }
    
    
    @IBAction func submit(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "SettingsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ItemsVC") as! ItemsVC
        vc.delegate = self
        vc.fromEditing = true
        vc.category_id = categoryOB?.id ?? 0
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }


    @IBAction func deleteCategory(_ sender: UIButton) {
        
        deleteCategoryBy(categoryID: categoryOB?.id ?? 0)
    }
    
    @IBAction func submitEditing(_ sender: UIButton) {
     
        editCategory(category_id: categoryOB?.id ?? 0, name: (nameTF.text ?? categoryOB?.name)!, color_id: (selectedColorID ?? categoryOB?.colorID)!, item_ids: selectedItemIDs)
    }
    
}


extension EditNewCategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func initCV() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //SelectColorImageCVC
        
        collectionView.register(UINib(nibName: "SelectColorImageCVC", bundle: nil), forCellWithReuseIdentifier: "SelectColorImageCVC")

        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectColorImageCVC", for: indexPath) as! SelectColorImageCVC
        let item = colorsArray[indexPath.row]
      
        cell.colorImage.backgroundColor = UIColor(hex: item.color!)
        
        if item.color == categoryOB?.colorName {
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


extension EditNewCategoriesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
       
        return CGSize(width: widthPerItem, height: 77)
        
    }
    
  
}



//MARK: - API Request

extension EditNewCategoriesVC {
    
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
    
    
    func deleteCategoryBy(categoryID: Int) {
        
        let urlRequest = APIConstant.deleteCategory + "deleteCategory[0]=\(categoryID)"
        print("urlRequest delete Category \(urlRequest)")
        
        SVProgressHUD.show()
        
        API.startRequest(url: urlRequest, method: .delete, parameters: nil, viewCon: self) { [self] (status, responesObject) in
            
            if status {
                self.view.makeToast(responesObject?.message)
                postNotificationCenter(.reloadCategories)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
            
            else{
                self.navigationController?.view.makeToast((responesObject?.message!)!)
            }
            
        }
    }
    
 
    
    func editCategory(category_id:Int, name: String, color_id: Int, item_ids: [Int]) {
         //    //{{url}}/api/pos/categories/edit

         let urlRequest = APIConstant.editCategory
         print("urlRequest edit Category \(urlRequest)")
         
         var params = [String:Any]()
         params["category_id"] = category_id
        
        if selectedItemIDs.count == 0 {
            params["name"] = name
            params["color_id"] = color_id
        }else {
            params["name"] = name
            params["color_id"] = color_id
            for index in 0...item_ids.count-1 {
                params["item_ids[\(index)]"] = item_ids[index]
            }
            
        }
        
         
         print("PARAMS \(params)")
         
         
         SVProgressHUD.show()
         
         
         API.startRequest(url: urlRequest, method: .put, parameters: params, viewCon: self) { [self] (status, responesObject) in
             
             SVProgressHUD.dismiss()
             if status {
                 
                 self.view.makeToast(responesObject?.message)
                postNotificationCenter(.reloadCategories)
                 
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


//MARK: - Protocol

extension EditNewCategoriesVC: TransferItems {
    
    
    func didSelectItem(itemIDs: [Int]) {
        selectedItemIDs = itemIDs
        print("selectedItemIDs \(selectedItemIDs)")
    }
    
    
}
