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
    fileprivate let operationQueue: OperationQueue
    
    init(memoryStorage: MDJWTMemoryStorageProtocol,
         coreDataStorage: MDJWTCoreDataStorageProtocol,
         operationQueue: OperationQueue) {
        
        self.memoryStorage = memoryStorage
        self.coreDataStorage = coreDataStorage
        self.operationQueue = operationQueue
        
        super.init(memoryStorage: memoryStorage,
                   coreDataStorage: coreDataStorage,
                   operationQueue: operationQueue)
        
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
            
            let operation: BlockOperation = .init {
                //
                self.memoryStorage.createJWT(jwtResponse) { (result) in
                    completionHandler([.init(storageType: storageType, result: result)])
                }
                //
            }
            
            // Add Operation
            operationQueue.addOperation(operation)
            //
            break
            //
            
        case .coreData:
            
            let operation: BlockOperation = .init {
                //
                self.coreDataStorage.createJWT(jwtResponse) { (result) in
                    completionHandler([.init(storageType: storageType, result: result)])
                }
                //
            }
            
            // Add Operation
            operationQueue.addOperation(operation)
            //
            break
            //
            
        case .all:
            
            let operation: BlockOperation = .init {
                
                //
                let countNeeded: Int = 2
                //
                
                // Initialize final result
                var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<JWTResponse>> = []
                
                // Create in Memory
                self.memoryStorage.createJWT(jwtResponse) { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .memory, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    
                }
                
                // Create in Core Data
                self.coreDataStorage.createJWT(jwtResponse) { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .coreData, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                }
                
            }
            
            // Add Operation
            operationQueue.addOperation(operation)
            //
            break
            //
            
        }
        
    }
    
    func readFirstJWT(storageType: MDStorageType,
                      _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<JWTResponse>>)) {
        
        switch storageType {
            
        case .memory:
            
            let operation: BlockOperation = .init {
                //
                self.memoryStorage.readFirstJWT() { (result) in
                    completionHandler([.init(storageType: storageType, result: result)])
                }
                //
            }
            
            // Add Operation
            operationQueue.addOperation(operation)
            //
            break
            //
            
        case .coreData:
            
            let operation: BlockOperation = .init {
                //
                self.coreDataStorage.readFirstJWT() { (result) in
                    completionHandler([.init(storageType: storageType, result: result)])
                }
                //
            }
            
            // Add Operation
            operationQueue.addOperation(operation)
            //
            break
            //
            
        case .all:
            
            let operation: BlockOperation = .init {
                
                //
                let countNeeded: Int = 2
                //
                
                // Initialize final result
                var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<JWTResponse>> = []
                
                // Read From Memory
                self.memoryStorage.readFirstJWT() { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .memory, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                }
                
                // Read From Core Data
                self.coreDataStorage.readFirstJWT() { (result) in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .coreData, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                }
                
            }
            
            // Add Operation
            operationQueue.addOperation(operation)
            //
            break
            //
            
        }
        
    }
    
    func readJWT(storageType: MDStorageType,
                 fromAccessToken accessToken: String,
                 _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<JWTResponse>>)) {
        
        switch storageType {
            
        case .memory:
            
            let operation: BlockOperation = .init {
                //
                self.memoryStorage.readJWT(fromAccessToken: accessToken) { (result) in
                    completionHandler([.init(storageType: storageType, result: result)])
                }
                //
            }
            
            // Add Operation
            operationQueue.addOperation(operation)
            //
            break
            //
            
        case .coreData:
            
            let operation: BlockOperation = .init {
                //
                self.coreDataStorage.readJWT(fromAccessToken: accessToken) { (result) in
                    completionHandler([.init(storageType: storageType, result: result)])
                }
                //
            }
            
            // Add Operation
            operationQueue.addOperation(operation)
            //
            break
            //
            
        case .all:
            
            let operation: BlockOperation = .init {
                
                //
                let countNeeded: Int = 2
                //
                
                // Initialize final result
                var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<JWTResponse>> = []
                
                // Read From Memory
                self.memoryStorage.readJWT(fromAccessToken: accessToken) { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .memory, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                }
                
                // Read From Core Data
                self.coreDataStorage.readJWT(fromAccessToken: accessToken) { (result) in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .coreData, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                }
                
            }
            
            // Add Operation
            operationQueue.addOperation(operation)
            //
            break
            //
            
        }
        
    }
    
    func updateJWT(storageType: MDStorageType,
                   oldAccessToken accessToken: String,
                   newJWTResponse jwtResponse: JWTResponse,
                   _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
            
        case .memory:
            
            let operation: BlockOperation = .init {
                //
                self.memoryStorage.updateJWT(oldAccessToken: accessToken,
                                             newJWTResponse: jwtResponse) { result in
                    completionHandler([.init(storageType: storageType, result: result)])
                }
                //
            }
            
            // Add Operation
            operationQueue.addOperation(operation)
            //
            break
            //
            
        case .coreData:
            
            let operation: BlockOperation = .init {
                //
                self.coreDataStorage.updateJWT(oldAccessToken: accessToken, newJWTResponse: jwtResponse) { (result) in
                    completionHandler([.init(storageType: storageType, result: result)])
                }
                //
            }
            
            // Add Operation
            operationQueue.addOperation(operation)
            //
            break
            //
            
        case .all:
            
            let operation: BlockOperation = .init {
                
                //
                let countNeeded: Int = 2
                //
                
                // Initialize final result
                var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<Void>> = []
                
                // Update In Memory
                self.memoryStorage.updateJWT(oldAccessToken: accessToken,
                                             newJWTResponse: jwtResponse) { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .memory, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                }
                
                // Update In Core Data
                self.coreDataStorage.updateJWT(oldAccessToken: accessToken,
                                               newJWTResponse: jwtResponse) { (result) in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .coreData, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                }
                
            }
            
            // Add Operation
            operationQueue.addOperation(operation)
            //
            break
            //
            
        }
        
    }
    
    func deleteJWT(storageType: MDStorageType,
                   accessToken: String,
                   _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
            
        case .memory:
            
            let operation: BlockOperation = .init {
                //
                self.memoryStorage.deleteJWT(accessToken) { result in
                    completionHandler([.init(storageType: storageType, result: result)])
                }
                //
            }
            
            // Add Operation
            operationQueue.addOperation(operation)
            //
            break
            //
            
        case .coreData:
            
            let operation: BlockOperation = .init {
                //
                self.coreDataStorage.deleteJWT(accessToken) { result in
                    completionHandler([.init(storageType: storageType, result: result)])
                }
                //
            }
            
            // Add Operation
            operationQueue.addOperation(operation)
            //
            break
            //
            
        case .all:
            
            let operation: BlockOperation = .init {
                
                //
                let countNeeded: Int = 2
                //
                
                // Initialize final result
                var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<Void>> = []
                
                // Delete From Memory
                self.memoryStorage.deleteJWT(accessToken) { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .memory, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                }
                
                // Delete From Core Data
                self.coreDataStorage.deleteJWT(accessToken) { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .coreData, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                }
                
            }
            
            // Add Operation
            operationQueue.addOperation(operation)
            //
            break
            //
            
        }
        
    }
    
    func deleteAllJWT(storageType: MDStorageType, _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
            
        case .memory:
            
            let operation: BlockOperation = .init {
                //
                self.memoryStorage.deleteAllJWT { result in
                    completionHandler([.init(storageType: storageType, result: result)])
                }
                //
            }
            
            // Add Operation
            operationQueue.addOperation(operation)
            //
            break
            //
            
        case .coreData:
            
            let operation: BlockOperation = .init {
                //
                self.coreDataStorage.deleteAllJWT { result in
                    completionHandler([.init(storageType: storageType, result: result)])
                }
                //
            }
            
            // Add Operation
            operationQueue.addOperation(operation)
            //
            break
            //
            
        case .all:
            
            let operation: BlockOperation = .init {
                
                //
                let countNeeded: Int = 2
                //
                
                // Initialize final result
                var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<Void>> = []
                
                // Delete From Memory
                self.memoryStorage.deleteAllJWT { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .memory, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                }
                
                // Delete From Core Data
                self.coreDataStorage.deleteAllJWT { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .coreData, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                }
                
            }
            
            // Add Operation
            operationQueue.addOperation(operation)
            //
            break
            //
            
        }
        
    }
    
}
