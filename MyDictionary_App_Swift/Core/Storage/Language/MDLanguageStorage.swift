//
//  MDLanguageStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDLanguageStorageProtocol: MDStorageProtocol {
    
    var memoryStorage: MDLanguageMemoryStorageProtocol { get }
    
    func createLanguages(storageType: MDStorageType,
                         languageEntities: [LanguageResponse],
                         _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<LanguageResponse>>))
    
    func readAllLanguages(storageType: MDStorageType,
                          _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<LanguageResponse>>))
    
    func deleteAllLanguages(storageType: MDStorageType,
                            _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>))
    
}

final class MDLanguageStorage: MDStorage, MDLanguageStorageProtocol {
    
    let memoryStorage: MDLanguageMemoryStorageProtocol
    fileprivate let coreDataStorage: MDLanguageCoreDataStorageProtocol
    fileprivate let operationQueue: OperationQueue
    
    init(memoryStorage: MDLanguageMemoryStorageProtocol,
         coreDataStorage: MDLanguageCoreDataStorageProtocol,
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
extension MDLanguageStorage {       
    
    func createLanguages(storageType: MDStorageType,
                         languageEntities: [LanguageResponse],
                         _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<LanguageResponse>>)) {
        
        switch storageType {
            
        case .memory:
            
            let operation: BlockOperation = .init {
                //
                self.memoryStorage.createLanguages(languageEntities) { result in
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
                self.coreDataStorage.createLanguages(languageEntities) { result in
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
                var finalResult: MDStorageResultsWithoutCompletion<MDOperationsResultWithoutCompletion<LanguageResponse>> = []
                
                // Create in Memory
                self.memoryStorage.createLanguages(languageEntities) { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .memory, result: result))
                    
                    // Pass Final Result If Needed
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    
                }
                
                // Create in Core Data
                self.coreDataStorage.createLanguages(languageEntities) { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .coreData, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    
                }
                
            }
            
            // Add Operation
            operationQueue.addOperation(operation)
            //
            break
            //
            
        }
        
    }
    
    func readAllLanguages(storageType: MDStorageType,
                          _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<LanguageResponse>>)) {
        
        switch storageType {
            
        case .memory:
            
            let operation: BlockOperation = .init {
                //
                self.memoryStorage.readAllLanguages { result in
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
                self.coreDataStorage.readAllLanguages { result in
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
                var finalResult: MDStorageResultsWithoutCompletion<MDOperationsResultWithoutCompletion<LanguageResponse>> = []
                
                // Read From Memory
                self.memoryStorage.readAllLanguages { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .memory, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                }
                
                // Read From Core Data
                self.coreDataStorage.readAllLanguages { result in
                    
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
    
    func deleteAllLanguages(storageType: MDStorageType,
                            _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
            
        case .memory:
            
            let operation: BlockOperation = .init {
                //
                self.memoryStorage.deleteAllLanguages { result in
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
                self.coreDataStorage.deleteAllLanguages { result in
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
                self.memoryStorage.deleteAllLanguages { result in
                    
                    // Append Result
                    finalResult.append(.init(storageType: .memory, result: result))
                    
                    // Pass Final Result If Needed
                    if (finalResult.count == countNeeded) {
                        completionHandler(finalResult)
                    }
                    //
                    
                }
                
                // Delete From Core Data
                self.coreDataStorage.deleteAllLanguages { result in
                    
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
