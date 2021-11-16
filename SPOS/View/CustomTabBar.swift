//
//  CustomTabBar.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 9/29/21.
//

import UIKit

class CustomTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.barTintColor = .white
        self.tabBar.isTranslucent = false
        self.tabBar.shadowOffset = CGSize(width: 0, height: 0)
        self.tabBar.shadowColor = UIColor.black.withAlphaComponent(0.3)
        self.tabBar.shadowOpacity = 0.3
        
        
    }
    

  

}
