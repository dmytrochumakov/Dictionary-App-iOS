//
//  LanguageResponse.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 22.08.2021.
//

import Foundation
import CoreData

struct LanguageResponse {
    
    let languageId: Int64
    let languageName: String
    
}

// MARK: - Core Data
extension LanguageResponse {
    
    func cdLanguageResponseEntity(context: NSManagedObjectContext) -> CDLanguageResponseEntity {
        
        let cdLanguageResponseEntity: CDLanguageResponseEntity = .init(context: context)
        
        cdLanguageResponseEntity.languageId = self.languageId
        cdLanguageResponseEntity.languageName = self.languageName
        
        return cdLanguageResponseEntity
        
    }
    
}


// MARK: - Decodable
extension LanguageResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case languageId = "language_id"
        case languageName = "language_name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.languageId = try container.decode(Int64.self, forKey: .languageId)
        self.languageName = try container.decode(String.self, forKey: .languageName)
    }
    
}

// MARK: - Equatable
extension LanguageResponse: Equatable {
    
    static func == (lhs: LanguageResponse, rhs: LanguageResponse) -> Bool {
        return lhs.languageId == rhs.languageId && lhs.languageName == rhs.languageName
    }
    
}

// MARK: - MDTextForSearchProtocol
extension LanguageResponse: MDTextForSearchProtocol {
    
    var textForSearch: String {
        return languageName
    }
    
}
