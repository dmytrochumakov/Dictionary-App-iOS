//
//  CDCourseEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 07.11.2021.
//

import CoreData

extension CDCourseEntity {
    
    static func cdCourseEntity(context: NSManagedObjectContext,
                               uuid: UUID,
                               languageId: Int16,
                               createdAt: Date) -> CDCourseEntity {
        
        let cdCourseEntity: CDCourseEntity = .init(context: context)
        
        cdCourseEntity.uuid = uuid
        cdCourseEntity.languageId = languageId
        cdCourseEntity.createdAt = createdAt        
        
        return cdCourseEntity
        
    }
    
}
