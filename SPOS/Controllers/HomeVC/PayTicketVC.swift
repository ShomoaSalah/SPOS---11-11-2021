//
//  PayTicketVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/4/21.
//

import UIKit

class PayTicketVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTV()
        addRightButton()
        self.title = "السداد"
        
    }
    

    func addRightButton() {
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 28))
        viewFN.backgroundColor = .clear
        
        
        let button1 = UIButton(frame: CGRect(x: 0,y: -4, width: 45, height: 28))
        button1.setTitle("تقسيم", for: .normal)
        button1.setTitleColor("0CA7EE".color, for: .normal)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button1.addTarget(self, action: #selector(didTapOnSplit), for: .touchUpInside)

       
      
        viewFN.addSubview(button1)
      
        
        
        
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    @objc func didTapOnSplit(){
        let vc = UIStoryboard.init(name: "HomeDetailsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "SplitVC") as! SplitVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension PayTicketVC: UITableViewDataSource, UITableViewDelegate {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "PayTicketTVC", bundle: nil), forCellReuseIdentifier: "PayTicketTVC")
        
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PayTicketTVC", for: indexPath) as! PayTicketTVC
        cell.selectionStyle = .none
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if indexPath.row == 0 {
            let vc = UIStoryboard.init(name: "HomeDetailsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "CashPaymentDoneVC") as! CashPaymentDoneVC
            self.navigationItem.hideBackWord()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 1 {
           
            let vc = UIStoryboard.init(name: "HomeDetailsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "CardPaymentDoneVC") as! CardPaymentDoneVC
            self.navigationItem.hideBackWord()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}

