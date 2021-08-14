//
//  CDAuthResponseEntity+CoreDataProperties.swift
//  
//
//  Created by Dmytro Chumakov on 14.08.2021.
//
//

import Foundation
import CoreData


extension CDAuthResponseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAuthResponseEntity> {
        return NSFetchRequest<CDAuthResponseEntity>(entityName: "CDAuthResponseEntity")
    }

    @NSManaged public var accessToken: String?
    @NSManaged public var expirationDate: String?

}
