//
//  MDJWTStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDJWTStorageProtocol: MDStorageProtocol {
    
    var memoryStorage: MDJWTMemoryStorageProtocol { get }
    
    func createJWT(storageType: MDStorageType,
                   jwtResponse: JWTResponse,
                   _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<JWTResponse>>))
    
    func readJWT(storageType: MDStorageType,
                 fromAccessToken accessToken: String,
                 _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<JWTResponse>>))
    
    func readFirstJWT(storageType: MDStorageType,
                      _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<JWTResponse>>))
    
    func updateJWT(storageType: MDStorageType,
                   oldAccessToken accessToken: String,
                   newJWTResponse jwtResponse: JWTResponse,
                   _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>))
    
    func deleteJWT(storageType: MDStorageType,
                   accessToken: String,
                   _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>))
    
    func deleteAllJWT(storageType: MDStorageType,
                      _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>))
    
}

final class MDJWTStorage: MDStorage, MDJWTStorageProtocol {
    
    let memoryStorage: MDJWTMemoryStorageProtocol
    fileprivate let coreDataStorage: MDJWTCoreDataStorageProtocol
    
    init(memoryStorage: MDJWTMemoryStorageProtocol,
         coreDataStorage: MDJWTCoreDataStorageProtocol) {
        
        self.memoryStorage = memoryStorage
        self.coreDataStorage = coreDataStorage
        
        super.init(memoryStorage: memoryStorage,
                   coreDataStorage: coreDataStorage)
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - CRUD
extension MDJWTStorage {
    
    func createJWT(storageType: MDStorageType,
                   jwtResponse: JWTResponse,
                   _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<JWTResponse>>)) {
        
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
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<JWTResponse>> = []
            
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
                      _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<JWTResponse>>)) {
        
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
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<JWTResponse>> = []
            
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
                 _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<JWTResponse>>)) {
        
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
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<JWTResponse>> = []
            
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
                   _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
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
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<Void>> = []
            
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
                   accessToken: String,
                   _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.deleteJWT(accessToken) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.deleteJWT(accessToken) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<Void>> = []
            
            // Delete From Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.deleteJWT(accessToken) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Delete From Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.deleteJWT(accessToken) { result in
                
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
    
    func deleteAllJWT(storageType: MDStorageType, _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.deleteAllJWT { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.deleteAllJWT { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<Void>> = []
            
            // Delete From Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.deleteAllJWT { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Delete From Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.deleteAllJWT { result in
                
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
