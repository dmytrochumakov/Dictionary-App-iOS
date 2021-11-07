//
//  CDCourseEntity+CoreDataProperties.swift
//  
//
//  Created by Dmytro Chumakov on 07.11.2021.
//
//

import Foundation
import CoreData


extension CDCourseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCourseEntity> {
        return NSFetchRequest<CDCourseEntity>(entityName: "CDCourseEntity")
    }

    @NSManaged public var uuid: UUID?
    @NSManaged public var createdAt: Date?
    @NSManaged public var name: String?
    @NSManaged public var translatedName: String?
    @NSManaged public var words: NSSet?

}

// MARK: Generated accessors for words
extension CDCourseEntity {

    @objc(addWordsObject:)
    @NSManaged public func addToWords(_ value: CDWordEntity)

    @objc(removeWordsObject:)
    @NSManaged public func removeFromWords(_ value: CDWordEntity)

    @objc(addWords:)
    @NSManaged public func addToWords(_ values: NSSet)

    @objc(removeWords:)
    @NSManaged public func removeFromWords(_ values: NSSet)

}
