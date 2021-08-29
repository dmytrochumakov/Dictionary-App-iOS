//
//  AuthResponse.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.08.2021.
//

import Foundation

struct AuthResponse {
    
    let userEntity: UserResponse
    let jwtResponse: JWTResponse
    
}

extension AuthResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case userEntity = "user_entity"
        case jwtResponse = "jwt"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userEntity = try container.decode(UserResponse.self, forKey: .userEntity)
        self.jwtResponse = try container.decode(JWTResponse.self, forKey: .jwtResponse)
    }
    
}
