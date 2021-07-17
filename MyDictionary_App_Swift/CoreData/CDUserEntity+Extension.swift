//
//  CDUserEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 17.07.2021.
//

import CoreData

extension CDUserEntity {
    
    convenience init(userModel: UserModel,
                     insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        
        let entity = NSEntityDescription.entity(forEntityName: CoreDataEntityName.CDUserEntity, in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.id = userModel.id
        self.username = userModel.username        
        
    }
    
}

extension CDUserEntity {
    
    var userModel: UserModel {
        guard let username = self.username
        else {
            fatalError()
        }
        return .init(id: self.id,
                     username: username)
    }
    
}
