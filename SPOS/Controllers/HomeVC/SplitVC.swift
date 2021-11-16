//
//  SplitVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/4/21.
//

import UIKit

class SplitVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countLbl: UILabel!
    
    var count = 0
    var  indexPath2: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "السداد"
        initTV()
        countLbl.text = "\(count)"
        addRightButton()
    }
    

    @IBAction func countPlus(_ sender: UIButton) {
        count = count+1
        countLbl.text = "\(count)"
        tableView.reloadData()
    }
    @IBAction func countMinus(_ sender: UIButton) {
        
        if count >= 0 {
            count = count-1
            countLbl.text = "\(count)"
            tableView.reloadData()
        }
      
    }
    
    
    func addRightButton() {
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 28))
        viewFN.backgroundColor = .clear
        
        
        let button1 = UIButton(frame: CGRect(x: 0,y: -4, width: 45, height: 28))
        button1.setTitle("تم", for: .normal)
        button1.setTitleColor("727272".color, for: .normal)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 12)
//        button1.addTarget(self, action: #selector(didTapOnSelectAll), for: .touchUpInside)

       
      
        viewFN.addSubview(button1)
      
        
        
        
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        addNotificationObserver(.customTicket, #selector(customTicket))

    }
   var fromCustomTicket = false
    @objc func customTicket(){
        fromCustomTicket = true
        tableView.reloadRows(at: [indexPath2!], with: .automatic)
//        tableView.reloadData()
        
    }
}

extension SplitVC: UITableViewDelegate, UITableViewDataSource {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SplitTVC", bundle: nil), forCellReuseIdentifier: "SplitTVC")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SplitTVC", for: indexPath) as! SplitTVC
        cell.selectionStyle = .none
        
        if fromCustomTicket{
            cell.sendingCompletedImage.isHidden = false
            cell.payBtn.isHidden = true
        }else {
            cell.sendingCompletedImage.isHidden = true
            cell.payBtn.isHidden = false
        }
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
        
        cell.payBtn.tag = indexPath.row
        cell.payBtn.addTarget(self, action: #selector(payBtn), for: .touchUpInside)
        return cell
    }
    
    
    @objc func deleteCell(_ sender: UIButton) {

//        objects.remove(at: 0)
        let indexPath = IndexPath(row: sender.tag, section: 0)
        count = count - 1
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    @objc func payBtn(_ sender: UIButton) {
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        indexPath2 = indexPath
        
        let vc = UIStoryboard.init(name: "HomeDetailsSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomTicketVC") as! CustomTicketVC
        self.navigationItem.hideBackWord()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
}
