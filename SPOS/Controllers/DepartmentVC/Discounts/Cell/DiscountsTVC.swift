//
//  DiscountsTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit

class DiscountsTVC: UITableViewCell {

    @IBOutlet weak var discountNameLbl: UILabel!
    @IBOutlet weak var amountValueLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    private var item: DiscountsOB! {
        didSet{
            discountNameLbl.text = item.name
            amountValueLbl.text = item.amountValue
        }
    }


    func configure(data: DiscountsOB) {
        self.item = data
    }
    
    

}
