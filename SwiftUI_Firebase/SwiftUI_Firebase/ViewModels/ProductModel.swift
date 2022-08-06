//
//  ProductModel.swift
//  SwiftUI_Firebase
//
//  Created by Alexander Augusto Silva Fernandes on 06/08/22.
//

import Foundation
import SwiftUI

class ProductModel {
    var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var id: String? {
        return self.product.id
    }

    var name: String {
        return self.product.name
    }

    var code: String {
        return self.product.code
    }

    var price: Double {
        return self.product.price
    }
}

