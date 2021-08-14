//
//  CDUserEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 17.07.2021.
//

import CoreData

extension CDUserEntity {
    
    convenience init(userEntity: UserEntity,
                     insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        
        let entity = NSEntityDescription.entity(forEntityName: CoreDataEntityName.CDUserEntity, in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.userId = userEntity.userId
        self.nickname = userEntity.nickname
        self.password = userEntity.password
        self.createdAt = userEntity.createdAt
        self.updatedAt = userEntity.updatedAt
        
    }
    
}

extension CDUserEntity {
    
    var userEntity: UserEntity {
        guard let nickname = self.nickname,
              let password = self.password,
              let createdAt = self.createdAt,
              let updatedAt = self.updatedAt
        else {
            fatalError()
        }
        return .init(userId: self.userId,
                     nickname: nickname,
                     password: password,
                     createdAt: createdAt,
                     updatedAt: updatedAt)
    }
    
}
