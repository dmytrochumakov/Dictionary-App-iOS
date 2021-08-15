//
//  MDCreateUserCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import CoreData

final class MDCreateUserCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStorage: MDUserCoreDataStorage
    fileprivate let userEntity: UserEntity
    fileprivate let result: MDUserOperationResult?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDUserCoreDataStorage,
         userEntity: UserEntity,
         result: MDUserOperationResult?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.userEntity = userEntity
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let newUser = CDUserEntity.init(userEntity: self.userEntity,
                                        insertIntoManagedObjectContext: self.managedObjectContext)
        
        self.coreDataStorage.save(userId: newUser.userId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let createdWord):
                    self?.result?(.success(createdWord))
                    self?.finish()
                case .failure(let error):
                    self?.result?(.failure(error))
                    self?.finish()
                }
            }
        }
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
    
}
