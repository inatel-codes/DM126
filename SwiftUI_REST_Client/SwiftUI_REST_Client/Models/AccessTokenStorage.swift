//
//  AccessTokenStorage.swift
//  SwiftUI_REST_Client
//
//  Created by Alexander Augusto Silva Fernandes on 23/07/22.
//

import Foundation

class AccessTokenStorage {
    var accessToken: String
    var expiresDate: NSDate
    
    init(accessToken: String, expiresIn: Int) {
        self.accessToken = accessToken
        self.expiresDate = NSDate().addingTimeInterval(TimeInterval(expiresIn))
    }
    
    func isValidToken() -> Bool {
        if NSDate().timeIntervalSinceReferenceDate < self.expiresDate.timeIntervalSinceReferenceDate {
            return true
        } else {
            return false
        }
    }
}
