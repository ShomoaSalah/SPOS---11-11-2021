//
//  ReceiptsVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/29/21.
//

import UIKit

class ReceiptsVC: BaseVC {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "الإيصالات"
        initTV()
        addLeftButton()
    }
    
    func addLeftButton() {
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 86, height: 28))
        viewFN.backgroundColor = .clear
        
        
        let button1 = UIButton(frame: CGRect(x: 0,y: -4, width: 40, height: 28))
        button1.setImage(UIImage(named: "img-logo4"), for: .normal)
        button1.contentMode = .scaleAspectFill
        
        let button2 = UIButton(frame: CGRect(x: 44,y: -4, width: 28, height: 28))
        button2.setImage(UIImage(named: "img-logo445"), for: .normal)
        button2.contentMode = .scaleAspectFill
      
        viewFN.addSubview(button1)
        viewFN.addSubview(button2)
        
        
        
        let leftBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowOffset = CGSize(width: 0, height: 5)
        self.navigationController?.navigationBar.shadowColor = "CECECE".color.withAlphaComponent(0.5)
        self.navigationController?.navigationBar.shadowOpacity = 0.8
        
    }

}

extension ReceiptsVC: UITableViewDataSource, UITableViewDelegate {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "ReceiptsTVC", bundle: nil), forCellReuseIdentifier: "ReceiptsTVC")
        
        tableView.register(UINib(nibName: "ReceiptsSectionTVC", bundle: nil), forCellReuseIdentifier: "ReceiptsSectionTVC")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cellHeader = tableView.dequeueReusableCell(withIdentifier: "ReceiptsSectionTVC") as! ReceiptsSectionTVC
        
        return cellHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 43.0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptsTVC", for: indexPath) as! ReceiptsTVC
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "ReceiptsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReceiptsDetailsVC") as! ReceiptsDetailsVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
  
    }
    
}

