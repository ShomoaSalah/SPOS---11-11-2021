//
//  PinCode3VC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/12/21.
//

import UIKit

class EntetTimeCheckInVC: UIViewController {
    
    @IBOutlet weak var clockInTimeLbl: UILabel!
    @IBOutlet weak var homeBtn: UIButton!
    var timeClockObject: TimeClockOB?
    var fromBackgroundStype = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clockInTimeLbl.text = timeClockObject?.clockInTime
        homeBtn.applyGradientUIButton(colours: ["0386E8".color, "0CA7EE".color], gradientOrientation: .horizontal)
    }
    
    
    @IBAction func goTOHome(_ sender: UIButton) {
        
        if fromBackgroundStype {
            self.dismiss(animated: true, completion: nil)
        }else {
            let vc = UIStoryboard.init(name: "HomeSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomTabBar") as! CustomTabBar
        
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
       
        
    }
    
}
