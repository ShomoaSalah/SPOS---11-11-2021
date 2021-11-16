//
//  SelectPOSTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/24/21.
//

import UIKit

class SelectPOSTVC: UITableViewCell {

    @IBOutlet weak var posNameLbl: UILabel!
    @IBOutlet weak var selectedPOSImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    private var item: MyPOSOB! {
        didSet{
            posNameLbl.text = item.name
        }
    }


    func configure(data: MyPOSOB) {
        self.item = data
    }
    
}
