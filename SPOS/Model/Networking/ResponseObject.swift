//
//  ResponseObject.swift
//  SPOS
//
//  Created by شموع صلاح الدين on 10/24/21.
//

import Foundation

struct ResponseObject {
    
    var code: Int?
    var status: Bool?
    var message: String?
    var data: Any?
    var errors: [Any]?
    var pages: Any?
    
    init(json :[String:Any]){
        self.code = json["code"] as? Int
        self.status = json["status"] as? Bool
        self.message = json["message"] as? String
        self.errors = json["errors"] as? [Any]
        
        
        if let pages = json["pages"] {
            self.pages = try! JSONSerialization.data(withJSONObject:pages, options: [])
        }
        
        
        if  let data = json["data"] as? NSNull  { // Data = NULL
            return
        }
        
        if let data = json["data"] as? String { // Data = String
            self.data =  data
        } else  if let data = json["data"] as? Int { // Data = Int
            self.data =  data
        }else if let data = json["data"]{ // Data = Object
            self.data = try! JSONSerialization.data(withJSONObject:data, options: [])
        }
        
        
    }
    
    
}




// MARK: - Pages
class PagesOB: Codable {
    let currentPage: Int?
    let firstPageURL: String?
    let from: Int?
    let lastPage: Int?
    let lastPageURL: String?
    let nextPageURL: String?
    let path: String?
    let perPage: Int?
    let prevPageURL: String?
    let to: Int?
    let total: Int?
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
    
    init(currentPage: Int?, firstPageURL: String?, from: Int?, lastPage: Int?, lastPageURL: String?, nextPageURL: String?, path: String?, perPage: Int?, prevPageURL: String?, to: Int?, total: Int?) {
        self.currentPage = currentPage
        self.firstPageURL = firstPageURL
        self.from = from
        self.lastPage = lastPage
        self.lastPageURL = lastPageURL
        self.nextPageURL = nextPageURL
        self.path = path
        self.perPage = perPage
        self.prevPageURL = prevPageURL
        self.to = to
        self.total = total
    }
}
