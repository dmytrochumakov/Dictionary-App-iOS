//
//  MDLanguageStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDLanguageStorageProtocol {
    
    func entitiesIsEmpty(storageType: MDStorageType,
                         _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDEntitiesIsEmptyResultWithoutCompletion>))
    
    func entitiesCount(storageType: MDStorageType,
                       _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDEntitiesCountResultWithoutCompletion>))
    
    func createLanguages(storageType: MDStorageType,
                         languageEntities: [LanguageEntity],
                         _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDLanguageResultsWithoutCompletion>))
    
    func readAllLanguages(storageType: MDStorageType,
                          _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDLanguageResultsWithoutCompletion>))
    
    func deleteAllLanguages(storageType: MDStorageType,
                            _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDDeleteAllEntitiesResultWithoutCompletion>))
    
}

final class MDLanguageStorage: MDLanguageStorageProtocol {
    
    fileprivate let memoryStorage: MDLanguageMemoryStorageProtocol
    fileprivate let coreDataStorage: MDLanguageCoreDataStorageProtocol
    
    init(memoryStorage: MDLanguageMemoryStorageProtocol,
         coreDataStorage: MDLanguageCoreDataStorageProtocol) {
        
        self.memoryStorage = memoryStorage
        self.coreDataStorage = coreDataStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Entities
extension MDLanguageStorage {
    
    func entitiesIsEmpty(storageType: MDStorageType,
                         _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDEntitiesIsEmptyResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.entitiesIsEmpty { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.entitiesIsEmpty { result in
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
    
    func entitiesCount(storageType: MDStorageType,
                       _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDEntitiesCountResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.entitiesCount { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.entitiesCount { result in
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
extension MDLanguageStorage {       
    
    func createLanguages(storageType: MDStorageType,
                         languageEntities: [LanguageEntity],
                         _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDLanguageResultsWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.createLanguages(languageEntities) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.createLanguages(languageEntities) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDLanguageResultsWithoutCompletion> = []
            
            // Create in Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.createLanguages(languageEntities) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Create in Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.createLanguages(languageEntities) { result in
                
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
    
    func readAllLanguages(storageType: MDStorageType,
                          _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDLanguageResultsWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.readAllLanguages { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
            
        case .coreData:
            
            coreDataStorage.readAllLanguages { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDLanguageResultsWithoutCompletion> = []
            
            // Read From Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.readAllLanguages { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Read From Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.readAllLanguages { result in
                
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
    
    func deleteAllLanguages(storageType: MDStorageType,
                            _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDDeleteAllEntitiesResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.deleteAllLanguages { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.deleteAllLanguages { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDDeleteAllEntitiesResultWithoutCompletion> = []
            
            // Delete From Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.deleteAllLanguages { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Delete From Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.deleteAllLanguages { result in
                
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
