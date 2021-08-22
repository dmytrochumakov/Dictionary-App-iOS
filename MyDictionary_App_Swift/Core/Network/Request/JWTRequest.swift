//
//  JWTRequest.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 22.08.2021.
//

import Foundation

struct JWTRequest {
    let nickname: String
    let password: String
}

extension JWTRequest: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case nickname
        case password
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(nickname, forKey: .nickname)
        try container.encode(password, forKey: .password)
    }
    
}
