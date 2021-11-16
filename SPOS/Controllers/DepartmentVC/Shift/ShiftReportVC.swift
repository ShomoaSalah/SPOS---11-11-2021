//
//  ShiftReportVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit

class ShiftReportVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "تقرير المناوبة"
        initTV()
       
    }
    


}



extension ShiftReportVC: UITableViewDataSource, UITableViewDelegate {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "ShiftTVC", bundle: nil), forCellReuseIdentifier: "ShiftTVC")
        
        tableView.register(UINib(nibName: "ShiftHeaderTVC", bundle: nil), forCellReuseIdentifier: "ShiftHeaderTVC")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cellHeader = tableView.dequeueReusableCell(withIdentifier: "ShiftHeaderTVC") as! ShiftHeaderTVC
        
        return cellHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShiftTVC", for: indexPath) as! ShiftTVC
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = UIStoryboard.init(name: "ReceiptsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReceiptsDetailsVC") as! ReceiptsDetailsVC
//        self.navigationItem.hideBackWord()
//        self.navigationController?.pushViewController(vc, animated: true)
  
    }
    
}

