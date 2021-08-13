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
    
    var expDate: Date? {
        let format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let dateFormatter: DateFormatter = .init()
        dateFormatter.timeZone = TimeZone.init(identifier: "UTC")!
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: expirationDate)
    }
    
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
