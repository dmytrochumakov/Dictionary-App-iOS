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
