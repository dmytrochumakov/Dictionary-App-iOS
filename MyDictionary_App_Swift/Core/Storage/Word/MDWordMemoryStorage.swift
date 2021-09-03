//
//  MDMemoryStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.05.2021.
//

import Foundation

protocol MDWordMemoryStorageProtocol: MDCRUDWordProtocol,
                                      MDStorageInterface {
    
}

final class MDWordMemoryStorage: MDWordMemoryStorageProtocol {
    
    fileprivate let operationQueueService: OperationQueueServiceProtocol
    
    var arrayWords: [WordResponse]
    
    init(operationQueueService: OperationQueueServiceProtocol,
         arrayWords: [WordResponse]) {
        
        self.operationQueueService = operationQueueService
        self.arrayWords = arrayWords
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDWordMemoryStorage {
    
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

// MARK: - CRUD
extension MDWordMemoryStorage {
    
    func createWord(_ wordModel: WordResponse,
                    _ completionHandler: @escaping(MDOperationResultWithCompletion<WordResponse>)) {
        
        let operation = MDCreateWordMemoryStorageOperation.init(wordStorage: self,
                                                                word: wordModel) { result in
            completionHandler(result)
        }
        
        operationQueueService.enqueue(operation)
        
    }
    
    func createWords(_ wordModels: [WordResponse],
                     _ completionHandler: @escaping (MDOperationsResultWithCompletion<WordResponse>)) {
        
        let operation = MDCreateWordsMemoryStorageOperation.init(memoryStorage: self,
                                                                 words: wordModels) { result in
            completionHandler(result)
        }
        
        operationQueueService.enqueue(operation)
        
    }
    
    func readWord(fromWordID wordId: Int64,
                  _ completionHandler: @escaping(MDOperationResultWithCompletion<WordResponse>)) {
        
        let operation = MDReadWordMemoryStorageOperation.init(wordStorage: self, wordId: wordId) { result in
            completionHandler(result)
        }
        
        operationQueueService.enqueue(operation)
        
    }
    
    func readWords(fetchLimit: Int,
                   fetchOffset: Int,
                   _ completionHandler: @escaping (MDOperationsResultWithCompletion<WordResponse>)) {
        
        completionHandler(.failure(MDEntityOperationError.cantFindEntity))
        
    }
    
    func readAllWords(_ completionHandler: @escaping (MDOperationsResultWithCompletion<WordResponse>)) {
        
        let operation = MDReadAllWordsMemoryStorageOperation.init(memoryStorage: self) { result in
            completionHandler(result)
        }
        
        operationQueueService.enqueue(operation)
        
    }
    
    func updateWord(byWordID wordId: Int64,
                    newWordText: String,
                    newWordDescription: String,
                    _ completionHandler: @escaping(MDOperationResultWithCompletion<WordResponse>)) {
        
        let operation = MDUpdateWordMemoryStorageOperation.init(wordStorage: self,
                                                                wordId: wordId,
                                                                newWordText: newWordText,
                                                                newWordDescription: newWordDescription) { result in
            completionHandler(result)
        }
        
        operationQueueService.enqueue(operation)
        
    }
    
    func deleteWord(byWordId wordId: Int64,
                    _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        let operation = MDDeleteWordMemoryStorageOperation.init(wordStorage: self,
                                                                wordId: wordId) { result in
            completionHandler(result)
        }
        
        operationQueueService.enqueue(operation)
        
    }
    
    func deleteAllWords(_ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: MDDeleteAllWordsMemoryStorageOperation = .init(wordStorage: self) { result in
            completionHandler(result)
        }
        
        operationQueueService.enqueue(operation)
        
    }
    
}
