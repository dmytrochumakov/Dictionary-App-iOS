//
//  MDStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 24.08.2021.
//

import Foundation

protocol MDStorageProtocol {
    
    func entitiesCount(storageType: MDStorageType,
                       _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDEntitiesCountResultWithoutCompletion>))
    
    func entitiesIsEmpty(storageType: MDStorageType,
                         _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDEntitiesIsEmptyResultWithoutCompletion>))
    
}

open class MDStorage: NSObject, MDStorageProtocol {
    
    fileprivate let memoryStorage: MDStorageInterface
    fileprivate let coreDataStorage: MDStorageInterface
    
    init(memoryStorage: MDStorageInterface,
         coreDataStorage: MDStorageInterface) {
        
        self.memoryStorage = memoryStorage
        self.coreDataStorage = coreDataStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
    func entitiesCount(storageType: MDStorageType,
                       _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDEntitiesCountResultWithoutCompletion>)) {
        
        switch storageType {
            
        case .memory:
            
            
            //
            self.memoryStorage.entitiesCount { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            
            //
            break
            //
            
        case .coreData:
            
            //
            self.coreDataStorage.entitiesCount { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .all:
            
            
            let countNeeded: Int = 2
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDEntitiesCountResultWithoutCompletion> = []
            
            // Check in Memory
            self.memoryStorage.entitiesCount() { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                
                //  Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            // Check in Core Data
            self.coreDataStorage.entitiesCount() { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                
                //  Pass Final Result If Needed
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
    
    func entitiesIsEmpty(storageType: MDStorageType,
                         _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDEntitiesIsEmptyResultWithoutCompletion>)) {
        
        switch storageType {
            
        case .memory:
            
            //
            self.memoryStorage.entitiesIsEmpty { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .coreData:
            
            //
            self.coreDataStorage.entitiesIsEmpty { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .all:
            
            let countNeeded: Int = 2
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDEntitiesIsEmptyResultWithoutCompletion> = []
            
            // Check in Memory
            self.memoryStorage.entitiesIsEmpty() { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                
                //  Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            // Check in Core Data
            self.coreDataStorage.entitiesIsEmpty() { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                
                //  Pass Final Result If Needed
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
