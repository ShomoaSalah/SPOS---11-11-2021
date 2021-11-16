//
//  TransferTicketsToEmployeTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/5/21.
//

import UIKit

class TransferTicketsToEmployeTVC: UITableViewCell {

    @IBOutlet weak var employeeImage: UIImageView!
    @IBOutlet weak var containeerVieww: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        employeeImage.setRounded()
        employeeImage.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
