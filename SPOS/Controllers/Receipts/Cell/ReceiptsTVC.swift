//
//  ReceiptsTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/29/21.
//

import UIKit

class ReceiptsTVC: UITableViewCell {

    @IBOutlet weak var backgroundCircleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundCircleView.setRounded()
        backgroundCircleView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
