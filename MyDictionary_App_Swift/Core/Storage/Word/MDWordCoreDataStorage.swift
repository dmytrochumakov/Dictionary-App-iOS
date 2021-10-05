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
    
    fileprivate let operationQueue: OperationQueue
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: MDCoreDataStack
    
    init(operationQueue: OperationQueue,
         managedObjectContext: NSManagedObjectContext,
         coreDataStack: MDCoreDataStack) {
        
        self.operationQueue = operationQueue
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
                    _ completionHandler: @escaping (MDOperationResultWithCompletion<WordResponse>)) {
        let operation = MDCreateWordCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                  coreDataStack: self.coreDataStack,
                                                                  wordStorage: self,
                                                                  word: wordModel) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
    func createWords(_ wordModels: [WordResponse],
                     _ completionHandler: @escaping (MDOperationsResultWithCompletion<WordResponse>)) {
        let operation = MDCreateWordsCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                   coreDataStack: self.coreDataStack,
                                                                   coreDataStorage: self,
                                                                   words: wordModels) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
}

// MARK: - Read
extension MDWordCoreDataStorage {
    
    func readWord(fromWordID wordId: Int64,
                  _ completionHandler: @escaping (MDOperationResultWithCompletion<WordResponse>)) {
        let operation = MDReadWordCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                wordStorage: self,
                                                                wordId: wordId) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
    func readWords(fetchLimit: Int,
                   fetchOffset: Int,
                   _ completionHandler: @escaping (MDOperationsResultWithCompletion<WordResponse>)) {
        let operation = MDReadWordsCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                 wordStorage: self,
                                                                 fetchLimit: fetchLimit,
                                                                 fetchOffset: fetchOffset) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
    func readAllWords(_ completionHandler: @escaping (MDOperationsResultWithCompletion<WordResponse>)) {
        let operation = MDReadWordsCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                 wordStorage: self,
                                                                 fetchLimit: .zero,
                                                                 fetchOffset: .zero) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
    func readAllWords(byCourseID courseID: Int64,
                      _ completionHandler: @escaping (MDOperationsResultWithCompletion<WordResponse>)) {
        let operation = MDReadAllWordsByCourseIDCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                              wordStorage: self,
                                                                              courseId: courseID) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
}

// MARK: - Update
extension MDWordCoreDataStorage {
    
    func updateWord(byWordID wordId: Int64,
                    newWordText: String,
                    newWordDescription: String,
                    _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation = MDUpdateWordCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                  wordStorage: self,
                                                                  coreDataStack: self.coreDataStack,
                                                                  wordId: wordId,
                                                                  newWordText: newWordText,
                                                                  newWordDescription: newWordDescription) { result in
            completionHandler(result)
        }
        
        operationQueue.addOperation(operation)
        
    }
    
}

// MARK: - Delete
extension MDWordCoreDataStorage {
    
    func deleteWord(byWordId wordId: Int64,
                    _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        let operation = MDDeleteWordCoreDataStorageOperation.init(managedObjectContext: self.managedObjectContext,
                                                                  coreDataStack: self.coreDataStack,
                                                                  wordStorage: self,
                                                                  wordId: wordId) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
    func deleteAllWords(byCourseId courseId: Int64,
                        _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        let operation: MDDeleteAllWordsByCourseIdCoreDataStorageOperation = .init(managedObjectContext: self.managedObjectContext,
                                                                                  coreDataStack: self.coreDataStack,
                                                                                  coreDataStorage: self,
                                                                                  courseId: courseId) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
    func deleteAllWords(_ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        let operation: MDDeleteAllWordsCoreDataStorageOperation = .init(managedObjectContext: self.managedObjectContext,
                                                                        coreDataStack: self.coreDataStack,
                                                                        coreDataStorage: self) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
}
