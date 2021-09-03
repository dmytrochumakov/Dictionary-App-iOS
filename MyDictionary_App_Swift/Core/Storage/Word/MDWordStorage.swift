//
//  MDWordStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.05.2021.
//

import Foundation

protocol MDWordStorageProtocol: MDStorageProtocol {
    
    func createWord(_ wordModel: WordResponse,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<WordResponse>>))
    
    func createWords(_ wordModels: [WordResponse],
                     storageType: MDStorageType,
                     _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<WordResponse>>))
    
    func readWord(fromWordID wordId: Int64,
                  storageType: MDStorageType,
                  _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<WordResponse>>))
    
    func readAllWords(storageType: MDStorageType,
                      _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<WordResponse>>))
    
    func updateWord(byWordID wordId: Int64,
                    newWordText: String,
                    newWordDescription: String,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>))
    
    func deleteWord(byWordId wordId: Int64,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>))
    
    func deleteAllWords(storageType: MDStorageType,
                        _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>))
    
}

final class MDWordStorage: MDStorage, MDWordStorageProtocol {
    
    fileprivate let memoryStorage: MDWordMemoryStorageProtocol
    fileprivate let coreDataStorage: MDWordCoreDataStorageProtocol
    
    init(memoryStorage: MDWordMemoryStorageProtocol,
         coreDataStorage: MDWordCoreDataStorageProtocol) {
        
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
extension MDWordStorage {
    
    func createWord(_ wordModel: WordResponse,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<WordResponse>>)) {
        
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
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<WordResponse>> = []
            
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
    
    func createWords(_ wordModels: [WordResponse],
                     storageType: MDStorageType,
                     _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<WordResponse>>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.createWords(wordModels) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.createWords(wordModels) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationsResultWithoutCompletion<WordResponse>> = []
            
            // Create in Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.createWords(wordModels) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Create in Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.createWords(wordModels) { result in
                
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
    
    func readWord(fromWordID wordId: Int64,
                  storageType: MDStorageType,
                  _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<WordResponse>>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.readWord(fromWordID: wordId) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.readWord(fromWordID: wordId) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<WordResponse>> = []
            
            // Read From Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.readWord(fromWordID: wordId) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
                
            }
            
            // Read From Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.readWord(fromWordID: wordId) { result in
                
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
    
    func readAllWords(storageType: MDStorageType,
                      _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<WordResponse>>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.readAllWords { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.readAllWords { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationsResultWithoutCompletion<WordResponse>> = []
            
            // Read From Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.readAllWords { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
                
            }
            
            // Read From Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.readAllWords { result in
                
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
    
    func updateWord(byWordID wordId: Int64,
                    newWordText: String,
                    newWordDescription: String,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.updateWord(byWordID: wordId,
                                     newWordText: newWordText,
                                     newWordDescription: newWordDescription) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.updateWord(byWordID: wordId,
                                       newWordText: newWordText,
                                       newWordDescription: newWordDescription) { (result) in
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
            memoryStorage.updateWord(byWordID: wordId,
                                     newWordText: newWordText,
                                     newWordDescription: newWordDescription) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
                
            }
            
            // Update In Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.updateWord(byWordID: wordId,
                                       newWordText: newWordText,
                                       newWordDescription: newWordDescription) { result in
                
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
    
    func deleteWord(byWordId wordId: Int64,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.deleteWord(byWordId: wordId) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.deleteWord(byWordId: wordId) { result in
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
            memoryStorage.deleteWord(byWordId: wordId) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Delete From Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.deleteWord(byWordId: wordId) { result in
                
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
    
    func deleteAllWords(storageType: MDStorageType,
                        _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.deleteAllWords { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.deleteAllWords { result in
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
            memoryStorage.deleteAllWords { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Delete From Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.deleteAllWords { result in
                
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
