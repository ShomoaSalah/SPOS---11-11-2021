//
//  TicketsFilterVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/5/21.
//

import UIKit


protocol TicketsFilterProtocol {
    func didSelectTicketFilterType(filterID: String, filterTitle: String)
    func didSelectTicketsFilterType(filterIDs: [String], filterTitle: [String])
}


class TicketsFilterVC: BaseVC {

    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    
    @IBOutlet weak var employeeBtn: UIButton!
    @IBOutlet weak var timeBtn: UIButton!
    @IBOutlet weak var valueBtn: UIButton!
    @IBOutlet weak var nameBtn: UIButton!
    
    var delegate: TicketsFilterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bottomView.layer.cornerRadius = 20
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
        submitBtn.applyGradientUIButton(colours: ["0386E8".color, "0CA7EE".color], gradientOrientation: .horizontal)
    }
    

 
    @IBAction func hideView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
     employeeBtn
     timeBtn
     valueBtn
     nameBtn
     */
    @IBAction func selectOneToFilter(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            sender.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            sender.backgroundColor = "0CA7EE".color.withAlphaComponent(0.1)
            sender.setTitleColor("0CA7EE".color, for: .normal)
            
            timeBtn.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            timeBtn.backgroundColor = .white
            timeBtn.setTitleColor("C3C5CE".color, for: .normal)
            
            valueBtn.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            valueBtn.backgroundColor = .white
            valueBtn.setTitleColor("C3C5CE".color, for: .normal)
            
            nameBtn.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            nameBtn.backgroundColor = .white
            nameBtn.setTitleColor("C3C5CE".color, for: .normal)
            
            break
        case 1:
            sender.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            sender.backgroundColor = "0CA7EE".color.withAlphaComponent(0.1)
            sender.setTitleColor("0CA7EE".color, for: .normal)

            employeeBtn.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            employeeBtn.backgroundColor = .white
            employeeBtn.setTitleColor("C3C5CE".color, for: .normal)
            
            valueBtn.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            valueBtn.backgroundColor = .white
            valueBtn.setTitleColor("C3C5CE".color, for: .normal)
            
            nameBtn.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            nameBtn.backgroundColor = .white
            nameBtn.setTitleColor("C3C5CE".color, for: .normal)
            
            
            break
        case 2:
            sender.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            sender.backgroundColor = "0CA7EE".color.withAlphaComponent(0.1)
            sender.setTitleColor("0CA7EE".color, for: .normal)

            employeeBtn.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            employeeBtn.backgroundColor = .white
            employeeBtn.setTitleColor("C3C5CE".color, for: .normal)
            
            timeBtn.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            timeBtn.backgroundColor = .white
            timeBtn.setTitleColor("C3C5CE".color, for: .normal)
            
            nameBtn.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            nameBtn.backgroundColor = .white
            nameBtn.setTitleColor("C3C5CE".color, for: .normal)
            
            break
        case 3:
            sender.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            sender.backgroundColor = "0CA7EE".color.withAlphaComponent(0.1)
            sender.setTitleColor("0CA7EE".color, for: .normal)

            
            employeeBtn.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            employeeBtn.backgroundColor = .white
            employeeBtn.setTitleColor("C3C5CE".color, for: .normal)
            
            timeBtn.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            timeBtn.backgroundColor = .white
            timeBtn.setTitleColor("C3C5CE".color, for: .normal)
            
            valueBtn.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            valueBtn.backgroundColor = .white
            valueBtn.setTitleColor("C3C5CE".color, for: .normal)
            
            
            break
        default:
            break
        }
    }
}
