//
//  TransferTicketsVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/5/21.
//

import UIKit

class TransferTicketsVC: BaseVC {
  
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "نقل إلى"
        initTV()
        addRightButton()
    }
    
    
    func addRightButton(){
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        viewFN.backgroundColor = .clear
        
        
        let button1 = UIButton(frame: CGRect(x: 0,y: 8, width: 24, height: 30))
        button1.setImage(UIImage(named: "img-Filter 2"), for: .normal)

       button1.addTarget(self, action: #selector(didTapOnTicketFilter), for: .touchUpInside)

   
        viewFN.addSubview(button1)
      
        
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.rightBarButtonItem = rightBarButton

   }
    
    @objc func didTapOnTicketFilter(){
        let vc = UIStoryboard.init(name: "TicketSB", bundle: nil).instantiateViewController(withIdentifier: "TicketsFilterVC") as! TicketsFilterVC

        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
        
    }
    
}

extension TransferTicketsVC: UITableViewDataSource, UITableViewDelegate {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "TransferTicketsSecondTVC", bundle: nil), forCellReuseIdentifier: "TransferTicketsSecondTVC")
        
        tableView.register(UINib(nibName: "TransferTicketsFirstTVC", bundle: nil), forCellReuseIdentifier: "TransferTicketsFirstTVC")
        
        tableView.register(UINib(nibName: "TransferTicketsSectionTVC", bundle: nil), forCellReuseIdentifier: "TransferTicketsSectionTVC")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cellHeader = tableView.dequeueReusableCell(withIdentifier: "TransferTicketsSectionTVC") as! TransferTicketsSectionTVC
        
        return cellHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TransferTicketsFirstTVC", for: indexPath) as! TransferTicketsFirstTVC
            cell.selectionStyle = .none
            
            
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TransferTicketsSecondTVC", for: indexPath) as! TransferTicketsSecondTVC
            cell.selectionStyle = .none
            
            
            return cell
        }
      
    }
    
    
}



extension TransferTicketsVC: TicketsFilterProtocol {
   
    
    
    func didSelectTicketFilterType(filterID: String, filterTitle: String) {
        print("filterID \(filterID)")
    }
    
    func didSelectTicketsFilterType(filterIDs: [String], filterTitle: [String]) {
        print("filterIDs \(filterIDs)")
    }
}
