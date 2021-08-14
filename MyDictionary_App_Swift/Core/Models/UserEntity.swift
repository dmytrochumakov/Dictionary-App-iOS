//
//  UserEntity.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 14.08.2021.
//

import Foundation

struct UserEntity {
    
    let userId: Int64
    let nickname: String
    let password: String
    // Date Format: - "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    let createdAt: String
    // Date Format: - "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    let updatedAt: String
    
    var createdAtDate: Date? {
        let format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let dateFormatter: DateFormatter = .init()
        dateFormatter.timeZone = TimeZone.init(identifier: "UTC")!
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: createdAt)
    }
    
    var updatedAtDate: Date? {
        let format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let dateFormatter: DateFormatter = .init()
        dateFormatter.timeZone = TimeZone.init(identifier: "UTC")!
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: updatedAt)
    }
   
}

extension UserEntity: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case nickname = "nickname"
        case password = "password"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(Int64.self, forKey: .userId)
        self.nickname = try container.decode(String.self, forKey: .nickname)
        self.password = try container.decode(String.self, forKey: .password)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
    }
    
}
