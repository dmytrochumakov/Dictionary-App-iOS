//
//  AuthResponse.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.08.2021.
//

import Foundation

struct AuthResponse {
    
    let userResponse: UserResponse
    let jwtResponse: JWTResponse
    
}

extension AuthResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case userResponse = "user_response"
        case jwtResponse = "jwt"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userResponse = try container.decode(UserResponse.self, forKey: .userResponse)
        self.jwtResponse = try container.decode(JWTResponse.self, forKey: .jwtResponse)
    }
    
}
