//
//  UserModel.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 17.07.2021.
//

import Foundation
import CoreData

struct UserModel {
    let id: Int64
    let username: String
}

extension UserModel {
    
    func cdUserEntity(insertIntoManagedObjectContext: NSManagedObjectContext) -> CDUserEntity {
        return .init(userModel: self,
                     insertIntoManagedObjectContext: insertIntoManagedObjectContext)
    }
    
}

extension UserModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case username = "username"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int64.self, forKey: .id)
        self.username = try container.decode(String.self, forKey: .username)
    }
    
}
