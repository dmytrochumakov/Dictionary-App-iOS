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
                               name: String,
                               translatedName: String,
                               createdAt: Date,
                               words: NSSet?) -> CDCourseEntity {
        
        let cdCourseEntity: CDCourseEntity = .init(context: context)
        
        cdCourseEntity.uuid = uuid
        cdCourseEntity.name = name
        cdCourseEntity.translatedName = translatedName
        cdCourseEntity.createdAt = createdAt
        cdCourseEntity.words = words
        
        return cdCourseEntity
        
    }
    
}

// MARK: - MDTextForSearchProtocol
extension CDCourseEntity: MDTextForSearchProtocol {
    
    var textForSearch: String {
        return name!
    }
    
}
