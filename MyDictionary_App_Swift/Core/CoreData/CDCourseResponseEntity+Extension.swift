//
//  CDCourseResponseEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 22.08.2021.
//

import Foundation

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
