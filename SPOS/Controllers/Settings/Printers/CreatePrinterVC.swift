//
//  CreatePrinterVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/30/21.
//

import UIKit

class CreatePrinterVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "إنشاء طابعة"
       
    }
    
    
    @IBAction func submitSearchForPrinters(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "SettingsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ItemsVC") as! ItemsVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
