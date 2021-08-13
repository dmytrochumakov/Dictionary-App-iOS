//
//  AuthResponse.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.08.2021.
//

import Foundation

struct AuthResponse {
    let accessToken: String
    /// Time Zone - UTC
    let expirationDate: String
}

extension AuthResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expirationDate = "expiration_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
        self.expirationDate = try container.decode(String.self, forKey: .expirationDate)
    }
    
}
