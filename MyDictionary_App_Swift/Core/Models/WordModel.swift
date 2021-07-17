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
                  MDCreatedDateProtocol,
                  MDUpdatedDateProtocol {
    
    let user_ID: Int64
    let id: Int64
    var word: String
    var wordDescription: String
    let wordLanguage: String
    let createdDate: Date
    let updatedDate: Date
    
}

extension WordModel {
    
    func cdWordEntity(insertIntoManagedObjectContext: NSManagedObjectContext) -> CDWordEntity {
        return .init(wordModel: self,
                     insertIntoManagedObjectContext: insertIntoManagedObjectContext)
    }
    
}
