//
//  CustomTicketVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/5/21.
//

import UIKit

class CustomTicketVC: BaseVC {

    @IBOutlet weak var submitBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "السداد"
        submitBtn.applyGradientUIButton(colours: ["0386E8".color, "0CA7EE".color], gradientOrientation: .horizontal)
       
    }
    
    @IBAction func submit(_ sender: UIButton) {
        postNotificationCenter(.customTicket)
        self.navigationController?.popViewController(animated: true)
    }
    
}
