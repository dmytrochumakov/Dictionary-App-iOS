//
//  UpdateWordRequest.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 26.08.2021.
//

import Foundation

struct UpdateWordRequest {
    
    let userId: Int64
    let wordId: Int64
    let courseId: Int64
    let languageId: Int64
    let wordText: String
    let wordDescription: String
    let languageName: String
    
}

// MARK: - Encodable
extension UpdateWordRequest: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case wordId = "word_id"
        case courseId = "course_id"
        case languageId = "language_id"
        case wordText = "word_text"
        case wordDescription = "word_description"
        case languageName = "language_name"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userId, forKey: .userId)
        try container.encode(wordId, forKey: .wordId)
        try container.encode(courseId, forKey: .courseId)
        try container.encode(languageId, forKey: .languageId)
        try container.encode(wordText, forKey: .wordText)
        try container.encode(wordDescription, forKey: .wordDescription)
        try container.encode(languageName, forKey: .languageName)
    }
    
}
