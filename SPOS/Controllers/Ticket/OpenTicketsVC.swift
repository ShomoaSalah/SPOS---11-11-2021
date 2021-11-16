//
//  OpenTicketsVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/5/21.
//

import UIKit

class OpenTicketsVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "التذاكر المفتوحة"
        initTV()
        addRightButton()
    }
 
   
    func addRightButton(){
     
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 40))
        viewFN.backgroundColor = .clear
        
//        let button1 = UIButton(frame: CGRect(x: 26,y: 8, width: 24, height: 24))
        let button1 = UIButton(frame: CGRect(x: 0,y: 8, width: 24, height: 24))
        button1.setImage(UIImage(named: "ic-swap"), for: .normal)
        
        button1.addTarget(self, action: #selector(didTapOnOpenTicket), for: .touchUpInside)
        
        
        let button2 = UIButton(frame: CGRect(x: 26,y: 8, width: 24, height: 24))
        button2.setImage(UIImage(named: "img-transferTicket"), for: .normal)
        
        button2.addTarget(self, action: #selector(didTapOnTransferTicket), for: .touchUpInside)
        
        
        let button3 = UIButton(frame: CGRect(x: 58,y: 8, width: 18, height: 30))
        button3.setImage(UIImage(named: "img-delete"), for: .normal)

       //button3.addTarget(self, action: #selector(didTapOnDeleteTicket), for: .touchUpInside)

        
        viewFN.addSubview(button1)
        viewFN.addSubview(button2)
        viewFN.addSubview(button3)
        
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.rightBarButtonItem = rightBarButton

   }
    
    
    @objc func didTapOnTransferTicket(){
        let vc = UIStoryboard.init(name: "TicketSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "TransferTicketsVC") as! TransferTicketsVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
     
    
    //didTapOnOpenTicket
    @objc func didTapOnOpenTicket(){
        let vc = UIStoryboard.init(name: "TicketSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "TransferTicketsToEmployeVC") as! TransferTicketsToEmployeVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension OpenTicketsVC: UITableViewDelegate, UITableViewDataSource {
    
    func initTV()  {
        tableView.delegate = self
        tableView.dataSource = self
     
        tableView.register(UINib(nibName: "OpenTicketsTVC", bundle: nil), forCellReuseIdentifier: "OpenTicketsTVC")

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OpenTicketsTVC", for: indexPath) as! OpenTicketsTVC
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        postNotificationCenter(.openTicket)
        self.navigationController?.popViewController(animated: true)
    }
    
}
