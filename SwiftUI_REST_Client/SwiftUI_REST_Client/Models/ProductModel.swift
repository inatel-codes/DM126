//
//  ProductModel.swift
//  SwiftUI_REST_Client
//
//  Created by Alexander Augusto Silva Fernandes on 23/07/22.
//

import Foundation

class ProductModel {
    var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var id: UInt {
        return self.product.id
    }
    
    var name: String {
        return self.product.name
    }
    
    var description: String {
        return self.product.description
    }
    
    var code: String {
        return self.product.code
    }
    
    var price: Double {
        return self.product.price
    }
}
