//
//  CustomerShowVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/30/21.
//

import UIKit

class CustomerShowVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "عرض العميل"
        initTV()
    }
    

    @IBAction func didTapOnCreateCustomerShow(_ sender: UIButton) {
       
        let vc = UIStoryboard.init(name: "SettingsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "CreateCustomerOfferVC") as! CreateCustomerOfferVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CustomerShowVC: UITableViewDataSource, UITableViewDelegate {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerShowTVC", for: indexPath) as! CustomerShowTVC
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "SettingsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditCustomerOfferVC") as! EditCustomerOfferVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

