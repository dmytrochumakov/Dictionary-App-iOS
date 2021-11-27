//
//  CDCourseEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 27.11.2021.
//

import Foundation

// MARK: - Encodable
extension CDCourseEntity: Encodable {
    
    enum CodingKeys: CodingKey {
        case uuid
        case languageId
        case createdAt
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(uuid!, forKey: .uuid)
        try container.encode(languageId, forKey: .languageId)
        try container.encode(createdAt, forKey: .createdAt)
        
    }
    
}
