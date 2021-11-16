//
//  EntetTimeCheckOutVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 11/9/21.
//

import UIKit

class EntetTimeCheckOutVC: UIViewController {
    
    @IBOutlet weak var clockOutTimeLbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    var timeClockObject: TimeClockOB?
    var fromBackgroundStype = false 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clockOutTimeLbl.text = timeClockObject?.clockOutTime
        
        submitBtn.applyGradientUIButton(colours: ["0386E8".color, "0CA7EE".color], gradientOrientation: .horizontal)
    }
    
    @IBAction func submit(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
