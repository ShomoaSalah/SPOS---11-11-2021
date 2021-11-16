//
//  TopListVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/5/21.
//

import UIKit

protocol TopListProtocol {
    func didClose(addToClinet: Bool, transferTicketToEmployee: Bool)
}


class TopListVC: BaseVC {

    @IBOutlet weak var topView: UIView!
    
    var delegate: TopListProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        topView.layer.cornerRadius = 20
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        
    }
    
    @IBAction func transferToSpecificView(_ sender: UIButton) {
        /*
         tag
         0: حذف التذكرة
         1:
         2: اضافة الى عميل
         3:
         4: موظف تاني
         5:
         
         */
        
//        switch sender./
        //     postNotificationCenter(.openShift)
//        self.navigationController?.popViewController(animated: true)
        
        switch sender.tag {
        case 0:
            postNotificationCenter(.deleteTicket)
            self.dismiss(animated: true, completion: nil)
            break
        case 1:
            break
        case 2:
            
          
            self.dismiss(animated: true) {
                self.delegate?.didClose(addToClinet: true, transferTicketToEmployee: false)
            }

            
            break
        case 3:
            break
        case 4:
            self.dismiss(animated: true) {
                self.delegate?.didClose(addToClinet: false, transferTicketToEmployee: true)
            }
            break
        case 5:
            break
        default:
            break
        }
    }
    
}
