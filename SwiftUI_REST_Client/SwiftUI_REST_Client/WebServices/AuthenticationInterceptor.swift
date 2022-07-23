//
//  AuthenticationInterceptor.swift
//  SwiftUI_REST_Client
//
//  Created by Alexander Augusto Silva Fernandes on 23/07/22.
//

import Foundation
import Alamofire

final class AuthenticationInterceptor: Alamofire.RequestInterceptor {
    private var accessTokenStorage: AccessTokenStorage?
    private let userCredential: UserCredential
    private let baseUrl: String
    
    private let TOKEN_ENDPOINT = "/oauth/token"
    private let AUTH_TOKEN = "Basic c2llY29sYTptYXRpbGRl"
    
    init(accessTokenStorage: AccessTokenStorage?, userCredential: UserCredential, baseUrl: String) {
        self.accessTokenStorage = accessTokenStorage
        self.userCredential = userCredential
        self.baseUrl = baseUrl
    }
    
    private func isValidToken() -> Bool {
        if let accessToken = self.accessTokenStorage {
            return accessToken.isValidToken()
        } else {
            return false
        }
    }
    
    private func getAccessToken(completion: @escaping (RetryResult) -> Void) {
        let tokenEndpoint = baseUrl + "/oauth/token"
        
        let params: Parameters = ["grant_type": "password",
                                  "username": userCredential.username,
                                  "password": userCredential.password]
        
        let tokenHeaders: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded",
                                         "Authorization": AUTH_TOKEN]
        
        AF.request(tokenEndpoint, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: tokenHeaders)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: AccessTokenResponse.self) { response in
                switch response.result {
                case .success:
                    if let acccessTokenResponse = response.value {
                        print("The token is: \(acccessTokenResponse.access_token)")
                        print("It expires in: \(acccessTokenResponse.expires_in)")
                        
                        self.accessTokenStorage = AccessTokenStorage(
                            accessToken: acccessTokenResponse.access_token,
                            expiresIn: acccessTokenResponse.expires_in)
                        
                        return completion(.retry)
                    }
                case let .failure(error):
                    print(error)
                }
            }
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        
        if isValidToken() {
            urlRequest.setValue("Bearer" + accessTokenStorage!.accessToken, forHTTPHeaderField: "Authorization")
        }
        
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            return completion(.doNotRetryWithError(error))
        }
        
        getAccessToken(completion: completion)
    }
}
