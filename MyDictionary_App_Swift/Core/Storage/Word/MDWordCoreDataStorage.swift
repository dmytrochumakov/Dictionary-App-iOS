//
//  MDWordCoreDataStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation
import CoreData

protocol MDWordCoreDataStorageProtocol: MDCRUDWordProtocol,
                                        MDEntitiesIsEmptyProtocol,
                                        MDEntitiesCountProtocol {
    
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
        self.readAllWords() { [unowned self] result in
            switch result {
            case .success(let words):
                completionHandler(.success(words.count))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func entitiesIsEmpty(_ completionHandler: @escaping (MDEntitiesIsEmptyResultWithCompletion)) {
        self.readAllWords() { [unowned self] result in
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
    
    func createWord(_ wordModel: WordModel, _ completionHandler: @escaping (MDEntityResult<WordModel>)) {
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
    
    func readWord(fromID id: Int64, _ completionHandler: @escaping (MDEntityResult<WordModel>)) {
        let operation = MDReadWordCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                wordStorage: self,
                                                                id: id) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readWords(fetchLimit: Int, fetchOffset: Int, _ completionHandler: @escaping (MDEntitiesResult<WordModel>)) {
        let operation = MDReadWordsCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                 wordStorage: self,
                                                                 fetchLimit: fetchLimit,
                                                                 fetchOffset: fetchOffset) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readAllWords(_ completionHandler: @escaping (MDEntitiesResult<WordModel>)) {
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
    
    func updateWord(byID id: Int64, word: String, word_description: String, _ completionHandler: @escaping (MDEntityResult<WordModel>)) {
        let operation = MDUpdateWordCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                  wordStorage: self,
                                                                  id: id,
                                                                  word: word,
                                                                  word_description: word_description) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}

// MARK: - Delete
extension MDWordCoreDataStorage {
    
    func deleteWord(_ word: WordModel, _ completionHandler: @escaping (MDEntityResult<WordModel>)) {
        let operation = MDDeleteWordCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                  wordStorage: self,
                                                                  word: word) { result in
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
    
    func savePerform(id: Int64, completionHandler: @escaping MDEntityResult<WordModel>) {
        coreDataStack.savePerform() { [unowned self] (result) in
            switch result {
            case .success:
                self.readWord(fromID: id) { [unowned self] (result) in
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
    
    func save(id: Int64, completionHandler: @escaping MDEntityResult<WordModel>) {
        coreDataStack.savePerformAndWait() { [unowned self] (result) in
            switch result {
            case .success:
                self.readWord(fromID: id) { [unowned self] (result) in
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
