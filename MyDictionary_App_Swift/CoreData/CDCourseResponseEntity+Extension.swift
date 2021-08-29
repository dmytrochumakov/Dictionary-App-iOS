//
//  CDCourseResponseEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 22.08.2021.
//

import CoreData

extension CDCourseResponseEntity {
    
    convenience init(courseResponse: CourseResponse,
                     insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        
        let entity = NSEntityDescription.entity(forEntityName: CoreDataEntityName.CDCourseResponseEntity, in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.userId = courseResponse.userId
        self.courseId = courseResponse.courseId
        self.languageId = courseResponse.languageId
        self.languageName = courseResponse.languageName
        self.createdAt = courseResponse.createdAt
        
    }
    
}

extension CDCourseResponseEntity {
    
    var courseResponse: CourseResponse {
        guard let languageName = self.languageName,
              let createdAt = self.createdAt
        else {
            fatalError()
        }
        return .init(userId: self.userId,
                     courseId: self.courseId,
                     languageId: self.languageId,
                     languageName: languageName,
                     createdAt: createdAt)
    }
    
}
