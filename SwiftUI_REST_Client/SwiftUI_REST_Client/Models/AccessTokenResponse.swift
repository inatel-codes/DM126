//
//  AccessTokenResponse.swift
//  SwiftUI_REST_Client
//
//  Created by Paulo Siecola on 23/07/22.
//

import Foundation

struct AccessTokenResponse: Decodable {
    let access_token: String
    let refresh_token: String
    let expires_in: Int
}


