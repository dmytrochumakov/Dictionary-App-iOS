//
//  CDLanguageResponseEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 22.08.2021.
//

import CoreData

extension CDLanguageResponseEntity {
    
    convenience init(languageResponse: LanguageResponse,
                     insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        
        let entity = NSEntityDescription.entity(forEntityName: CoreDataEntityName.CDLanguageResponseEntity, in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.languageId = languageResponse.languageId
        self.languageName = languageResponse.languageName
        
    }
    
}

extension CDLanguageResponseEntity {
    
    var languageResponse: LanguageResponse {
        guard let languageName = self.languageName              
        else {
            fatalError()
        }
        return .init(languageId: self.languageId,
                     languageName: languageName)
    }
    
}
