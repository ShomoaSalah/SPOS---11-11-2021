//
//  TicketPersonVC.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/5/21.
//

import UIKit

class TicketPersonVC: BaseVC {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var payBtn: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "التذكرة"
        initTV()
        initCV()
        addRightButton()
      
        
    }
    
    
    func addRightButton(){
        
        let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 40))
        viewFN.backgroundColor = .clear
        
        
        let button1 = UIButton(frame: CGRect(x: 0,y: 5, width: 18, height: 30))
        button1.setImage(UIImage(named: "img-delete"), for: .normal)

       button1.addTarget(self, action: #selector(didTapOnDeleteTicket), for: .touchUpInside)

     
        
        let button2 = UIButton(frame: CGRect(x: 26,y: 8, width: 24, height: 24))
        button2.setImage(UIImage(named: "ic-swap"), for: .normal)
        
        button2.addTarget(self, action: #selector(didTapOnAddNewClient), for: .touchUpInside)

        
        let button3 = UIButton(frame: CGRect(x: 58,y: 8, width: 24, height: 24))
        button3.setImage(UIImage(named: "ic-Iconly-Bulk-Filter"), for: .normal)
        
//        button3.addTarget(self, action: #selector(didTapOnSendReceipt), for: .touchUpInside)
        
   
        viewFN.addSubview(button1)
        viewFN.addSubview(button2)
        viewFN.addSubview(button3)
        
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        self.navigationItem.rightBarButtonItem = rightBarButton

   }
    
    
    //didTapOnAddNewClient
       @objc func didTapOnAddNewClient(){
           let vc = UIStoryboard.init(name: "TicketSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddCustomerToTicketVC") as! AddCustomerToTicketVC
           self.navigationItem.hideBackWord()
           self.navigationController?.pushViewController(vc, animated: true)
       }
    
    @objc func didTapOnDeleteTicket(){
      
    }
  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    

}


//MARK: - Table View
extension TicketPersonVC: UITableViewDelegate, UITableViewDataSource {

    func initTV()  {
        tableView.delegate = self
        tableView.dataSource = self
     
        tableView.register(UINib(nibName: "TicketTVC", bundle: nil), forCellReuseIdentifier: "TicketTVC")

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketTVC", for: indexPath) as! TicketTVC
        cell.selectionStyle = .none
        return cell
    }


}

//MARK: - Collection View
extension TicketPersonVC: UICollectionViewDataSource, UICollectionViewDelegate {

    func initCV()  {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TicketCVC", bundle: nil), forCellWithReuseIdentifier: "TicketCVC")

    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  4
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketCVC", for: indexPath) as! TicketCVC
       // let item = imagesColor[indexPath.row]
      
        
        if indexPath.row == 0 {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredVertically)
            
//            aqarIDs.append(item.uuid ?? "")
//            aqarsTitle.append(item.categoryName ?? "")

            
        }else {
            cell.isSelected = false
        }

        cell.setSelected(isSelected: cell.isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TicketCVC
       
        cell.setSelected(isSelected: true)
      //  let item = imagesColor[indexPath.row]
//        aqarSelectedID = item.uuid ?? ""
//        aqarSelectedName = item.categoryName ?? ""
//
//
//        aqarIDs.append(item.uuid ?? "")
//        aqarsTitle.append(item.categoryName ?? "")
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! TicketCVC
       
        cell.setSelected(isSelected: false)
        
     //   let item = imagesColor[indexPath.row]
        
//        aqarIDs = aqarIDs.filter {$0 != item.uuid}
//        aqarsTitle = aqarIDs.filter {$0 != item.categoryName}
        
    }
    


}
