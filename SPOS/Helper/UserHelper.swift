//
//  UserHelper.swift
//  Provider
//
//  Created by شموع صلاح الدين on 4/14/21.
//

import Foundation
import UIKit

class UserHelper {
    
    static func isLogin() -> Bool{
        return UserHelper.lodeUser() != nil
    }
    
    static func saveUser(user: UserOB)  {
        
        let data = try! JSONEncoder().encode(user)
        
        let userdefult = UserDefaults.standard
        
        userdefult.set(data, forKey: "User")
        
    }
    
    
    static func lodeUser() -> UserOB?{
        let userdefult = UserDefaults.standard
        guard let userData = userdefult.object(forKey: "User") as? Data else{
            return nil
        }
        
    let user = try! JSONDecoder().decode(UserOB.self, from: userData)
        return user
    }
    
    
    static func deletUser(){
        let userdefult = UserDefaults.standard
        userdefult.removeObject(forKey: "User")
    }
    
    
    static func deletAccountTypeUser(){
        let userdefult = UserDefaults.standard
        userdefult.removeObject(forKey: "isUser")
    }
    
    
    
}


