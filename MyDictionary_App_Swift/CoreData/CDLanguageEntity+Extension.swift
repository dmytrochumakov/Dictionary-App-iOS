//
//  CDLanguageEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 22.08.2021.
//

import CoreData

extension CDLanguageEntity {
    
    convenience init(languageEntity: LanguageEntity,
                     insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        
        let entity = NSEntityDescription.entity(forEntityName: CoreDataEntityName.CDLanguageEntity, in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.languageId = languageEntity.languageId
        self.languageName = languageEntity.languageName
        self.createdAt = languageEntity.createdAt
        
    }
    
}

extension CDLanguageEntity {
    
    var languageEntity: LanguageEntity {
        guard let languageName = self.languageName,
              let createdAt = self.createdAt
        else {
            fatalError()
        }
        return .init(languageId: self.languageId,
                     languageName: languageName,
                     createdAt: createdAt)
    }
    
}
