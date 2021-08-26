//
//  MDLanguageStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDLanguageStorageProtocol: MDStorageProtocol {
    
    func createLanguages(storageType: MDStorageType,
                         languageEntities: [LanguageEntity],
                         _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDLanguageResultsWithoutCompletion>))
    
    func readAllLanguages(storageType: MDStorageType,
                          _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDLanguageResultsWithoutCompletion>))
    
    func deleteAllLanguages(storageType: MDStorageType,
                            _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDDeleteEntityResultWithoutCompletion>))
    
}

final class MDLanguageStorage: MDStorage, MDLanguageStorageProtocol {
    
    fileprivate let memoryStorage: MDLanguageMemoryStorageProtocol
    fileprivate let coreDataStorage: MDLanguageCoreDataStorageProtocol
    
    init(memoryStorage: MDLanguageMemoryStorageProtocol,
         coreDataStorage: MDLanguageCoreDataStorageProtocol) {
        
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
                            _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDDeleteEntityResultWithoutCompletion>)) {
        
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
            var finalResult: MDStorageResultsWithoutCompletion<MDDeleteEntityResultWithoutCompletion> = []
            
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
