//
//  MDJWTCoreDataStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation
import CoreData

protocol MDJWTCoreDataStorageProtocol: MDCRUDJWTProtocol,
                                       MDEntitiesCountProtocol {
    
}

final class MDJWTCoreDataStorage: NSObject,
                                  MDJWTCoreDataStorageProtocol {
    
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

// MARK: - Count
extension MDJWTCoreDataStorage {
    
    func entitiesCount(_ completionHandler: @escaping (MDEntityCountResult)) {
        self.readAllJWTs() { [unowned self] result in
            switch result {
            case .success(let entities):
                completionHandler(.success(entities.count))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}

// MARK: - Create
extension MDJWTCoreDataStorage {
    
    func createJWT(_ authResponse: AuthResponse, _ completionHandler: @escaping (MDEntityResult<AuthResponse>)) {
        let operation = MDCreateJWTCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                 coreDataStorage: self,
                                                                 authResponse: authResponse) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}

// MARK: - Read
extension MDJWTCoreDataStorage {
    
    func readJWT(fromAccessToken accessToken: String, _ completionHandler: @escaping (MDEntityResult<AuthResponse>)) {
        let operation = MDReadJWTCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                               coreDataStorage: self,
                                                               accessToken: accessToken) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readAllJWTs(_ completionHandler: @escaping (MDEntitiesResult<AuthResponse>)) {
        let operation = MDReadJWTsCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                coreDataStorage: self) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}

// MARK: - Update
extension MDJWTCoreDataStorage {
    
    func updateJWT(oldAccessToken accessToken: String, newAuthResponse authResponse: AuthResponse, _ completionHandler: @escaping (MDEntityResult<AuthResponse>)) {
        
    }
    
}

// MARK: - Delete
extension MDJWTCoreDataStorage {
    
    func deleteJWT(_ authResponse: AuthResponse, _ completionHandler: @escaping (MDEntityResult<AuthResponse>)) {
        let operation = MDDeleteJWTCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                 coreDataStorage: self,
                                                                 authResponse: authResponse) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}

// MARK: - Save
extension MDJWTCoreDataStorage {
    
    func savePerform(completionHandler: @escaping CDResultSaved) {
        coreDataStack.savePerform(completionHandler: completionHandler)
    }
    
    func savePerform(accessToken: String, completionHandler: @escaping MDEntityResult<AuthResponse>) {
        coreDataStack.savePerform() { [unowned self] (result) in
            switch result {
            case .success:
                self.readJWT(fromAccessToken: accessToken) { [unowned self] (result) in
                    switch result {
                    case .success(let authResponse):
                        completionHandler(.success(authResponse))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func save(accessToken: String, completionHandler: @escaping MDEntityResult<AuthResponse>) {
        coreDataStack.savePerformAndWait() { [unowned self] (result) in
            switch result {
            case .success:
                self.readJWT(fromAccessToken: accessToken) { [unowned self] (result) in
                    switch result {
                    case .success(let authResponse):
                        completionHandler(.success(authResponse))
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
