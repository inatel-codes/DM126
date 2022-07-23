//
//  SalesProviderClient.swift
//  SwiftUI_REST_Client
//
//  Created by Alexander Augusto Silva Fernandes on 23/07/22.
//

import Foundation
import Alamofire

class SalesProviderClient {
    static let sharedInstance = SalesProviderClient()
    private let baseUrl = "https://sales-provider.appspot.com"
    
    private var accessTokenStorage: AccessTokenStorage?
    private let session: Session
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        
        let userCredential = UserCredential(username: "alex@mail.com", password: "123")
        
        session = Session(configuration: configuration,
                          interceptor: AuthenticationInterceptor(
                            accessTokenStorage: accessTokenStorage,
                            userCredential: userCredential,
                            baseUrl: baseUrl))
    }
    
    func createProduct(product: Product, completion: @escaping (Product?) -> Void) {
        session.request(baseUrl + "/api/products", method: .post, parameters: product, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: Product.self) { response in
                switch response.result {
                case .success:
                    DispatchQueue.main.async {
                        completion(response.value)
                    }
                case let .failure(error):
                    print(error)
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
    }
    
    func getProducts(completion: @escaping ([Product]?) -> Void) {
        session.request(baseUrl + "/api/products")
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: [Product].self) { response in
                switch response.result {
                case .success:
                    DispatchQueue.main.async {
                        return completion(response.value)
                    }
                case let .failure(error):
                    print(error)
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
    }
    
    func updateProduct(productCode: String, product: Product, completion: @escaping (Product?) -> Void) {
        session.request(baseUrl + "/api/products/\(productCode.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)", method: .put, parameters: product, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: Product.self) { response in
                switch response.result {
                case .success:
                    DispatchQueue.main.async {
                        completion(response.value)
                    }
                case let .failure(error):
                    print(error)
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
    }
    
    func deleteProduct(productCode: String, completion: @escaping (Product?) -> Void) {
        session.request(baseUrl + "/api/products/\(productCode.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)", method: .delete)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: Product.self) { response in
                switch response.result {
                case .success:
                    DispatchQueue.main.async {
                        completion(response.value)
                    }
                case let .failure(error):
                    print(error)
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
    }
}
