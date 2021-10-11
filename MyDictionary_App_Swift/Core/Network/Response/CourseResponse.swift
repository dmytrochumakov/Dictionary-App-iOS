//
//  CourseResponse.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 22.08.2021.
//

import Foundation
import CoreData

struct CourseResponse {
    
    let userId: Int64
    let courseId: Int64
    let languageId: Int64
    let languageName: String
    let createdAt: String
    
}

// MARK: - Core Data
extension CourseResponse {
    
    func cdCourseResponseEntity(context: NSManagedObjectContext) -> CDCourseResponseEntity {
        
        let cdCourseResponseEntity: CDCourseResponseEntity = .init(context: context)
        
        cdCourseResponseEntity.userId = self.userId
        cdCourseResponseEntity.courseId = self.courseId
        cdCourseResponseEntity.languageId = self.languageId
        cdCourseResponseEntity.languageName = self.languageName
        cdCourseResponseEntity.createdAt = self.createdAt
        
        return cdCourseResponseEntity
        
    }
    
}

// MARK: - Decodable
extension CourseResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case courseId = "course_id"
        case languageId = "language_id"
        case languageName = "language_name"
        case createdAt = "created_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(Int64.self, forKey: .userId)
        self.courseId = try container.decode(Int64.self, forKey: .courseId)
        self.languageId = try container.decode(Int64.self, forKey: .languageId)
        self.languageName = try container.decode(String.self, forKey: .languageName)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
    }
    
}

// MARK: - MDTextForSearchProtocol
extension CourseResponse: MDTextForSearchProtocol {
    
    var textForSearch: String {
        return languageName
    }
    
}
