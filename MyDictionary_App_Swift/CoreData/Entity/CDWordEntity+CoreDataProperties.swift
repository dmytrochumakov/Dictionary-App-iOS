//
//  CDWordEntity+CoreDataProperties.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 06.07.2021.
//
//

import Foundation
import CoreData


extension CDWordEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDWordEntity> {
        return NSFetchRequest<CDWordEntity>(entityName: "CDWordEntity")
    }

    @NSManaged public var uuid: UUID
    @NSManaged public var word: String
    @NSManaged public var wordDescription: String
    @NSManaged public var wordLanguage: String
    @NSManaged public var createdDate: Date
    @NSManaged public var updatedDate: Date

}
