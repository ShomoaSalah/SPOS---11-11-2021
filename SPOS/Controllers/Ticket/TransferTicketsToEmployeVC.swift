//
//  TransferTicketsToEmployeVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/5/21.
//

import UIKit

class TransferTicketsToEmployeVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "نقل التذكرة"
        
        initTV()
        
    }
    

}


extension TransferTicketsToEmployeVC: UITableViewDelegate, UITableViewDataSource {

    func initTV()  {
        tableView.delegate = self
        tableView.dataSource = self
     
        tableView.register(UINib(nibName: "TransferTicketsToEmployeTVC", bundle: nil), forCellReuseIdentifier: "TransferTicketsToEmployeTVC")

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransferTicketsToEmployeTVC", for: indexPath) as! TransferTicketsToEmployeTVC
        cell.selectionStyle = .none
        
        
        if  indexPath.row == 0 {
            cell.isSelected = true
            
            cell.containeerVieww.setBorder(width: 0.5, color: "0CA7EE".cgColor)
          
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
            }
        }
        else {
            cell.isSelected = false
        }
        
        
        cell.setSelected(cell.isSelected, animated: true)
        cell.layoutSubviews()
        
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TransferTicketsToEmployeTVC
       
        cell.containeerVieww.setBorder(width: 0.5, color: "0CA7EE".cgColor)
        cell.setSelected(true, animated: true)
        
         
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TransferTicketsToEmployeTVC

        tableView.deselectRow(at: indexPath, animated: false)
       
        cell.containeerVieww.setBorder(width: 0.5, color: "C3C5CE".cgColor)
        cell.setSelected(false, animated: true)
    }
    

}
