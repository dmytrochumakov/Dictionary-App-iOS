//
//  JWTApiRequest.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 25.08.2021.
//

import Foundation

struct JWTApiRequest {
    
    let nickname: String
    let password: String
    let userId: Int64
    
}

// MARK: - Encodable
extension JWTApiRequest: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case nickname = "nickname"
        case password = "password"
        case userId = "user_id"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(nickname, forKey: .nickname)
        try container.encode(password, forKey: .password)
        try container.encode(userId, forKey: .userId)        
    }
    
}
