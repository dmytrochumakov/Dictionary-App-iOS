//
//  CDUserEntity+CoreDataProperties.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 17.07.2021.
//
//

import Foundation
import CoreData


extension CDUserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUserEntity> {
        return NSFetchRequest<CDUserEntity>(entityName: "CDUserEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var user_name: String?

}
