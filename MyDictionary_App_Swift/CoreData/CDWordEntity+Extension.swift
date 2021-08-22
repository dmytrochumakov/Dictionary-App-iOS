//
//  CDWordEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation
import CoreData

extension CDWordEntity {
    
    convenience init(wordEntity: WordEntity,
                     insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        
        let entity = NSEntityDescription.entity(forEntityName: CoreDataEntityName.CDWordEntity, in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.userId = wordEntity.userId
        self.wordId = wordEntity.wordId
        self.courseId = wordEntity.courseId
        self.languageId = wordEntity.languageId
        self.wordText = wordEntity.wordText
        self.wordDescription = wordEntity.wordDescription
        self.languageName = wordEntity.languageName
        self.createdAt = wordEntity.createdAt
        self.updatedAt = wordEntity.updatedAt
        
    }
    
}

extension CDWordEntity {
    
    var wordEntity: WordEntity {
        guard let wordText = self.wordText,
              let wordDescription = self.wordDescription,
              let languageName = self.languageName,
              let createdAt = self.createdAt,
              let updatedAt = self.updatedAt
        else {
            fatalError()
        }
        return .init(userId: self.userId,
                     wordId: self.wordId,
                     courseId: self.courseId,
                     languageId: self.languageId,
                     wordText: wordText,
                     wordDescription: wordDescription,
                     languageName: languageName,
                     createdAt: createdAt,
                     updatedAt: updatedAt)
    }
    
}
