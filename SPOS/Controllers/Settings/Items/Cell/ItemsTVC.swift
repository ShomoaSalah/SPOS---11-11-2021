//
//  ItemsTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/30/21.
//

import UIKit
import SDWebImage

class ItemsTVC: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemSelectedImage: UIImageView!
    @IBOutlet weak var itemTitleLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        itemImage.setRounded()
        itemImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    private var item: ItemsOB! {
        didSet{
            itemImage.backgroundColor =  UIColor(hex: item.colorName ?? "")
            itemTitleLbl.text = item.name
            
            if item.isChecked ?? false {
               itemSelectedImage.image = UIImage(named: "ic-checkGreen-Box")
            }else {
                itemSelectedImage.image = UIImage(named: "ic-Box")
            }
        }
    }


    func configure(data: ItemsOB) {
        self.item = data
    }
    
    
}
