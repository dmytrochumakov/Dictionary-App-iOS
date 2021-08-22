//
//  CDCourseEntity+CoreDataProperties.swift
//  
//
//  Created by Dmytro Chumakov on 22.08.2021.
//
//

import Foundation
import CoreData


extension CDCourseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCourseEntity> {
        return NSFetchRequest<CDCourseEntity>(entityName: "CDCourseEntity")
    }

    @NSManaged public var userId: Int64
    @NSManaged public var courseId: Int64
    @NSManaged public var languageId: Int64
    @NSManaged public var languageName: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var updatedAt: String?

}
