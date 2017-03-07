//
//  ProductList.swift
//  Kaver
//
//  Created by Marcel Mierzejewski on 07.03.2017.
//  Copyright © 2017 Marcel Mierzejewski. All rights reserved.
//

import ObjectMapper

class ProductList: Mappable {
    
    var list: [ProductModel]?
    
    // MARK: - Init
    
    required init?(map: Map) {
        if map.JSON["list"] == nil {
            return nil
        }
    }
    
    // MARK: - Mappable
    
    func mapping(map: Map) {
        self.list <- map["list"]
    }
}
