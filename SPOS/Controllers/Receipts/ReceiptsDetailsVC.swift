//
//  ReceiptsDetailsVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/29/21.
//

import UIKit

class ReceiptsDetailsVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    var titleNew = ""
    
    var isReceiptsRefund = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTV()
        addRightButton()
        
        tableView.layoutTableHeaderView()
    }
    
    
    func addRightButton(){
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 109, height: 40))
        viewFN.backgroundColor = .clear
        
        
        let button1 = UIButton(frame: CGRect(x: 0,y: 8, width: 80, height: 30))
        button1.setTitle("المبلغ المسترد", for: .normal)
        button1.setTitleColor("0CA7EE".color, for: .normal)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button1.addTarget(self, action: #selector(didTapOnRefundBtn), for: .touchUpInside)

        if isReceiptsRefund {
            button1.isHidden = true
            tableView.layoutTableHeaderView()
        }else {
            button1.isHidden = false
            tableView.layoutTableHeaderView()
        }
        
        let button2 = UIButton(frame: CGRect(x: 84,y: 8, width: 24, height: 24))
        button2.setImage(UIImage(named: "img-send-EN"), for: .normal)
        
        button2.addTarget(self, action: #selector(didTapOnSendReceipt), for: .touchUpInside)
        
   
        viewFN.addSubview(button1)
        viewFN.addSubview(button2)
        
        
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.rightBarButtonItem = rightBarButton

   }
    
    
    @objc func didTapOnSendReceipt(){
       
        let vc = UIStoryboard.init(name: "ReceiptsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "SendReceiptVC") as! SendReceiptVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
  
    @objc func didTapOnRefundBtn(){
       
        let vc = UIStoryboard.init(name: "ReceiptsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "RefundVC") as! RefundVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension ReceiptsDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ReceiptsDetailsTVC", bundle: nil), forCellReuseIdentifier: "ReceiptsDetailsTVC")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptsDetailsTVC", for: indexPath) as! ReceiptsDetailsTVC
        cell.selectionStyle = .none
        cell.checkImage.isHidden = true
        
        
      
        return cell
    }
    
    
    
   
    
}
