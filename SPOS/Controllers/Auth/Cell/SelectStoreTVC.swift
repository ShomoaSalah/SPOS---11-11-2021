//
//  SelectStoreTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/24/21.
//

import UIKit

class SelectStoreTVC: UITableViewCell {

    @IBOutlet weak var storeNameLbl: UILabel!
    @IBOutlet weak var selectedStoreImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    private var item: MyStoresOB! {
        didSet{
            storeNameLbl.text = item.name
        }
    }


    func configure(data: MyStoresOB) {
        self.item = data
    }
    

}
