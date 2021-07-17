//
//  CDWordEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation
import CoreData

extension CDWordEntity {
    
    convenience init(wordModel: WordModel,
                     insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        
        let entity = NSEntityDescription.entity(forEntityName: CoreDataEntityName.CDWordEntity, in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.user_id = wordModel.user_ID
        self.id = wordModel.id
        self.word = wordModel.word
        self.wordDescription = wordModel.wordDescription
        self.wordLanguage = wordModel.wordLanguage
        self.createdDate = wordModel.createdDate
        self.updatedDate = wordModel.updatedDate
        
    }
    
}

extension CDWordEntity {
    
    var wordModel: WordModel {
        guard let word = self.word,
              let wordDescription = self.wordDescription,
              let wordLanguage = self.wordLanguage,
              let createdDate = self.createdDate,
              let updatedDate = self.updatedDate
        else {
            fatalError()
        }
        return .init(user_ID: self.user_id,
                     id: self.id,
                     word: word,
                     wordDescription: wordDescription,
                     wordLanguage: wordLanguage,
                     createdDate: createdDate,
                     updatedDate: updatedDate)
    }
    
}
