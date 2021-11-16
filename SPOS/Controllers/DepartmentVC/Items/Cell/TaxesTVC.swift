//
//  TaxesTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/27/21.
//

import UIKit

class TaxesTVC: UITableViewCell {

    @IBOutlet weak var taxNameLbl: UILabel!
    @IBOutlet weak var enableTaxSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    private var item: Tax! {
        didSet{
            taxNameLbl.text = item.name
            
            if item.isChecked ?? true {
                enableTaxSwitch.isOn = true
            } else {
                enableTaxSwitch.isOn = false
            }
        }
    }


    func configure(data: Tax) {
        self.item = data
    }
    
    
}
