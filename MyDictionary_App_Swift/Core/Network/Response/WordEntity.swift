//
//  WordEntity.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation
import CoreData

struct WordEntity {
    
    let userId: Int64
    let wordId: Int64
    let courseId: Int64
    let languageId: Int64
    var wordText: String
    var wordDescription: String
    let languageName: String
    let createdAt: String
    let updatedAt: String
    
}

// MARK: - Core Data
extension WordEntity {
    
    func cdWordEntity(insertIntoManagedObjectContext: NSManagedObjectContext) -> CDWordEntity {
        return .init(wordEntity: self,
                     insertIntoManagedObjectContext: insertIntoManagedObjectContext)
    }
    
}

// MARK: - Decodable
extension WordEntity: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case wordId = "word_id"
        case courseId = "course_id"
        case languageId = "language_id"
        case wordText = "word_text"
        case wordDescription = "word_description"
        case languageName = "language_name"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(Int64.self, forKey: .userId)
        self.wordId = try container.decode(Int64.self, forKey: .wordId)
        self.courseId = try container.decode(Int64.self, forKey: .courseId)
        self.languageId = try container.decode(Int64.self, forKey: .languageId)
        self.wordText = try container.decode(String.self, forKey: .wordText)
        self.wordDescription = try container.decode(String.self, forKey: .wordDescription)
        self.languageName = try container.decode(String.self, forKey: .languageName)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
    }
    
}
