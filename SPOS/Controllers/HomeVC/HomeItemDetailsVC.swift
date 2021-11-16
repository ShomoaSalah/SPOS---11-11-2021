//
//  HomeItemDetailsVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/3/21.
//

import UIKit

class HomeItemDetailsVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countLbl: UILabel!
    
    var count = 0
    var arrSelectedIndex = [IndexPath]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.title = "Details"
        initTV()
        addRightButton()
        
    }
    

    
    func addRightButton() {
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 28))
        viewFN.backgroundColor = .clear
        
        
        let button1 = UIButton(frame: CGRect(x: 0,y: -4, width: 30, height: 28))
        button1.setTitle("حفظ", for: .normal)
        button1.setTitleColor("0CA7EE".color, for: .normal)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 12)

        viewFN.addSubview(button1)
      
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    
    
    @IBAction func countPlus(_ sender: UIButton) {
        count = count+1
        countLbl.text = "\(count)"
    }
    
    @IBAction func countMinus(_ sender: UIButton) {
        if count >= 0 {
            count = count-1
            countLbl.text = "\(count)"
        }
    }
    
}



extension HomeItemDetailsVC: UITableViewDataSource, UITableViewDelegate {
    
    func initTV() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "HomeItemDetailsSectionTVC", bundle: nil), forCellReuseIdentifier: "HomeItemDetailsSectionTVC")
        tableView.register(UINib(nibName: "HomeItemDetailsTVC", bundle: nil), forCellReuseIdentifier: "HomeItemDetailsTVC")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cellHeader = tableView.dequeueReusableCell(withIdentifier: "HomeItemDetailsSectionTVC") as! HomeItemDetailsSectionTVC
        
        return cellHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeItemDetailsTVC", for: indexPath) as! HomeItemDetailsTVC
        cell.selectionStyle = .none
        
        
//        if indexPath.section == 0 && indexPath.row == 0 {
        if  indexPath.row == 0 {
            cell.isSelected = true
            
            cell.containerVieww.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            cell.descriptionLbl.textColor = "0CA7EE".color
            cell.countLbl.textColor = "0CA7EE".color
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
            }
        }
        else {
            cell.isSelected = false
        }
        
        
        cell.setSelected(cell.isSelected, animated: true)
        cell.layoutSubviews()
        
        return cell
    }
    
    
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HomeItemDetailsTVC
       
      //  let item = cityArray[indexPath.row]
        
       
        if arrSelectedIndex.contains(indexPath) {
            arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
            tableView.deselectRow(at: indexPath, animated: false)
           
            cell.containerVieww.setBorder(width: 0.5, color: "0CA7EE".cgColor)
            cell.descriptionLbl.textColor = "0CA7EE".color
            cell.countLbl.textColor = "0CA7EE".color
           
         
            cell.setSelected(false, animated: true)
        } else {
            arrSelectedIndex.append(indexPath)
            cell.containerVieww.setBorder(width: 0.5, color: "C3C5CE".cgColor)
            cell.descriptionLbl.textColor = "202124".color
            cell.countLbl.textColor = "202124".color
            cell.setSelected(true, animated: true)
        }
        
        
        
        
       
        
        
    }

    
}

