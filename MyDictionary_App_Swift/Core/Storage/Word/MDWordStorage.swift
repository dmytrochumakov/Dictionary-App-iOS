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
    
    func createWord(_ wordModel: WordModel,
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
    
    func deleteWord(_ word: WordModel,
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

// MARK: - Is Empty
extension MDWordStorage {
    
    func entitiesIsEmpty(storageType: MDStorageType,
                         _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDEntitiesIsEmptyResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.entitiesIsEmpty { [unowned self] result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.entitiesIsEmpty { [unowned self] result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDEntitiesIsEmptyResultWithoutCompletion> = []
            // Check Result in Memory
            memoryStorage.entitiesIsEmpty { [unowned self] result in
                
                finalResult.append(.init(storageType: .memory, result: result))
                
                if (finalResult.count == MDStorageType.allCases.count) {
                    completionHandler(finalResult)
                }
                
            }
            // Check Result in Core Data
            coreDataStorage.entitiesIsEmpty { [unowned self] result in
                
                finalResult.append(.init(storageType: .coreData, result: result))
                
                if (finalResult.count == MDStorageType.allCases.count) {
                    completionHandler(finalResult)
                }
                
            }
            
        }
        
    }
    
}

// MARK: - CRUD
extension MDWordStorage {
    
    func createWord(_ wordModel: WordModel,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDWordResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.createWord(wordModel) { [unowned self] result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.createWord(wordModel) { [unowned self] result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDWordResultWithoutCompletion> = []
            // Create in Memory
            memoryStorage.createWord(wordModel) { [unowned self] result in
                
                finalResult.append(.init(storageType: .memory, result: result))
                
                if (finalResult.count == MDStorageType.allCases.count) {
                    completionHandler(finalResult)
                }
                
            }
            // Create in Core Data
            coreDataStorage.createWord(wordModel) { [unowned self] result in
                
                finalResult.append(.init(storageType: .coreData, result: result))
                
                if (finalResult.count == MDStorageType.allCases.count) {
                    completionHandler(finalResult)
                }
                
            }
            
        }
        
    }
    
    func readWord(fromID id: Int64,
                  storageType: MDStorageType,
                  _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDWordResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.readWord(fromID: id) { [unowned self] (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.readWord(fromID: id) { [unowned self] (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDWordResultWithoutCompletion> = []
            // Read From Memory
            memoryStorage.readWord(fromID: id) { [unowned self] result in
                
                finalResult.append(.init(storageType: .memory, result: result))
                
                if (finalResult.count == MDStorageType.allCases.count) {
                    completionHandler(finalResult)
                }
                
            }
            // Read From Core Data
            coreDataStorage.readWord(fromID: id) { [unowned self] result in
                
                finalResult.append(.init(storageType: .coreData, result: result))
                
                if (finalResult.count == MDStorageType.allCases.count) {
                    completionHandler(finalResult)
                }
                
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
                                     word_description: word_description) { [unowned self] (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.updateWord(byID: id,
                                       word: word,
                                       word_description: word_description) { [unowned self] (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDWordResultWithoutCompletion> = []
            // Update In Memory
            memoryStorage.updateWord(byID: id,
                                     word: word,
                                     word_description: word_description) { [unowned self] result in
                
                finalResult.append(.init(storageType: .memory, result: result))
                
                if (finalResult.count == MDStorageType.allCases.count) {
                    completionHandler(finalResult)
                }
                
            }
            // Update In Core Data
            coreDataStorage.updateWord(byID: id,
                                       word: word,
                                       word_description: word_description) { [unowned self] result in
                
                finalResult.append(.init(storageType: .coreData, result: result))
                
                if (finalResult.count == MDStorageType.allCases.count) {
                    completionHandler(finalResult)
                }
                
            }
            
        }
        
    }
    
    func deleteWord(_ word: WordModel, storageType: MDStorageType, _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDWordResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.deleteWord(word) { [unowned self] result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.deleteWord(word) { [unowned self] result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDWordResultWithoutCompletion> = []
            // Delete From Memory
            memoryStorage.deleteWord(word) { [unowned self] result in
                
                finalResult.append(.init(storageType: .memory, result: result))
                
                if (finalResult.count == MDStorageType.allCases.count) {
                    completionHandler(finalResult)
                }
                
            }
            // Delete From Core Data
            coreDataStorage.deleteWord(word) { [unowned self] result in
                
                finalResult.append(.init(storageType: .coreData, result: result))
                
                if (finalResult.count == MDStorageType.allCases.count) {
                    completionHandler(finalResult)
                }
                
            }
            
        }
    }
    
}
