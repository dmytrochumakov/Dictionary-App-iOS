//
//  WordModel.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation
import CoreData

struct WordModel: MDIDPropertyProtocol,
                  MDUserIDPropertyProtocol,
                  MDWordPropertyProtocol,
                  MDWordDescriptionPropertyProtocol,
                  MDWordLanguagePropertyProtocol,
                  MDCreatedAtProtocol,
                  MDUpdatedAtProtocol {
    
    let user_id: Int64
    let id: Int64
    var word: String
    var word_description: String
    let word_language: String
    let created_at: String
    let updated_at: String
    
}

extension WordModel {
    
    func cdWordEntity(insertIntoManagedObjectContext: NSManagedObjectContext) -> CDWordEntity {
        return .init(wordModel: self,
                     insertIntoManagedObjectContext: insertIntoManagedObjectContext)
    }
    
}

extension WordModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case user_id = "user_id"
        case id = "id"
        case word = "word"
        case word_description = "word_description"
        case word_language = "word_language"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user_id = try container.decode(Int64.self, forKey: .user_id)
        self.id = try container.decode(Int64.self, forKey: .id)
        self.word = try container.decode(String.self, forKey: .word)
        self.word_description = try container.decode(String.self, forKey: .word_description)
        self.word_language = try container.decode(String.self, forKey: .word_language)
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.updated_at = try container.decode(String.self, forKey: .updated_at)
    }
    
}
