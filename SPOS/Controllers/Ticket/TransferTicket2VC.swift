//
//  TransferTicket2VC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/5/21.
//

import UIKit

class TransferTicket2VC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTV() 
        addRightButton()
        self.title = "نقل التذكرة"
        
    }
    
    
    func addRightButton() {
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 28))
        viewFN.backgroundColor = .clear
        
        let button1 = UIButton(frame: CGRect(x: 0,y: 8, width: 75, height: 28))
        button1.setTitle("تذكرة مخصصة", for: .normal)
        button1.setTitleColor("727272".color, for: .normal)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button1.addTarget(self, action: #selector(didTapOnCustomTicket), for: .touchUpInside)

        viewFN.addSubview(button1)
      
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    @objc func didTapOnCustomTicket(){
        let vc = UIStoryboard.init(name: "TicketSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomTicket2VC") as! CustomTicket2VC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }


}




extension TransferTicket2VC: UITableViewDelegate, UITableViewDataSource {

    func initTV()  {
        tableView.delegate = self
        tableView.dataSource = self
     
        tableView.register(UINib(nibName: "TransferTicket2TVC", bundle: nil), forCellReuseIdentifier: "TransferTicket2TVC")

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransferTicket2TVC", for: indexPath) as! TransferTicket2TVC
        cell.selectionStyle = .none
        
        return cell
    }
    

}
