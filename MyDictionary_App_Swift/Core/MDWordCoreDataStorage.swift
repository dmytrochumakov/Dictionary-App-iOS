//
//  MDWordCoreDataStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation
import CoreData

protocol MDWordCoreDataStorageProtocol: MDCRUDWordProtocol {
    
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

// MARK: - Create
extension MDWordCoreDataStorage {
    
    func createWord(_ wordModel: WordModel, _ completionHandler: @escaping (MDCreateWordResult)) {
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
    
    func readWord(fromUUID uuid: UUID, _ completionHandler: @escaping (MDReadWordResult)) {
        let operation = MDReadWordCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                wordStorage: self,
                                                                uuid: uuid) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readWords(fetchLimit: Int, fetchOffset: Int, _ completionHandler: @escaping (MDReadWordsResult)) {
        let operation = MDReadWordsCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                 wordStorage: self,
                                                                 fetchLimit: fetchLimit,
                                                                 fetchOffset: fetchOffset) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}

// MARK: - Update
extension MDWordCoreDataStorage {
    
    func updateWord(byUUID uuid: UUID, word: String, wordDescription: String, _ completionHandler: @escaping (MDUpdateWordResult)) {
        let operation = MDUpdateWordCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                  wordStorage: self,
                                                                  uuid: uuid,
                                                                  word: word,
                                                                  wordDescription: wordDescription) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}

// MARK: - Delete
extension MDWordCoreDataStorage {
    
    func deleteWord(_ word: WordModel, _ completionHandler: @escaping (MDDeleteWordResult)) {
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
    
    func savePerform(uuid: UUID, completionHandler: @escaping MDCDResultSavedWord) {
        coreDataStack.savePerform() { [unowned self] (result) in
            switch result {
            case .success:
                self.readWord(fromUUID: uuid) { [unowned self] (result) in
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
    
    func save(uuid: UUID, completionHandler: @escaping MDCDResultSavedWord) {
        coreDataStack.savePerformAndWait() { [unowned self] (result) in
            switch result {
            case .success:
                self.readWord(fromUUID: uuid) { [unowned self] (result) in
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
