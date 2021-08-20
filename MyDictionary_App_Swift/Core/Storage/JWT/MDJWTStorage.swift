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
    
    func createJWT(storageType: MDStorageType,
                   jwtResponse: JWTResponse,
                   _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDJWTResultWithoutCompletion>))
    
    func readJWT(storageType: MDStorageType,
                 fromAccessToken accessToken: String,
                 _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDJWTResultWithoutCompletion>))
    
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
                
                if (Constants.StorageType.finalResultCountIsEqualStorageTypesWithoutAllCount(finalResult.count)) {
                    completionHandler(finalResult)
                }
                
            }
            // Check in Core Data
            coreDataStorage.entitiesIsEmpty() { [unowned self] result in
                
                finalResult.append(.init(storageType: .coreData, result: result))
                
                if (Constants.StorageType.finalResultCountIsEqualStorageTypesWithoutAllCount(finalResult.count)) {
                    completionHandler(finalResult)
                }
                
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
            
            memoryStorage.createJWT(jwtResponse) { [unowned self] (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.createJWT(jwtResponse) { [unowned self] (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDJWTResultWithoutCompletion> = []
            // Create in Memory
            memoryStorage.createJWT(jwtResponse) { [unowned self] result in
                
                finalResult.append(.init(storageType: .memory, result: result))
                
                if (Constants.StorageType.finalResultCountIsEqualStorageTypesWithoutAllCount(finalResult.count)) {
                    completionHandler(finalResult)
                }
                
            }
            // Create in Core Data
            coreDataStorage.createJWT(jwtResponse) { [unowned self] result in
                
                finalResult.append(.init(storageType: .coreData, result: result))
                
                if (Constants.StorageType.finalResultCountIsEqualStorageTypesWithoutAllCount(finalResult.count)) {
                    completionHandler(finalResult)
                }
                
            }
            
        }
        
    }
    
    func readJWT(storageType: MDStorageType,
                 fromAccessToken accessToken: String,
                 _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDJWTResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.readJWT(fromAccessToken: accessToken) { [unowned self] (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.readJWT(fromAccessToken: accessToken) { [unowned self] (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDJWTResultWithoutCompletion> = []
            // Read From Memory
            memoryStorage.readJWT(fromAccessToken: accessToken) { [unowned self] result in
                
                finalResult.append(.init(storageType: .memory, result: result))
                
                if (Constants.StorageType.finalResultCountIsEqualStorageTypesWithoutAllCount(finalResult.count)) {
                    completionHandler(finalResult)
                }
                
            }
            // Read From Core Data
            coreDataStorage.readJWT(fromAccessToken: accessToken) { [unowned self] (result) in
                
                finalResult.append(.init(storageType: .coreData, result: result))
                
                if (Constants.StorageType.finalResultCountIsEqualStorageTypesWithoutAllCount(finalResult.count)) {
                    completionHandler(finalResult)
                }
                
            }
            
        }
        
    }
    
    func updateJWT(storageType: MDStorageType,
                   oldAccessToken accessToken: String,
                   newJWTResponse jwtResponse: JWTResponse,
                   _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDJWTResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.updateJWT(oldAccessToken: accessToken,
                                    newJWTResponse: jwtResponse) { [unowned self] result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.updateJWT(oldAccessToken: accessToken, newJWTResponse: jwtResponse) { [unowned self] (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDJWTResultWithoutCompletion> = []
            // Update In Memory
            memoryStorage.updateJWT(oldAccessToken: accessToken,
                                    newJWTResponse: jwtResponse) { [unowned self] result in
                
                finalResult.append(.init(storageType: .memory, result: result))
                
                if (Constants.StorageType.finalResultCountIsEqualStorageTypesWithoutAllCount(finalResult.count)) {
                    completionHandler(finalResult)
                }
                
            }
            // Update In Core Data
            coreDataStorage.updateJWT(oldAccessToken: accessToken,
                                      newJWTResponse: jwtResponse) { [unowned self] (result) in
                
                finalResult.append(.init(storageType: .coreData, result: result))
                
                if (Constants.StorageType.finalResultCountIsEqualStorageTypesWithoutAllCount(finalResult.count)) {
                    completionHandler(finalResult)
                }
                
            }
            
        }
        
    }
    
    func deleteJWT(storageType: MDStorageType,
                   jwtResponse: JWTResponse,
                   _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDJWTResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.deleteJWT(jwtResponse) { [unowned self] result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.deleteJWT(jwtResponse) { [unowned self] result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDJWTResultWithoutCompletion> = []
            // Delete From Memory
            memoryStorage.deleteJWT(jwtResponse) { [unowned self] result in
                
                finalResult.append(.init(storageType: .memory, result: result))
                
                if (Constants.StorageType.finalResultCountIsEqualStorageTypesWithoutAllCount(finalResult.count)) {
                    completionHandler(finalResult)
                }
                
            }
            // Delete From Core Data
            coreDataStorage.deleteJWT(jwtResponse) { [unowned self] result in
                
                finalResult.append(.init(storageType: .coreData, result: result))
                
                if (Constants.StorageType.finalResultCountIsEqualStorageTypesWithoutAllCount(finalResult.count)) {
                    completionHandler(finalResult)
                }
                
            }
            
        }
        
    }
    
}
