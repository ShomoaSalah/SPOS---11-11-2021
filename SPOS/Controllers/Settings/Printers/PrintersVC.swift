//
//  PrintersVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/29/21.
//

import UIKit

class PrintersVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.title = "الطابعات"
        initTV()

    }
 
    @IBAction func didTapOnCreatePrinter(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "SettingsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "CreatePrinterVC") as! CreatePrinterVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension PrintersVC: UITableViewDataSource, UITableViewDelegate {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrintersTVC", for: indexPath) as! PrintersTVC
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "SettingsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditPrinterVC") as! EditPrinterVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

