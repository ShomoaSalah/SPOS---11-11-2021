//
//  API.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/24/21.
//

import Foundation
import Alamofire
import Toast_Swift
import SVProgressHUD

class API {
    
    var view = UIViewController()
    
    static func startRequest(url:String, method:HTTPMethod = .get , parameters:[String:Any]? = nil , viewCon: UIViewController? = UIViewController(), completion:@escaping (Bool,ResponseObject?)->Void) {
        
        var headers = HTTPHeaders()
        headers["Accept-Language"] = UserDefaults.standard.string(forKey:"Language")
        headers["Accept"] = "application/json"
        
        if UserHelper.isLogin(){
            let token = (UserHelper.lodeUser()?.token)!
          
            headers["Authorization"] = "Bearer \(token)"
            print("Headers: ", headers)
        }
     
        if CheckInternet.Connection() {
            
            
            AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    print("Response \(response.result)")
                    
                    
                    switch response.result {
                        
                    case .success(let json):
                        
                        let jsonObject =  json as! [String:Any]
                        let responseObjcet = ResponseObject(json: jsonObject)
                        
                        if responseObjcet.status! &&  (responseObjcet.errors == nil || (responseObjcet.errors != nil && responseObjcet.errors!.isEmpty)) {
                            completion(true,responseObjcet)
                        }else{
                            
                            viewCon?.view.makeToast(responseObjcet.message!)
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            SVProgressHUD.dismiss()
                        }
                        
                        
                    case .failure(let error):
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            SVProgressHUD.dismiss()
                        }
                        
                        let json = ["message":error.localizedDescription]
                        let responseObjcet = ResponseObject(json: json)
                        completion(false,responseObjcet)
                        
                    }
            }
        }else{
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "NoWiFiVC")
            UIApplication.shared.windows.first?.rootViewController = rootViewController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
        }
        
        
    }
    
    
    static func getCountriesList(completion:@escaping ([CountriesOB], Bool, String) -> Void) {
        
        let requestUrl = APIConstant.countries
        print("requestUrl countries List \(requestUrl)")
        
        startRequest(url: requestUrl) {(status, responesObject) in
            if status {
                do{
                    
                    let object = try JSONDecoder().decode([CountriesOB].self, from: responesObject?.data as! Data)
                    completion(object, status, responesObject?.message ?? "")
                    
                }catch{
                    completion([CountriesOB](), status, responesObject?.message ?? "")
                }
                
            }else{
                completion([CountriesOB](), status, responesObject?.message ?? "")
            }
        }
    }

    static func getStoresList(completion:@escaping ([MyStoresOB], Bool, String) -> Void) {
        
        let requestUrl = APIConstant.myStores
        print("requestUrl my Stores \(requestUrl)")
        
        startRequest(url: requestUrl) {(status, responesObject) in
            if status {
                do{
                    
                    let object = try JSONDecoder().decode([MyStoresOB].self, from: responesObject?.data as! Data)
                    completion(object, status, responesObject?.message ?? "")
                    
                }catch{
                    completion([MyStoresOB](), status, responesObject?.message ?? "")
                }
                
            }else{
                completion([MyStoresOB](), status, responesObject?.message ?? "")
            }
        }
    }
 
    static func getColorsList(completion:@escaping ([ColorsOB], Bool, String) -> Void) {
        
        let requestUrl = APIConstant.getColors
        print("requestUrl get Colors \(requestUrl)")
        
        startRequest(url: requestUrl) {(status, responesObject) in
            if status {
                do{
                    
                    let object = try JSONDecoder().decode([ColorsOB].self, from: responesObject?.data as! Data)
                    completion(object, status, responesObject?.message ?? "")
                    
                }catch{
                    completion([ColorsOB](), status, responesObject?.message ?? "")
                }
                
            }else{
                completion([ColorsOB](), status, responesObject?.message ?? "")
            }
        }
    }
   
    static func getCategoriesList(completion:@escaping ([CategorieOB], Bool, String) -> Void) {
        
        let requestUrl = APIConstant.getCategoriesWithoutPagination
        print("requestUrl getCategoriesWithoutPagination \(requestUrl)")
        
        startRequest(url: requestUrl) {(status, responesObject) in
            if status {
                do{
                    
                    let object = try JSONDecoder().decode([CategorieOB].self, from: responesObject?.data as! Data)
                    completion(object, status, responesObject?.message ?? "")
                    
                }catch{
                    completion([CategorieOB](), status, responesObject?.message ?? "")
                }
                
            }else{
                completion([CategorieOB](), status, responesObject?.message ?? "")
            }
        }
    }
    
    
    static func submitAddItem(url: String, _ param: [String:Any], auth: [String:String]?,_ imageKey:String = "image",_ image: UIImage?, viewCon: UIViewController? ,completion: @escaping (Bool,ResponseObject?)->Void) {
        
        SVProgressHUD.show()
        
        var headers = HTTPHeaders()
        if UserHelper.isLogin(){
            let token = (UserHelper.lodeUser()?.token)!
            headers["Authorization"] = "Bearer \(token)"
            
            headers["Accept"] = "application/json"
            print("Headers: ", headers)
        }
      
        if CheckInternet.Connection() {
            
            AF.upload(multipartFormData: { (multipartFormData) in
                if let imageData = image{
                    let data =  imageData.jpegData(compressionQuality:0.50)
                    multipartFormData.append(data ?? Data(), withName: imageKey, fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
                
                for (key, value) in param {
                    multipartFormData.append(("\(value)".data(using: String.Encoding.utf8))!, withName: key)
                }
                
                
            } ,to: url, headers: headers).responseJSON { (response) in
                SVProgressHUD.dismiss()
                
                switch(response.result)
                {
                case .success(let value):
                    if let resp = value as? NSDictionary {
                        
                        let responseObjcet = ResponseObject(json: resp as! [String : Any])
                        let status = resp.value(forKey: "status") as? Bool ?? false
                        let message = resp.value(forKey: "message") as? String ?? ""
                        let errors = resp.value(forKey: "errors") as? [Any]
                        
                        if status && (errors == nil || (errors != nil && errors!.isEmpty) ){
                            SVProgressHUD.dismiss()
                            completion(true,responseObjcet)
                        }else{
                            SVProgressHUD.dismiss()
                            
                            viewCon?.view.makeToast(message)
                            
                        }
                        
                    }
                    break
                case .failure(let error):
                  
                    SVProgressHUD.dismiss()
                    viewCon?.view.makeToast(error.localizedDescription)
                    
                    break
                    
                }
                
            }
            
        }
        else{
            SVProgressHUD.dismiss()
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "NoWiFiVC")
            UIApplication.shared.windows.first?.rootViewController = rootViewController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
            
        }
        
    }
    /*
    
    static func sendMultiPartMultiImageSingle2Image(url: String, _ param: [String:Any], auth: [String:String]?,_ imagesKey:String = "images[]", _ images : [UIImage] = [] , imageKey:String = "image",_ image: UIImage?,_ idImageKey:String = "id_image",_ idImage: UIImage?, viewCon: UIViewController? ,completion: @escaping (Bool,ResponseObject?)->Void) {
        
        SVProgressHUD.show()
        
        var headers = HTTPHeaders()
      
        headers["Accept"] = "application/json"
        headers["Accept-Language"] = UserDefaults.standard.string(forKey:"Language")

        if UserHelper.isLogin(){
            let token = (UserHelper.lodeUser()?.token)!
            headers["Authorization"] = "Bearer \(token)"
            print("Headers: ", headers)
        }
        
        if CheckInternet.Connection() {
            
            
            AF.upload(multipartFormData: { (multipartFormData) in
                
                
                if let imageData = image{
                    let data =  imageData.jpegData(compressionQuality:0.50)
                    multipartFormData.append(data ?? Data(), withName: imageKey, fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
                if let idImageData = idImage {
                    let data =  idImageData.jpegData(compressionQuality:0.50)
                    multipartFormData.append(data ?? Data(), withName: idImageKey, fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
                
                
                for img in images {
                    let data =  img.jpegData(compressionQuality:0.50)
                    
                    multipartFormData.append(data!, withName: imagesKey, fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
                
                
                
                
                for (key, value) in param {
                    multipartFormData.append(("\(value)".data(using: String.Encoding.utf8))!, withName: key)
                }
            } ,to: url, headers: headers).responseJSON { (response) in
                SVProgressHUD.dismiss()
                
                print("responseResult32232 \(response.result)")
                
                
                switch(response.result)
                {
                case .success(let value):
                    if let resp = value as? NSDictionary {
                        SVProgressHUD.dismiss()
                        
                        let responseObjcet = ResponseObject(json: resp as! [String : Any])
                        let status = resp.value(forKey: "status") as? Bool ?? false
                        let message = resp.value(forKey: "message") as? String ?? ""
                        let errors = resp.value(forKey: "errors") as? [Any]
                        
                        if status && (errors == nil || (errors != nil && errors!.isEmpty) ){
                            completion(true,responseObjcet)
                        }else{
                            SVProgressHUD.dismiss()
                            viewCon?.view.makeToast(message)
//                            viewCon?.navigationController?.view.makeToast(message)
                        }
                        
                    }
                    break
                case .failure(let error):
                    
                    SVProgressHUD.dismiss()
                    print("Error \(error.localizedDescription)")
                    break
                    
                }
                
            }
            
        }
        else{
            SVProgressHUD.dismiss()
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "NoWiFiVC")
            UIApplication.shared.windows.first?.rootViewController = rootViewController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
            
            
//            viewCon?.navigationController?.view.makeToast(NSLocalizedString("noInternet", comment: ""))
        }
        
    }

    
    
    static func sendMultiPartMultiImageUpdateAqarSingle2Image(url: String, _ param: [String:Any], auth: [String:String]?,_ imagesKey:String = "images", _ images : [UIImage] = [] , imageKey:String = "image",_ image: UIImage?,_ idImageKey:String = "id_image",_ idImage: UIImage?, viewCon: UIViewController? ,completion: @escaping (Bool,ResponseObject?)->Void) {
        
        SVProgressHUD.show()
        
        var headers = HTTPHeaders()
        headers["Accept-Language"] = UserDefaults.standard.string(forKey:"Language")
        headers["Accept"] = "application/json"
        
        if UserHelper.isLogin(){
            let token = (UserHelper.lodeUser()?.token)!
            headers["Authorization"] = "Bearer \(token)"
            print("Headers: ", headers)
        }
        
        if CheckInternet.Connection() {
            
            
            AF.upload(multipartFormData: { (multipartFormData) in
                
                
                if let imageData = image{
                    let data =  imageData.jpegData(compressionQuality:0.50)
                    multipartFormData.append(data ?? Data(), withName: imageKey, fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
                if let idImageData = idImage {
                    let data =  idImageData.jpegData(compressionQuality:0.50)
                    multipartFormData.append(data ?? Data(), withName: idImageKey, fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
                
                
                for img in images {
                    let data =  img.jpegData(compressionQuality:0.50)
                    
                    multipartFormData.append(data!, withName: imagesKey, fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
              
                
                for (key, value) in param {
                    multipartFormData.append(("\(value)".data(using: String.Encoding.utf8))!, withName: key)
                }
            } ,to: url, headers: headers).responseJSON { (response) in
                SVProgressHUD.dismiss()
                
                print("responseResult32232 \(response.result)")
                
                
                switch(response.result)
                {
                case .success(let value):
                    if let resp = value as? NSDictionary {
                        SVProgressHUD.dismiss()
                        
                        let responseObjcet = ResponseObject(json: resp as! [String : Any])
                        let status = resp.value(forKey: "status") as? Bool ?? false
                        let message = resp.value(forKey: "message") as? String ?? ""
                        let errors = resp.value(forKey: "errors") as? [Any]
                        
                        if status && (errors == nil || (errors != nil && errors!.isEmpty) ){
                            completion(true,responseObjcet)
                        }else{
                            SVProgressHUD.dismiss()
                            viewCon?.view.makeToast(message)
//                            viewCon?.navigationController?.view.makeToast(message)
                        }
                        
                    }
                    break
                case .failure(let error):
                    
                    SVProgressHUD.dismiss()
                    print("Error \(error.localizedDescription)")
                    break
                    
                }
                
            }
            
        }
        else{
            SVProgressHUD.dismiss()
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "NoWiFiVC")
            UIApplication.shared.windows.first?.rootViewController = rootViewController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
            
//            viewCon?.navigationController?.view.makeToast(NSLocalizedString("noInternet", comment: ""))
        }
        
    }
    
    */
}
