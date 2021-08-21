//
//  MDJWTStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDJWTStorageProtocol {
    
    func entitiesIsEmpty(storageType: MDStorageType,
                         _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDEntitiesIsEmptyResultWithoutCompletion>))
    
    func entitiesCount(storageType: MDStorageType,
                       _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDEntitiesCountResultWithoutCompletion>))
    
    func createJWT(storageType: MDStorageType,
                   jwtResponse: JWTResponse,
                   _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDJWTResultWithoutCompletion>))
    
    func readJWT(storageType: MDStorageType,
                 fromAccessToken accessToken: String,
                 _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDJWTResultWithoutCompletion>))
    
    func readFirstJWT(storageType: MDStorageType,
                      _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDJWTResultWithoutCompletion>))
    
    func updateJWT(storageType: MDStorageType,
                   oldAccessToken accessToken: String,
                   newJWTResponse jwtResponse: JWTResponse,
                   _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDJWTResultWithoutCompletion>))
    
    func deleteJWT(storageType: MDStorageType,
                   jwtResponse: JWTResponse,
                   _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDJWTResultWithoutCompletion>))
    
}

final class MDJWTStorage: MDJWTStorageProtocol {
    
    fileprivate let memoryStorage: MDJWTMemoryStorageProtocol
    fileprivate let coreDataStorage: MDJWTCoreDataStorageProtocol
    
    init(memoryStorage: MDJWTMemoryStorageProtocol,
         coreDataStorage: MDJWTCoreDataStorageProtocol) {
        
        self.memoryStorage = memoryStorage
        self.coreDataStorage = coreDataStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Is Empty
extension MDJWTStorage {
    
    func entitiesIsEmpty(storageType: MDStorageType,
                         _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDEntitiesIsEmptyResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.entitiesIsEmpty() { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.entitiesIsEmpty() { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDEntitiesIsEmptyResultWithoutCompletion> = []
            
            // Check in Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.entitiesIsEmpty() { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Check in Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.entitiesIsEmpty() { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Notify And Pass Final Result
            dispatchGroup.notify(queue: .main) {
                completionHandler(finalResult)
            }
            
        }
        
    }
    
}

// MARK: - Count
extension MDJWTStorage {
    
    func entitiesCount(storageType: MDStorageType,
                       _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDEntitiesCountResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.entitiesCount() { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.entitiesCount() { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDEntitiesCountResultWithoutCompletion> = []
            
            // Check in Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.entitiesCount() { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Check in Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.entitiesCount() { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Notify And Pass Final Result
            dispatchGroup.notify(queue: .main) {
                completionHandler(finalResult)
            }
            
        }
        
    }
    
}

// MARK: - CRUD
extension MDJWTStorage {
    
    func createJWT(storageType: MDStorageType,
                   jwtResponse: JWTResponse,
                   _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDJWTResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.createJWT(jwtResponse) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.createJWT(jwtResponse) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDJWTResultWithoutCompletion> = []
            
            // Create in Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.createJWT(jwtResponse) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Create in Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.createJWT(jwtResponse) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Notify And Pass Final Result
            dispatchGroup.notify(queue: .main) {
                completionHandler(finalResult)
            }
            
        }
        
    }
    
    func readFirstJWT(storageType: MDStorageType,
                      _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDJWTResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.readFirstJWT() { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.readFirstJWT() { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDJWTResultWithoutCompletion> = []
            
            // Read From Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.readFirstJWT() { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Read From Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.readFirstJWT() { (result) in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Notify And Pass Final Result
            dispatchGroup.notify(queue: .main) {
                completionHandler(finalResult)
            }
            
        }
        
    }
    
    func readJWT(storageType: MDStorageType,
                 fromAccessToken accessToken: String,
                 _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDJWTResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.readJWT(fromAccessToken: accessToken) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.readJWT(fromAccessToken: accessToken) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDJWTResultWithoutCompletion> = []
            
            // Read From Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.readJWT(fromAccessToken: accessToken) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Read From Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.readJWT(fromAccessToken: accessToken) { (result) in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Notify And Pass Final Result
            dispatchGroup.notify(queue: .main) {
                completionHandler(finalResult)
            }
            
        }
        
    }      
    
    func updateJWT(storageType: MDStorageType,
                   oldAccessToken accessToken: String,
                   newJWTResponse jwtResponse: JWTResponse,
                   _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDJWTResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.updateJWT(oldAccessToken: accessToken,
                                    newJWTResponse: jwtResponse) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.updateJWT(oldAccessToken: accessToken, newJWTResponse: jwtResponse) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDJWTResultWithoutCompletion> = []
            
            // Update In Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.updateJWT(oldAccessToken: accessToken,
                                    newJWTResponse: jwtResponse) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Update In Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.updateJWT(oldAccessToken: accessToken,
                                      newJWTResponse: jwtResponse) { (result) in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Notify And Pass Final Result
            dispatchGroup.notify(queue: .main) {
                completionHandler(finalResult)
            }
            
        }
        
    }
    
    func deleteJWT(storageType: MDStorageType,
                   jwtResponse: JWTResponse,
                   _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDJWTResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.deleteJWT(jwtResponse) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.deleteJWT(jwtResponse) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDJWTResultWithoutCompletion> = []
            
            // Delete From Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.deleteJWT(jwtResponse) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Delete From Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.deleteJWT(jwtResponse) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Notify And Pass Final Result
            dispatchGroup.notify(queue: .main) {
                completionHandler(finalResult)
            }
            
        }
        
    }
    
}
