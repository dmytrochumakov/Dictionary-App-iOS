//
//  MDUserCoreDataStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation
import CoreData

protocol MDUserCoreDataStorageProtocol: MDCRUDUserProtocol {
    
}

final class MDUserCoreDataStorage: NSObject,
                                   MDUserCoreDataStorageProtocol {
    
    fileprivate let operationQueueService: OperationQueueServiceProtocol
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: CoreDataStack
    
    init(operationQueueService: OperationQueueServiceProtocol,
         managedObjectContext: NSManagedObjectContext,
         coreDataStack: CoreDataStack) {
        
        self.operationQueueService = operationQueueService
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Create
extension MDUserCoreDataStorage {
    
    func createUser(_ userEntity: UserEntity, _ completionHandler: @escaping (MDUserResult)) {
        let operation = MDCreateUserCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                  coreDataStorage: self,
                                                                  userEntity: userEntity) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}

// MARK: - Read
extension MDUserCoreDataStorage {
    
    func readUser(fromUserID userId: Int64, _ completionHandler: @escaping (MDUserResult)) {
        let operation = MDReadUserCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                coreDataStorage: self,
                                                                userId: userId) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}

// MARK: - Update
extension MDUserCoreDataStorage {
    
    
}

// MARK: - Delete
extension MDUserCoreDataStorage {
    
    func deleteUser(_ userEntity: UserEntity, _ completionHandler: @escaping (MDUserResult)) {
        
    }
    
}

// MARK: - Save
extension MDUserCoreDataStorage {
    
    func savePerform(completionHandler: @escaping CDResultSaved) {
        coreDataStack.savePerform(completionHandler: completionHandler)
    }
    
    func savePerform(userId: Int64, completionHandler: @escaping MDCDResultSavedUser) {
        coreDataStack.savePerform() { [unowned self] (result) in
            switch result {
            case .success:
                self.readUser(fromUserID: userId) { [unowned self] (result) in
                    switch result {
                    case .success(let userEntity):
                        completionHandler(.success(userEntity))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func save(userId: Int64, completionHandler: @escaping MDCDResultSavedUser) {
        coreDataStack.savePerformAndWait() { [unowned self] (result) in
            switch result {
            case .success:
                self.readUser(fromUserID: userId) { [unowned self] (result) in
                    switch result {
                    case .success(let userEntity):
                        completionHandler(.success(userEntity))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
