//
//  CategoriesTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit
import SDWebImage

class CategoriesTVC: UITableViewCell {

    @IBOutlet weak var categoryNameLbl: UILabel!
    @IBOutlet weak var categoriesImage: UIImageView!
    @IBOutlet weak var itemsCountLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        categoriesImage.setRounded()
        categoriesImage.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    private var item: CategorieOB! {
        didSet{
            categoryNameLbl.text = item.name
            categoriesImage.backgroundColor = UIColor(hex: item.colorName!)
            itemsCountLbl.text = item.itemsCount!.description + " available".localized
            
        }
    }


    func configure(data: CategorieOB) {
        self.item = data
    }
    

}
