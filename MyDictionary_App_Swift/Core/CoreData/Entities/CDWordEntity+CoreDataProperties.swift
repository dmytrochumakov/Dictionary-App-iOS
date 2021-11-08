//
//  CDWordEntity+CoreDataProperties.swift
//  
//
//  Created by Dmytro Chumakov on 07.11.2021.
//
//

import Foundation
import CoreData


extension CDWordEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDWordEntity> {
        return NSFetchRequest<CDWordEntity>(entityName: "CDWordEntity")
    }

    @NSManaged public var uuid: UUID?
    @NSManaged public var createdAt: Date?
    @NSManaged public var wordDescription: String?
    @NSManaged public var wordText: String?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var courseUUID: CDCourseEntity?

}
