//
//  PinCode3VC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/12/21.
//

import UIKit

class EntetTimeCheckInVC: UIViewController {
    
    @IBOutlet weak var homeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeBtn.applyGradientUIButton(colours: ["0386E8".color, "0CA7EE".color], gradientOrientation: .horizontal)
    }
    
    
    
}
