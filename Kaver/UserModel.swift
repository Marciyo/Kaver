//
//  UserModel.swift
//

import ObjectMapper

class UserModel: Mappable {
    
    var email: String?
    var token: String?
    var name: String?
    var surname: String?
    var avatar: String?
    
    // MARK: - Init
    
    required init?(map: Map) {
        if map.JSON["mail"] == nil {
            return nil
        }
    }
    
    // MARK: - Mappable
    
    func mapping(map: Map) {
        self.email <- map["mail"]
        self.token <- map["token"]
        self.name <- map["name"]
        self.surname <- map["surname"]
        self.avatar <- map["avatar"]
    }
}
