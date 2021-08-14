//
//  CDAuthResponseEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 14.08.2021.
//

import CoreData

extension CDAuthResponseEntity {
    
    convenience init(authResponse: AuthResponse,
                     insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        
        let entity = NSEntityDescription.entity(forEntityName: CoreDataEntityName.CDAuthResponseEntity, in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.accessToken = authResponse.accessToken
        self.expirationDate = authResponse.expirationDate
        
    }
    
}

extension CDAuthResponseEntity {
    
    var authResponse: AuthResponse {
        guard let accessToken = self.accessToken,
              let expirationDate = self.expirationDate
        else {
            fatalError()
        }
        return .init(accessToken: accessToken,
                     expirationDate: expirationDate)
    }
    
}
