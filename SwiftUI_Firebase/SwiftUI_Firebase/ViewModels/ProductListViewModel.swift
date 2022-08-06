//
//  ProductListViewModel.swift
//  SwiftUI_Firebase
//
//  Created by Alexander Augusto Silva Fernandes on 06/08/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class ProductListViewModel: ObservableObject {
    @Published var products = [ProductModel]()
    
    private let db = Firestore.firestore()
    
    func fetchProducts() {
        db.collection(Product.COLLECTION)
            .whereField(Product.USER_ID, isEqualTo: Auth.auth().currentUser!.uid)
            .order(by: Product.NAME)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                self.products = documents.compactMap {
                    queryDocumentSnapshot -> Product? in
                    return try? queryDocumentSnapshot.data(as: Product.self)
                }.map(ProductModel.init)
            }
    }
    
    func deleteProduct(product: Product, completion: @escaping (Bool) -> Void) {
        db.collection(Product.COLLECTION).document(product.id!).delete() { error in
            if let error = error {
                print("Error while removing the product: \(error)")
                completion(false)
            } else {
                print("Product successfully removed!")
                completion(true)
            }
        }
    }
    
    func clearProducts() {
        products = [ProductModel]()
    }
}
