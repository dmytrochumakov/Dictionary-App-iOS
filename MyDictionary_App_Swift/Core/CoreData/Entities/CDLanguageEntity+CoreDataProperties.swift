//
//  CDLanguageEntity+CoreDataProperties.swift
//  
//
//  Created by Dmytro Chumakov on 22.08.2021.
//
//

import Foundation
import CoreData


extension CDLanguageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDLanguageEntity> {
        return NSFetchRequest<CDLanguageEntity>(entityName: "CDLanguageEntity")
    }

    @NSManaged public var languageId: Int64
    @NSManaged public var languageName: String?
    @NSManaged public var createdAt: String?

}
