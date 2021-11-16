//
//  AddCustomerToTicketVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/5/21.
//

import UIKit

class AddCustomerToTicketVC: BaseVC {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTV()
        addRightButton() 
        self.title = "إضافة عميل إلى التذكرة"
    }
    

    func addRightButton() {
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 28))
        viewFN.backgroundColor = .clear
        
        
        let button1 = UIButton(frame: CGRect(x: 0,y: 8, width: 75, height: 28))
        button1.setTitle("إضافة عميل جديد", for: .normal)
        button1.setTitleColor("727272".color, for: .normal)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button1.addTarget(self, action: #selector(didTapOnAddNewClient), for: .touchUpInside)

       
      
        viewFN.addSubview(button1)
      
        
        
        
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    
    @objc func didTapOnAddNewClient(){
        let vc = UIStoryboard.init(name: "DepartmentSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddNewCustomersVC") as! AddNewCustomersVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}



extension AddCustomerToTicketVC: UITableViewDelegate, UITableViewDataSource {

    func initTV()  {
        tableView.delegate = self
        tableView.dataSource = self
     
        tableView.register(UINib(nibName: "AddCustomerToTicketTVC", bundle: nil), forCellReuseIdentifier: "AddCustomerToTicketTVC")

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCustomerToTicketTVC", for: indexPath) as! AddCustomerToTicketTVC
        cell.selectionStyle = .none
        
        return cell
    }
    

}
