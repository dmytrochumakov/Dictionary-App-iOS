//
//  CDCourseEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 22.08.2021.
//

import CoreData

extension CDCourseEntity {
    
    convenience init(courseEntity: CourseEntity,
                     insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        
        let entity = NSEntityDescription.entity(forEntityName: CoreDataEntityName.CDCourseEntity, in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.userId = courseEntity.userId
        self.courseId = courseEntity.courseId
        self.languageId = courseEntity.languageId
        self.languageName = courseEntity.languageName
        self.createdAt = courseEntity.createdAt
        self.updatedAt = courseEntity.updatedAt
        
    }
    
}

extension CDCourseEntity {
    
    var courseEntity: CourseEntity {
        guard let languageName = self.languageName,
              let createdAt = self.createdAt,
              let updatedAt = self.updatedAt
        else {
            fatalError()
        }
        return .init(userId: self.userId,
                     courseId: self.courseId,
                     languageId: self.languageId,
                     languageName: languageName,
                     createdAt: createdAt,
                     updatedAt: updatedAt)
    }
    
}
