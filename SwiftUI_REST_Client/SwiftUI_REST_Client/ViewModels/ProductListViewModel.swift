//
//  ProductListViewModel.swift
//  SwiftUI_REST_Client
//
//  Created by Alexander Augusto Silva Fernandes on 23/07/22.
//

import Foundation

class ProductListViewModel: ObservableObject {
    @Published var products = [ProductModel]()
    
    init() {
        fetchProducts()
    }
    
    func fetchProducts() {
        SalesProviderClient.sharedInstance.getProducts { products in
            if let products = products {
                self.products = products.map(ProductModel.init)
            }
        }
    }
    
    func deleteProduct(product: ProductModel, completion: @escaping (Product?) -> Void) {
        SalesProviderClient.sharedInstance.deleteProduct(productCode: product.code) { product in
            completion(product)
        }
    }
}
