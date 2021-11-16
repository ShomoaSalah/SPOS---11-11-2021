//
//  CreateTaxVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/30/21.
//

import UIKit

class CreateTaxVC: BaseVC {

    @IBOutlet weak var taxTypeTwoLbl: UILabel!
    @IBOutlet weak var taxTypeTwoView: UIView!
    @IBOutlet weak var taxTypeOneLbl: UILabel!
    @IBOutlet weak var taxTypeOneView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "إنشاء ضريبة"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func selectTaxType(_ sender: UIButton) {
        
        //
        switch sender.tag {
        case 0:
            taxTypeOneView.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            taxTypeOneLbl.textColor = "0CA7EE".color
            
            taxTypeTwoView.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            taxTypeTwoLbl.textColor = "C3C5CE".color
            break
        case 1:
            
            taxTypeTwoView.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            taxTypeTwoLbl.textColor = "0CA7EE".color
            
            taxTypeOneView.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            taxTypeOneLbl.textColor = "C3C5CE".color
            
            
            break
        default:
            break
        }
    }
    
}
