//
//  UserModel.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 17.07.2021.
//

import Foundation
import CoreData

struct UserModel {
    let id: Int64
    let username: String
}

extension UserModel {
    
    func cdUserEntity(insertIntoManagedObjectContext: NSManagedObjectContext) -> CDUserEntity {
        return .init(userModel: self,
                     insertIntoManagedObjectContext: insertIntoManagedObjectContext)
    }
    
}
