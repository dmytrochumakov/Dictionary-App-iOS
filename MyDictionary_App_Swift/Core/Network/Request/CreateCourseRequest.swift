//
//  CreateCourseRequest.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 24.08.2021.
//

import Foundation

struct CreateCourseRequest {
    
    let userId: Int64
    let languageId: Int64
    let languageName: String
    
}

// MARK: - Encodable
extension CreateCourseRequest: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case languageId = "language_id"
        case languageName = "language_name"
    }
 
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userId, forKey: .userId)
        try container.encode(languageId, forKey: .languageId)
        try container.encode(languageName, forKey: .languageName)
    }
    
}
