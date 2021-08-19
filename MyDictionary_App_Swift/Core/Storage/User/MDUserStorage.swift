//
//  MDUserStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDUserStorageProtocol {
    
    func entitiesIsEmpty(storageType: MDStorageType,
                         _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDEntitiesIsEmptyResultWithoutCompletion>))
    
    func createUser(_ userEntity: UserEntity,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDUserdResultWithoutCompletion>))
    
    func readUser(fromUserID userId: Int64,
                  storageType: MDStorageType,
                  _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDUserdResultWithoutCompletion>))
    
    func deleteUser(_ userEntity: UserEntity,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDUserdResultWithoutCompletion>))
    
}

final class MDUserStorage: MDUserStorageProtocol {
    
    fileprivate let memoryStorage: MDUserMemoryStorageProtocol
    fileprivate let coreDataStorage: MDUserCoreDataStorageProtocol
    
    init(memoryStorage: MDUserMemoryStorageProtocol,
         coreDataStorage: MDUserCoreDataStorageProtocol) {
        
        self.memoryStorage = memoryStorage
        self.coreDataStorage = coreDataStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Is Empty
extension MDUserStorage {
    
    func entitiesIsEmpty(storageType: MDStorageType,
                         _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDEntitiesIsEmptyResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.entitiesIsEmpty() { [unowned self] (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.entitiesIsEmpty() { [unowned self] (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDEntitiesIsEmptyResultWithoutCompletion> = []
            // Check in Memory
            memoryStorage.entitiesIsEmpty() { [unowned self] result in
                
                finalResult.append(.init(storageType: .memory, result: result))
                
                if (finalResult.count == MDStorageType.allCases.count) {
                    completionHandler(finalResult)
                }
                
            }
            // Check in Core Data
            coreDataStorage.entitiesIsEmpty() { [unowned self] result in
                
                finalResult.append(.init(storageType: .coreData, result: result))
                
                if (finalResult.count == MDStorageType.allCases.count) {
                    completionHandler(finalResult)
                }
                
            }
            
        }
        
    }
    
}

// MARK: - CRUD
extension MDUserStorage {
    
    func createUser(_ userEntity: UserEntity, storageType: MDStorageType, _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDUserdResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.createUser(userEntity) { [unowned self] (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.createUser(userEntity) { [unowned self] (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDUserdResultWithoutCompletion> = []
            // Create in Memory
            memoryStorage.createUser(userEntity) { [unowned self] result in
                
                finalResult.append(.init(storageType: .memory, result: result))
                
                if (finalResult.count == MDStorageType.allCases.count) {
                    completionHandler(finalResult)
                }
                
            }
            // Create in Core Data
            coreDataStorage.createUser(userEntity) { [unowned self] result in
                
                finalResult.append(.init(storageType: .coreData, result: result))
                
                if (finalResult.count == MDStorageType.allCases.count) {
                    completionHandler(finalResult)
                }
                
            }
            
        }
    }
    
    func readUser(fromUserID userId: Int64, storageType: MDStorageType, _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDUserdResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.readUser(fromUserID: userId) { [unowned self] (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.readUser(fromUserID: userId) { [unowned self] (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDUserdResultWithoutCompletion> = []
            // Read From Memory
            memoryStorage.readUser(fromUserID: userId) { [unowned self] result in
                
                finalResult.append(.init(storageType: .memory, result: result))
                
                if (finalResult.count == MDStorageType.allCases.count) {
                    completionHandler(finalResult)
                }
                
            }
            // Read From Core Data
            coreDataStorage.readUser(fromUserID: userId) { [unowned self] result in
                
                finalResult.append(.init(storageType: .coreData, result: result))
                
                if (finalResult.count == MDStorageType.allCases.count) {
                    completionHandler(finalResult)
                }
                
            }
            
        }
        
    }
    
    func deleteUser(_ userEntity: UserEntity, storageType: MDStorageType, _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDUserdResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.deleteUser(userEntity) { [unowned self] (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.deleteUser(userEntity) { [unowned self] (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDUserdResultWithoutCompletion> = []
            // Delete From Memory
            memoryStorage.deleteUser(userEntity) { [unowned self] result in
                
                finalResult.append(.init(storageType: .memory, result: result))
                
                if (finalResult.count == MDStorageType.allCases.count) {
                    completionHandler(finalResult)
                }
                
            }
            // Delete From Core Data
            coreDataStorage.deleteUser(userEntity) { [unowned self] result in
                
                finalResult.append(.init(storageType: .coreData, result: result))
                
                if (finalResult.count == MDStorageType.allCases.count) {
                    completionHandler(finalResult)
                }
                
            }
            
        }
        
    }
    
}
