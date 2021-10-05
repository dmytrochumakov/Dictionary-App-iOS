//
//  MDWordStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.05.2021.
//

import Foundation

protocol MDWordStorageProtocol: MDStorageProtocol {
    
    var memoryStorage: MDWordMemoryStorageProtocol { get }
    
    func createWord(_ wordModel: WordResponse,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<WordResponse>>))
    
    func createWords(_ wordModels: [WordResponse],
                     storageType: MDStorageType,
                     _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<WordResponse>>))
    
    func readWord(fromWordID wordId: Int64,
                  storageType: MDStorageType,
                  _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<WordResponse>>))
    
    func readAllWords(byCourseID courseID: Int64,
                      storageType: MDStorageType,
                      _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<WordResponse>>))
    
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
    
    func deleteAllWords(byCourseId courseId: Int64,
                        storageType: MDStorageType,
                        _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>))
    
    func deleteAllWords(storageType: MDStorageType,
                        _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>))
    
}

final class MDWordStorage: MDStorage, MDWordStorageProtocol {
    
    let memoryStorage: MDWordMemoryStorageProtocol
    fileprivate let coreDataStorage: MDWordCoreDataStorageProtocol
    fileprivate let operationQueue: OperationQueue
    
    init(memoryStorage: MDWordMemoryStorageProtocol,
         coreDataStorage: MDWordCoreDataStorageProtocol,
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
extension MDWordStorage {
    
    func createWord(_ wordModel: WordResponse,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<WordResponse>>)) {
        
        switch storageType {
            
        case .memory:
            
            let operation: BlockOperation = .init {
                //
                self.memoryStorage.createWord(wordModel) { result in
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
                self.coreDataStorage.createWord(wordModel) { result in
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
                var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<WordResponse>> = []
                
                // Create in Memory
                self.memoryStorage.createWord(wordModel) { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .memory, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    
                }
                
                // Create in Core Data
                self.coreDataStorage.createWord(wordModel) { result in
                    
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
    
    func createWords(_ wordModels: [WordResponse],
                     storageType: MDStorageType,
                     _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<WordResponse>>)) {
        
        switch storageType {
            
        case .memory:
            
            let operation: BlockOperation = .init {
                //
                self.memoryStorage.createWords(wordModels) { result in
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
                self.coreDataStorage.createWords(wordModels) { result in
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
                var finalResult: MDStorageResultsWithoutCompletion<MDOperationsResultWithoutCompletion<WordResponse>> = []
                
                // Create in Memory
                self.memoryStorage.createWords(wordModels) { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .memory, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                }
                
                // Create in Core Data
                self.coreDataStorage.createWords(wordModels) { result in
                    
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
    
    func readWord(fromWordID wordId: Int64,
                  storageType: MDStorageType,
                  _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<WordResponse>>)) {
        
        switch storageType {
            
        case .memory:
            
            let operation: BlockOperation = .init {
                //
                self.memoryStorage.readWord(fromWordID: wordId) { (result) in
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
                self.coreDataStorage.readWord(fromWordID: wordId) { (result) in
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
                var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<WordResponse>> = []
                
                // Read From Memory
                self.memoryStorage.readWord(fromWordID: wordId) { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .memory, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                    
                }
                
                // Read From Core Data
                self.coreDataStorage.readWord(fromWordID: wordId) { result in
                    
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
    
    func readAllWords(storageType: MDStorageType,
                      _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<WordResponse>>)) {
        
        switch storageType {
            
        case .memory:
            
            let operation: BlockOperation = .init {
                //
                self.memoryStorage.readAllWords { (result) in
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
                self.coreDataStorage.readAllWords { (result) in
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
                var finalResult: MDStorageResultsWithoutCompletion<MDOperationsResultWithoutCompletion<WordResponse>> = []
                
                // Read From Memory
                self.memoryStorage.readAllWords { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .memory, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                    
                }
                
                // Read From Core Data
                self.coreDataStorage.readAllWords { result in
                    
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
    
    func readAllWords(byCourseID courseID: Int64,
                      storageType: MDStorageType,
                      _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<WordResponse>>)) {
        
        switch storageType {
            
        case .memory:
            
            let operation: BlockOperation = .init {
                //
                self.memoryStorage.readAllWords(byCourseID: courseID) { (result) in
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
                self.coreDataStorage.readAllWords(byCourseID: courseID) { (result) in
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
                var finalResult: MDStorageResultsWithoutCompletion<MDOperationsResultWithoutCompletion<WordResponse>> = []
                
                // Read From Memory
                self.memoryStorage.readAllWords(byCourseID: courseID) { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .memory, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                }
                
                // Read From Core Data
                self.coreDataStorage.readAllWords(byCourseID: courseID) { result in
                    
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
    
    func updateWord(byWordID wordId: Int64,
                    newWordText: String,
                    newWordDescription: String,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
            
        case .memory:
            
            let operation: BlockOperation = .init {
                //
                self.memoryStorage.updateWord(byWordID: wordId,
                                              newWordText: newWordText,
                                              newWordDescription: newWordDescription) { (result) in
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
                self.coreDataStorage.updateWord(byWordID: wordId,
                                                newWordText: newWordText,
                                                newWordDescription: newWordDescription) { (result) in
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
                self.memoryStorage.updateWord(byWordID: wordId,
                                              newWordText: newWordText,
                                              newWordDescription: newWordDescription) { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .memory, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                    
                }
                
                // Update In Core Data
                self.coreDataStorage.updateWord(byWordID: wordId,
                                                newWordText: newWordText,
                                                newWordDescription: newWordDescription) { result in
                    
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
    
    func deleteWord(byWordId wordId: Int64,
                    storageType: MDStorageType,
                    _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
            
        case .memory:
            
            let operation: BlockOperation = .init {
                //
                self.memoryStorage.deleteWord(byWordId: wordId) { result in
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
                self.coreDataStorage.deleteWord(byWordId: wordId) { result in
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
                self.memoryStorage.deleteWord(byWordId: wordId) { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .memory, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                }
                
                // Delete From Core Data
                self.coreDataStorage.deleteWord(byWordId: wordId) { result in
                    
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
    
    func deleteAllWords(byCourseId courseId: Int64,
                        storageType: MDStorageType,
                        _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
            
        case .memory:
            
            let operation: BlockOperation = .init {
                //
                self.memoryStorage.deleteAllWords(byCourseId: courseId) { result in
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
                self.coreDataStorage.deleteAllWords(byCourseId: courseId) { result in
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
                self.memoryStorage.deleteAllWords(byCourseId: courseId) { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .memory, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                }
                
                // Delete From Core Data
                self.coreDataStorage.deleteAllWords(byCourseId: courseId) { result in
                    
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
    
    func deleteAllWords(storageType: MDStorageType,
                        _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
            
        case .memory:
            
            let operation: BlockOperation = .init {
                //
                self.memoryStorage.deleteAllWords { result in
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
                self.coreDataStorage.deleteAllWords { result in
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
                self.memoryStorage.deleteAllWords { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .memory, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                }
                
                // Delete From Core Data
                self.coreDataStorage.deleteAllWords { result in
                    
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
