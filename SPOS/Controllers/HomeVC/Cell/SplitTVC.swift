//
//  SplitTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/4/21.
//

import UIKit

class SplitTVC: UITableViewCell {

    @IBOutlet weak var sendingCompletedImage: UIImageView!
    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        
        sendingCompletedImage.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
