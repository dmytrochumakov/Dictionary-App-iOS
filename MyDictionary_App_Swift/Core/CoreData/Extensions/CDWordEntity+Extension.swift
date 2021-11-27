//
//  CDWordEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 07.11.2021.
//

import Foundation

// MARK: - MDTextForSearchWithTwoPropertiesProtocol
extension CDWordEntity: MDTextForSearchWithTwoPropertiesProtocol {
    
    var textForSearch0: String {
        return wordText!
    }
    
    var textForSearch1: String {
        return wordDescription!
    }
    
}

// MARK: - Encodable
extension CDWordEntity: Encodable {
    
    enum CodingKeys: CodingKey {
        case uuid
        case wordText
        case wordDescription
        case createdAt
        case courseUUID
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(uuid!, forKey: .uuid)
        try container.encode(wordText!, forKey: .wordText)
        try container.encode(wordDescription!, forKey: .wordDescription)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(courseUUID!, forKey: .courseUUID)
        
    }
    
}
