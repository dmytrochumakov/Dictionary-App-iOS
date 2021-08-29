//
//  CDUserResponseEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 17.07.2021.
//

import CoreData

extension CDUserResponseEntity {
    
    convenience init(userResponse: UserResponse,
                     password: String,
                     insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        
        let entity = NSEntityDescription.entity(forEntityName: CoreDataEntityName.CDUserResponseEntity, in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.userId = userResponse.userId
        self.nickname = userResponse.nickname
        self.password = password
        self.createdAt = userResponse.createdAt
        
    }
    
}

extension CDUserResponseEntity {
    
    var userResponse: UserResponse {
        guard let nickname = self.nickname,
              let password = self.password,
              let createdAt = self.createdAt
        else {
            fatalError()
        }
        return .init(userId: self.userId,
                     nickname: nickname,
                     password: password,
                     createdAt: createdAt)
    }
    
}
