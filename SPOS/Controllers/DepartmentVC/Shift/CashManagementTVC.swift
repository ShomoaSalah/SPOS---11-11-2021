//
//  CashManagementTVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit

class CashManagementTVC: UITableViewCell {

    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var employeeNameLbl: UILabel!
    @IBOutlet weak var addTimeLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    private var item: CashManagementOB! {
        didSet{
            
            switch item.type {
            case 1: // pay-in
                amountLbl.text = item.amountFormat
                amountLbl.textColor = "028C59".color
                
                break
            case 2: // pay-out
                amountLbl.text = "-\(item.amountFormat!)"
                amountLbl.textColor = "FF4E54".color
                
                break
                
            default:
                break
            }
            
            employeeNameLbl.text = item.employeeName
            addTimeLbl.text = item.addTime
            
        }
    }


    func configure(data: CashManagementOB) {
        self.item = data
    }
    

}
