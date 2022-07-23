//
//  Product.swift
//  SwiftUI_REST_Client
//
//  Created by Alexander Augusto Silva Fernandes on 23/07/22.
//

import Foundation

struct Product: Codable {
    let id: UInt
    let name: String
    let description: String
    let code: String
    let price: Double
}
