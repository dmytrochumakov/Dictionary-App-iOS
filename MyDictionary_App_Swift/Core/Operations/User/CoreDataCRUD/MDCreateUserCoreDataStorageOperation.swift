//
//  MDCreateUserCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import CoreData

final class MDCreateUserCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: CoreDataStack
    fileprivate let coreDataStorage: MDUserCoreDataStorage
    fileprivate let userEntity: UserResponse
    fileprivate let password: String
    fileprivate let result: MDOperationResultWithCompletion<UserResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStack: CoreDataStack,
         coreDataStorage: MDUserCoreDataStorage,
         userEntity: UserResponse,
         password: String,
         result: MDOperationResultWithCompletion<UserResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        self.coreDataStorage = coreDataStorage
        self.userEntity = userEntity
        self.password = password
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let newUser = CDUserResponseEntity.init(userResponse: self.userEntity,
                                                password: password,
                                                insertIntoManagedObjectContext: self.managedObjectContext)
        
        do {
            
            try coreDataStack.save()
            
            self.result?(.success(newUser.userResponse))
            self.finish()
                        
        } catch {
            self.result?(.failure(error))
            self.finish()
        }
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
    
}
