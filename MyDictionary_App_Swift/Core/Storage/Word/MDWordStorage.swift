//
//  MDWordStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.05.2021.
//

import Foundation

protocol MDWordStorageProtocol {
    
    func entitiesIsEmpty(storageType: MDStorageType,
                         _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDEntitiesIsEmptyResultWithoutCompletion>))
    
    func entitiesCount(storageType: MDStorageType,
                       _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDEntitiesCountResultWithoutCompletion>))
    
    func createWord(_ wordModel: WordEntity,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDWordResultWithoutCompletion>))
    
    func readWord(fromID id: Int64,
                  storageType: MDStorageType,
                  _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDWordResultWithoutCompletion>))
    
    func updateWord(byID id: Int64,
                    word: String,
                    word_description: String,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDWordResultWithoutCompletion>))
    
    func deleteWord(_ word: WordEntity,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDWordResultWithoutCompletion>))
    
}

final class MDWordStorage: MDWordStorageProtocol {
    
    fileprivate let memoryStorage: MDWordMemoryStorageProtocol
    fileprivate let coreDataStorage: MDWordCoreDataStorageProtocol
    
    init(memoryStorage: MDWordMemoryStorageProtocol,
         coreDataStorage: MDWordCoreDataStorageProtocol) {
        
        self.memoryStorage = memoryStorage
        self.coreDataStorage = coreDataStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDWordStorage {
    
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
            
            // Check Result in Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.entitiesIsEmpty { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Check Result in Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.entitiesIsEmpty { result in
                
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
extension MDWordStorage {
    
    func createWord(_ wordModel: WordEntity,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDWordResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.createWord(wordModel) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.createWord(wordModel) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDWordResultWithoutCompletion> = []
            
            // Create in Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.createWord(wordModel) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Create in Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.createWord(wordModel) { result in
                
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
    
    func readWord(fromID id: Int64,
                  storageType: MDStorageType,
                  _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDWordResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.readWord(fromID: id) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.readWord(fromID: id) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDWordResultWithoutCompletion> = []
            
            // Read From Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.readWord(fromID: id) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
                
            }
            
            // Read From Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.readWord(fromID: id) { result in
                
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
    
    func updateWord(byID id: Int64,
                    word: String,
                    word_description: String,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDWordResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.updateWord(byID: id,
                                     word: word,
                                     word_description: word_description) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.updateWord(byID: id,
                                       word: word,
                                       word_description: word_description) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDWordResultWithoutCompletion> = []
            
            // Update In Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.updateWord(byID: id,
                                     word: word,
                                     word_description: word_description) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
                
            }
            
            // Update In Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.updateWord(byID: id,
                                       word: word,
                                       word_description: word_description) { result in
                
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
    
    func deleteWord(_ word: WordEntity, storageType: MDStorageType, _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDWordResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.deleteWord(word) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.deleteWord(word) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDWordResultWithoutCompletion> = []
            
            // Delete From Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.deleteWord(word) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Delete From Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.deleteWord(word) { result in
                
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
