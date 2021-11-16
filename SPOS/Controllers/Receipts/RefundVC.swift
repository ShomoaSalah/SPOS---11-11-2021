//
//  RefundVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/29/21.
//

import UIKit

class RefundVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    var arrSelectedIndex = [IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTV()
        self.title = "المبلغ المسترد"
    }
  

}


extension RefundVC: UITableViewDelegate, UITableViewDataSource {
    
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
        cell.checkImage.isHidden = false
        
        if indexPath.row == 0 {
            cell.isSelected = true
            cell.checkImage.image = UIImage(named: "img-Check")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
            }
        } else {
            cell.isSelected = false
           
        }
        cell.setSelected(cell.isSelected, animated: true)
        cell.layoutSubviews()
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ReceiptsDetailsTVC
        
        if arrSelectedIndex.contains(indexPath) {
            arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
            cell.checkImage.image = UIImage(named: "img-Uncheck")
            tableView.deselectRow(at: indexPath, animated: false)
            
            //                cities_uuid = cities_uuid.filter {$0 != item.uuid}
            //                citiesName = citiesName.filter {$0 != item.cityName}
            
            cell.setSelected(false, animated: true)
        }
        else {
            arrSelectedIndex.append(indexPath)
            cell.checkImage.image = UIImage(named: "img-Check")
            //                cities_uuid.append(item.uuid ?? "")
            //                citiesName.append(item.cityName ?? "")
            cell.setSelected(true, animated: true)
        }
    }
    
    
}
