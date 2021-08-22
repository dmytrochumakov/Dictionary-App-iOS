//
//  LanguageEntity.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 22.08.2021.
//

import Foundation
import CoreData

struct LanguageEntity {
    
    let languageId: Int64
    let languageName: String
    let createdAt: String
    
}

// MARK: - Core Data
extension LanguageEntity {
    
    func cdLanguageEntity(insertIntoManagedObjectContext: NSManagedObjectContext) -> CDLanguageEntity {
        return .init(languageEntity: self,
                     insertIntoManagedObjectContext: insertIntoManagedObjectContext)
    }
    
}


// MARK: - Decodable
extension LanguageEntity: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case languageId = "language_id"
        case languageName = "language_name"
        case createdAt = "created_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.languageId = try container.decode(Int64.self, forKey: .languageId)
        self.languageName = try container.decode(String.self, forKey: .languageName)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
    }
    
}
