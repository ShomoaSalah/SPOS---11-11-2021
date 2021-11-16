//
//  AllItemsTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/30/21.
//

import UIKit
import SDWebImage

class AllItemsTVC: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var inStockLbl: UILabel!
    @IBOutlet weak var priceStateLbl: UILabel!
    
    
    
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
            
            
          
            if item?.image != nil {
                //"image"
//                itemImage.sd_setImage(with: URL(string: item.image ?? ""), completed: nil)
                itemImage.sd_setImage(with: URL(string: item.image ?? ""), placeholderImage: UIImage(named: "img-logo4"))
            }

            if item!.colorName != nil {
                //"color"
                itemImage.backgroundColor = UIColor(hex: item.colorName ?? "")
            }
            
            
            
            itemNameLbl.text = item.name
            
            switch item.storeTracking {
            case 0:
                inStockLbl.text = "-"
                break
            case 1:
                inStockLbl.text = item.inStock!.description + " available".localized
                break
            default:
                break
            }
            
            priceStateLbl.text = item.priceState
        }
    }
    
    
    func configure(data: ItemsOB) {
        self.item = data
    }
    
    
}
