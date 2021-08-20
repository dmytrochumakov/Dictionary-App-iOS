//
//  MDJWTCoreDataStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation
import CoreData

protocol MDJWTCoreDataStorageProtocol: MDCRUDJWTProtocol,
                                       MDEntitiesIsEmptyProtocol {
    
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

// MARK: - Is Empty
extension MDJWTCoreDataStorage {
    
    func entitiesIsEmpty(_ completionHandler: @escaping (MDEntitiesIsEmptyResultWithCompletion)) {
        self.readAllJWTs() { [unowned self] result in
            switch result {
            case .success(let entities):
                completionHandler(.success(entities.isEmpty))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}

// MARK: - Create
extension MDJWTCoreDataStorage {
    
    func createJWT(_ jwtResponse: JWTResponse, _ completionHandler: @escaping (MDEntityResult<JWTResponse>)) {
        let operation = MDCreateJWTCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                 coreDataStorage: self,
                                                                 jwtResponse: jwtResponse) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}

// MARK: - Read
extension MDJWTCoreDataStorage {
    
    func readJWT(fromAccessToken accessToken: String, _ completionHandler: @escaping (MDEntityResult<JWTResponse>)) {
        let operation = MDReadJWTCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                               coreDataStorage: self,
                                                               accessToken: accessToken) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readAllJWTs(_ completionHandler: @escaping (MDEntitiesResult<JWTResponse>)) {
        let operation = MDReadJWTsCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                coreDataStorage: self) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}

// MARK: - Delete
extension MDJWTCoreDataStorage {
    
    func deleteJWT(_ jwtResponse: JWTResponse, _ completionHandler: @escaping (MDEntityResult<JWTResponse>)) {
        let operation = MDDeleteJWTCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                 coreDataStorage: self,
                                                                 jwtResponse: jwtResponse) { result in
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
    
    func savePerform(accessToken: String, completionHandler: @escaping MDEntityResult<JWTResponse>) {
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
    
    func save(accessToken: String, completionHandler: @escaping MDEntityResult<JWTResponse>) {
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
