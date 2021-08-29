//
//  CDWordResponseEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation
import CoreData

extension CDWordResponseEntity {
    
    convenience init(wordResponse: WordResponse,
                     insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        
        let entity = NSEntityDescription.entity(forEntityName: CoreDataEntityName.CDWordResponseEntity, in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.userId = wordResponse.userId
        self.wordId = wordResponse.wordId
        self.courseId = wordResponse.courseId
        self.languageId = wordResponse.languageId
        self.wordText = wordResponse.wordText
        self.wordDescription = wordResponse.wordDescription
        self.languageName = wordResponse.languageName
        self.createdAt = wordResponse.createdAt
        
    }
    
}

extension CDWordResponseEntity {
    
    var wordResponse: WordResponse {
        guard let wordText = self.wordText,
              let wordDescription = self.wordDescription,
              let languageName = self.languageName,
              let createdAt = self.createdAt
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
                     createdAt: createdAt)
    }
    
}
