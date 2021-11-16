//
//  modificationsTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/27/21.
//

import UIKit

class ModificationsTVC: UITableViewCell {

    @IBOutlet weak var modificationTitleLbl: UILabel!
    @IBOutlet weak var modificationDescriptionLbl: UILabel!
    @IBOutlet weak var enableModificationSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    private var item: Modification! {
        didSet{
            modificationTitleLbl.text = item.name
            modificationDescriptionLbl.text = item.optionsNameString
            
        }
    }


    func configure(data: Modification) {
        self.item = data
    }
}
