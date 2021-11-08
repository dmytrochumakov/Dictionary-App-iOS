//
//  CDWordEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 07.11.2021.
//

import CoreData

extension CDWordEntity {
    
    static func cdWordEntity(context: NSManagedObjectContext,
                             courseUUID: UUID,
                             uuid: UUID,
                             wordText: String,
                             wordDescription: String,
                             createdAt: Date,
                             updatedAt: Date) -> CDWordEntity {
        
        let cdWordEntity: CDWordEntity = .init(context: context)
        
        cdWordEntity.courseUUID = courseUUID
        cdWordEntity.uuid = uuid
        cdWordEntity.wordText = wordText
        cdWordEntity.wordDescription = wordDescription
        cdWordEntity.createdAt = createdAt
        cdWordEntity.updatedAt = updatedAt
        
        return cdWordEntity
        
    }
    
}
