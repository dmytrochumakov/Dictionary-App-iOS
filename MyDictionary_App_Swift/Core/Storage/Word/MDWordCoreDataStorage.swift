//
//  MDWordCoreDataStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation
import CoreData

protocol MDWordCoreDataStorageProtocol: MDCRUDWordProtocol,
                                        MDStorageInterface {
    
}

final class MDWordCoreDataStorage: NSObject,
                                   MDWordCoreDataStorageProtocol {
    
    fileprivate let operationQueueService: OperationQueueServiceProtocol
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: CoreDataStack
    
    init(operationQueueService: OperationQueueServiceProtocol,
         managedObjectContext: NSManagedObjectContext,
         coreDataStack: CoreDataStack) {
        
        self.operationQueueService = operationQueueService
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDWordCoreDataStorage {
    
    func entitiesCount(_ completionHandler: @escaping (MDEntitiesCountResultWithCompletion)) {
        self.readAllWords() { result in
            switch result {
            case .success(let words):
                completionHandler(.success(words.count))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func entitiesIsEmpty(_ completionHandler: @escaping (MDEntitiesIsEmptyResultWithCompletion)) {
        self.readAllWords() { result in
            switch result {
            case .success(let words):
                completionHandler(.success(words.isEmpty))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}

// MARK: - Create
extension MDWordCoreDataStorage {
    
    func createWord(_ wordModel: WordResponse,
                    _ completionHandler: @escaping (MDEntityResult<WordResponse>)) {
        let operation = MDCreateWordCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                  wordStorage: self,
                                                                  word: wordModel) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}

// MARK: - Read
extension MDWordCoreDataStorage {
    
    func readWord(fromWordID wordId: Int64,
                  _ completionHandler: @escaping (MDEntityResult<WordResponse>)) {
        let operation = MDReadWordCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                wordStorage: self,
                                                                wordId: wordId) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readWords(fetchLimit: Int,
                   fetchOffset: Int,
                   _ completionHandler: @escaping (MDEntitiesResult<WordResponse>)) {
        let operation = MDReadWordsCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                 wordStorage: self,
                                                                 fetchLimit: fetchLimit,
                                                                 fetchOffset: fetchOffset) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readAllWords(_ completionHandler: @escaping (MDEntitiesResult<WordResponse>)) {
        let operation = MDReadWordsCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                 wordStorage: self,
                                                                 fetchLimit: .zero,
                                                                 fetchOffset: .zero) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}

// MARK: - Update
extension MDWordCoreDataStorage {
    
    func updateWord(byWordID wordId: Int64,
                    newWordText: String,
                    newWordDescription: String,
                    _ completionHandler: @escaping (MDEntityResult<WordResponse>)) {
        let operation = MDUpdateWordCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                  wordStorage: self,
                                                                  wordId: wordId,
                                                                  newWordText: newWordText,
                                                                  newWordDescription: newWordDescription) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}

// MARK: - Delete
extension MDWordCoreDataStorage {
    
    func deleteWord(_ word: WordResponse,
                    _ completionHandler: @escaping (MDEntityResult<WordResponse>)) {
        let operation = MDDeleteWordCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                  wordStorage: self,
                                                                  word: word) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func deleteAllWords(_ completionHandler: @escaping (MDEntityResult<Void>)) {
        let operation: MDDeleteAllWordsCoreDataStorageOperation = .init(managedObjectContext: self.managedObjectContext,
                                                                        coreDataStorage: self) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}

// MARK: - Save
extension MDWordCoreDataStorage {
    
    func savePerform(completionHandler: @escaping CDResultSaved) {
        coreDataStack.savePerform(completionHandler: completionHandler)
    }
    
    func savePerform(wordId: Int64, completionHandler: @escaping MDEntityResult<WordResponse>) {
        coreDataStack.savePerform() { [unowned self] (result) in
            switch result {
            case .success:
                self.readWord(fromWordID: wordId) { (result) in
                    switch result {
                    case .success(let wordModel):
                        completionHandler(.success(wordModel))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func save(wordId: Int64, completionHandler: @escaping MDEntityResult<WordResponse>) {
        coreDataStack.savePerformAndWait() { [unowned self] (result) in
            switch result {
            case .success:
                self.readWord(fromWordID: wordId) { (result) in
                    switch result {
                    case .success(let wordModel):
                        completionHandler(.success(wordModel))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
