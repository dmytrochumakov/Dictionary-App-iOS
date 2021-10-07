//
//  WordResponse.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation
import CoreData

struct WordResponse {
    
    let userId: Int64
    let wordId: Int64
    let courseId: Int64
    let languageId: Int64
    var wordText: String
    var wordDescription: String
    let languageName: String
    let createdAt: String
    
}

// MARK: - Core Data
extension WordResponse {
    
    func cdWordEntity(insertIntoManagedObjectContext: NSManagedObjectContext) -> CDWordResponseEntity {
        return .init(wordResponse: self,
                     insertIntoManagedObjectContext: insertIntoManagedObjectContext)
    }
    
}

// MARK: - Decodable
extension WordResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case wordId = "word_id"
        case courseId = "course_id"
        case languageId = "language_id"
        case wordText = "word_text"
        case wordDescription = "word_description"
        case languageName = "language_name"
        case createdAt = "created_at"
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
    }
    
}

// MARK: - Equatable
extension WordResponse: Equatable {
    
    static func == (lhs: WordResponse, rhs: WordResponse) -> Bool {
        return lhs.userId == rhs.userId && lhs.wordId == rhs.wordId && lhs.courseId == rhs.courseId && lhs.languageId == rhs.languageId
    }
    
}

// MARK: - MDTextForSearchProtocol
extension WordResponse: MDTextForSearchProtocol {
    
    var textForSearch: String {
        return wordText
    }
    
}
