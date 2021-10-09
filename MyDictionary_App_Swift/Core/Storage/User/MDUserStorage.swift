//
//  MDUserStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDUserStorageProtocol: MDStorageProtocol {
    
    var memoryStorage: MDUserMemoryStorageProtocol { get }
    
    func createUser(_ userEntity: UserResponse,
                    password: String,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<UserResponse>>))
    
    func readUser(fromUserID userId: Int64,
                  storageType: MDStorageType,
                  _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<UserResponse>>))
    
    func readFirstUser(storageType: MDStorageType,
                       _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<UserResponse>>))
    
    func deleteUser(_ userId: Int64,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>))
    
    func deleteAllUsers(storageType: MDStorageType,
                        _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>))
    
}

final class MDUserStorage: MDStorage, MDUserStorageProtocol {
    
    let memoryStorage: MDUserMemoryStorageProtocol
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
        
        debugPrint(#function, Self.self, "Start")
        
        switch storageType {
            
        case .memory:
            
            //
            self.memoryStorage.createUser(userEntity, password: password) { (result) in
                debugPrint(#function, Self.self, "memory -> with result:", result)
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
            
        case .coreData:
            
            //
            self.coreDataStorage.createUser(userEntity, password: password) { (result) in
                debugPrint(#function, Self.self, "coredata -> with result:", result)
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
            
        case .all:
            
            let countNeeded: Int = 2
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<UserResponse>> = []
            
            // Create in Memory
            self.memoryStorage.createUser(userEntity, password: password) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    debugPrint(#function, Self.self, "all -> memory -> with result:", result)
                    completionHandler(finalResult)
                }
                //
                
            }
            
            // Create in Core Data
            self.coreDataStorage.createUser(userEntity, password: password) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    debugPrint(#function, Self.self, "all -> coredata -> with result:", result)
                    completionHandler(finalResult)
                }
                //
                
            }
            
            //
            break
            //
            
        }
    }
    
    func readUser(fromUserID userId: Int64,
                  storageType: MDStorageType,
                  _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<UserResponse>>)) {
        
        switch storageType {
            
        case .memory:
            
            //
            self.memoryStorage.readUser(fromUserID: userId) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
            
        case .coreData:
            
            //
            self.coreDataStorage.readUser(fromUserID: userId) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .all:
            
            //
            let countNeeded: Int = 2
            //
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<UserResponse>> = []
            
            // Read From Memory
            self.memoryStorage.readUser(fromUserID: userId) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            // Read From Core Data
            self.coreDataStorage.readUser(fromUserID: userId) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            //
            break
            //
            
        }
        
    }
    
    func readFirstUser(storageType: MDStorageType,
                       _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<UserResponse>>)) {
        
        switch storageType {
            
        case .memory:
            
            //
            self.memoryStorage.readFirstUser { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .coreData:
            
            //
            self.coreDataStorage.readFirstUser { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .all:
            
            //
            let countNeeded: Int = 2
            //
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<UserResponse>> = []
            
            // Read From Memory
            self.memoryStorage.readFirstUser { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            // Read From Core Data
            self.coreDataStorage.readFirstUser { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            //
            break
            //
            
        }
        
    }
    
    func deleteUser(_ userId: Int64,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
            
        case .memory:
            
            //
            self.memoryStorage.deleteUser(userId) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
            
        case .coreData:
            
            //
            self.coreDataStorage.deleteUser(userId) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .all:
            
            //
            let countNeeded: Int = 2
            //
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<Void>> = []
            
            // Delete From Memory
            self.memoryStorage.deleteUser(userId) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            // Delete From Core Data
            self.coreDataStorage.deleteUser(userId) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            //
            break
            //
            
        }
        
    }
    
    func deleteAllUsers(storageType: MDStorageType,
                        _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
            
        case .memory:
            
            
            //
            self.memoryStorage.deleteAllUsers { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .coreData:
            
            
            //
            self.coreDataStorage.deleteAllUsers { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .all:
            
            //
            let countNeeded: Int = 2
            //
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<Void>> = []
            
            // Delete From Memory
            self.memoryStorage.deleteAllUsers { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            // Delete From Core Data
            self.coreDataStorage.deleteAllUsers { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            //
            break
            //
            
        }
        
    }
    
}
