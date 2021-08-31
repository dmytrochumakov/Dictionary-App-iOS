//
//  MDUserStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDUserStorageProtocol: MDStorageProtocol {
    
    func createUser(_ userEntity: UserResponse,
                    password: String,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<UserResponse>>))
    
    func readUser(fromUserID userId: Int64,
                  storageType: MDStorageType,
                  _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<UserResponse>>))
    
    func deleteUser(_ userEntity: UserResponse,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<UserResponse>>))
    
}

final class MDUserStorage: MDStorage, MDUserStorageProtocol {
    
    fileprivate let memoryStorage: MDUserMemoryStorageProtocol
    fileprivate let coreDataStorage: MDUserCoreDataStorageProtocol
    
    init(memoryStorage: MDUserMemoryStorageProtocol,
         coreDataStorage: MDUserCoreDataStorageProtocol) {
        
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
extension MDUserStorage {
    
    func createUser(_ userEntity: UserResponse,
                    password: String,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<UserResponse>>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.createUser(userEntity, password: password) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.createUser(userEntity, password: password) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<UserResponse>> = []
            
            // Create in Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.createUser(userEntity, password: password) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Create in Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.createUser(userEntity, password: password) { result in
                
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
    
    func readUser(fromUserID userId: Int64,
                  storageType: MDStorageType,
                  _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<UserResponse>>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.readUser(fromUserID: userId) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.readUser(fromUserID: userId) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<UserResponse>> = []
            
            // Read From Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.readUser(fromUserID: userId) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Read From Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.readUser(fromUserID: userId) { result in
                
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
    
    func deleteUser(_ userEntity: UserResponse,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<UserResponse>>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.deleteUser(userEntity) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.deleteUser(userEntity) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<UserResponse>> = []
            
            // Delete From Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.deleteUser(userEntity) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Delete From Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.deleteUser(userEntity) { result in
                
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
