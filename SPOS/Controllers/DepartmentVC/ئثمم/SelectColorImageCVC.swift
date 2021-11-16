//
//  SelectColorImageCVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit

class SelectColorImageCVC: UICollectionViewCell {
    
    @IBOutlet weak var imageCheck: UIImageView!
    @IBOutlet weak var colorImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    //    private var item: CategorieOB! {
    //        didSet{
    //            aqarTypeTitleLb.text = item.categoryName
    //        }
    //    }
    //
    //
    //    func configure(data: CategorieOB) {
    //        self.item = data
    //    }
    
    func setSelected(isSelected: Bool)  {
        if isSelected {
            imageCheck.isHidden = false
        }else {
            imageCheck.isHidden = true
            
        }
    }
    
    
}
