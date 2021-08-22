//
//  MDMemoryStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.05.2021.
//

import Foundation

protocol MDWordMemoryStorageProtocol: MDCRUDWordProtocol,
                                      MDEntitiesIsEmptyProtocol,
                                      MDEntitiesCountProtocol {
    
}

final class MDWordMemoryStorage: MDWordMemoryStorageProtocol {
    
    fileprivate let operationQueueService: OperationQueueServiceProtocol
    
    var arrayWords: [WordEntity]
    
    init(operationQueueService: OperationQueueServiceProtocol,
         arrayWords: [WordEntity]) {
        
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
    
    func createWord(_ wordModel: WordEntity, _ completionHandler: @escaping(MDEntityResult<WordEntity>)) {
        let operation = MDCreateWordMemoryStorageOperation.init(wordStorage: self,
                                                                word: wordModel) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readWord(fromWordID wordId: Int64, _ completionHandler: @escaping(MDEntityResult<WordEntity>)) {
        let operation = MDReadWordMemoryStorageOperation.init(wordStorage: self, wordId: wordId) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readWords(fetchLimit: Int, fetchOffset: Int, _ completionHandler: @escaping (MDEntitiesResult<WordEntity>)) {
        completionHandler(.failure(MDEntityOperationError.cantFindEntity))
    }
    
    func readAllWords(_ completionHandler: @escaping (MDEntitiesResult<WordEntity>)) {
        completionHandler(.success(self.arrayWords))
    }
    
    func updateWord(byWordID wordId: Int64, newWordText: String, newWordDescription: String, _ completionHandler: @escaping(MDEntityResult<WordEntity>)) {
        let operation = MDUpdateWordMemoryStorageOperation.init(wordStorage: self,
                                                                wordId: wordId,
                                                                newWordText: newWordText,
                                                                newWordDescription: newWordDescription) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func deleteWord(_ word: WordEntity, _ completionHandler: @escaping(MDEntityResult<WordEntity>)) {
        let operation = MDDeleteWordMemoryStorageOperation.init(wordStorage: self, word: word) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}
