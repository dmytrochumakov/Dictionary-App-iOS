//
//  MDLanguageModel.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 07.11.2021.
//

import Foundation

struct MDLanguageModel {
    let id: Int16
    let name: String
    let translatedName: String
}

// MARK: - Decodable
extension MDLanguageModel: Decodable {
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case translatedName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int16.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.translatedName = try container.decode(String.self, forKey: .translatedName)
    }
    
}

// MARK: - MDTextForSearchProtocol
extension MDLanguageModel: MDTextForSearchProtocol {
    
    var textForSearch: String {
        return name
    }
    
}
