//
//  UserResponse.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 14.08.2021.
//

import Foundation
import CoreData

struct UserResponse {
    
    let userId: Int64
    let nickname: String
    var password: String?
    // Date Format: - "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    let createdAt: String
    
    var createdAtDate: Date? {
        let format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let dateFormatter: DateFormatter = .init()
        dateFormatter.timeZone = TimeZone.init(identifier: "UTC")!
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: createdAt)
    }
    
}

extension UserResponse {
    
    func cdUserResponseEntity(password: String,
                              context: NSManagedObjectContext) -> CDUserResponseEntity {
        
        let cdUserResponseEntity: CDUserResponseEntity = .init(context: context)
        
        cdUserResponseEntity.userId = self.userId
        cdUserResponseEntity.nickname = self.nickname
        cdUserResponseEntity.password = password
        cdUserResponseEntity.createdAt = self.createdAt
        
        return cdUserResponseEntity
        
    }
    
}

extension UserResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case nickname = "nickname"
        case createdAt = "created_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(Int64.self, forKey: .userId)
        self.nickname = try container.decode(String.self, forKey: .nickname)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
    }
    
}
