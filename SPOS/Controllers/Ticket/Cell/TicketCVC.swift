//
//  TicketCVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/5/21.
//

import UIKit

class TicketCVC: UICollectionViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var containerrView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setSelected(isSelected: Bool)  {
        if isSelected {
            containerrView.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            titleLbl.textColor = "0CA7EE".color
        }else {
            containerrView.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            titleLbl.textColor = "C3C5CE".color
            
        }
    }
    
}
