//
//  Product.swift
//  SwiftUI_Firebase
//
//  Created by Alexander Augusto Silva Fernandes on 06/08/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Product: Codable {
    static let COLLECTION = "products"
    static let USER_ID = "userId"
    static let NAME = "name"
    
    @DocumentID var id: String? = UUID().uuidString
    var userId: String
    var name: String
    var description: String
    var code: String
    var price: Double
    var imageId: String?
}
