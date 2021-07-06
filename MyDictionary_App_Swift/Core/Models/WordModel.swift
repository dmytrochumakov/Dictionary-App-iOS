//
//  WordModel.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

struct WordModel: MDUUIDPropertyProtocol,
                  MDWordPropertyProtocol,
                  MDWordDescriptionPropertyProtocol,
                  MDWordLanguagePropertyProtocol,
                  MDCreatedDateProtocol,
                  MDUpdatedDateProtocol {
    
    let uuid: UUID
    let word: String
    let wordDescription: String
    let wordLanguage: String
    let createdDate: Date
    let updatedDate: Date
        
}
