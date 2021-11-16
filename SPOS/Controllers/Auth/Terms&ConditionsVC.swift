//
//  Terms&ConditionsVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/14/21.
//

import UIKit

class Terms_ConditionsVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var termsTV: UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        termsTV.isEditable = false
        
    }
    


}
