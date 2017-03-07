//
//  ProductModel.swift
//  Eracoin App
//
//  Created by Maciej Matuszewski on 20.02.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import ObjectMapper

class ProductModel: Mappable {
    
    var productId: Int?
    var name: String?
    var surname: String?
    var photo: String?
    
    // MARK: - Init
    
    required init?(map: Map) {
        if map.JSON["id"] == nil {
            return nil
        }
    }
    
    // MARK: - Mappable
    
    func mapping(map: Map) {
        self.productId <- map["id"]
        self.name <- map["name"]
        self.surname <- map["surname"]
        self.photo <- map["avatar"]
    }
}
