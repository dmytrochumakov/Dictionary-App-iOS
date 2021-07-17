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
        
        self.user_id = wordModel.user_id
        self.id = wordModel.id
        self.word = wordModel.word
        self.word_description = wordModel.word_description
        self.word_language = wordModel.word_language
        self.created_at = wordModel.created_at
        self.updated_at = wordModel.updated_at
        
    }
    
}

extension CDWordEntity {
    
    var wordModel: WordModel {
        guard let word = self.word,
              let word_description = self.word_description,
              let word_language = self.word_language,
              let created_at = self.created_at,
              let updated_at = self.updated_at
        else {
            fatalError()
        }
        return .init(user_id: self.user_id,
                     id: self.id,
                     word: word,
                     word_description: word_description,
                     word_language: word_language,
                     created_at: created_at,
                     updated_at: updated_at)
    }
    
}
