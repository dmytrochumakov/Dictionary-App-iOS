//
//  CDJWTResponseEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 14.08.2021.
//

import CoreData

extension CDJWTResponseEntity {
    
    convenience init(jwtResponse: JWTResponse,
                     insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        
        let entity = NSEntityDescription.entity(forEntityName: CoreDataEntityName.CDJWTResponseEntity, in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.accessToken = jwtResponse.accessToken
        self.expirationDate = jwtResponse.expirationDate
        
    }
    
}

extension CDJWTResponseEntity {
    
    var jwtResponse: JWTResponse {
        guard let accessToken = self.accessToken,
              let expirationDate = self.expirationDate
        else {
            fatalError()
        }
        return .init(accessToken: accessToken,
                     expirationDate: expirationDate)
    }
    
}
