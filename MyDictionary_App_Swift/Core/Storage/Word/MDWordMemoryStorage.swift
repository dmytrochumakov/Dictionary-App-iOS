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
    
    var arrayWords: [WordModel]
    
    init(operationQueueService: OperationQueueServiceProtocol,
         arrayWords: [WordModel]) {
        
        self.operationQueueService = operationQueueService
        self.arrayWords = arrayWords
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDWordMemoryStorage {
    
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

// MARK: - CRUD
extension MDWordMemoryStorage {
    
    func createWord(_ wordModel: WordModel, _ completionHandler: @escaping(MDEntityResult<WordModel>)) {
        let operation = MDCreateWordMemoryStorageOperation.init(wordStorage: self,
                                                                word: wordModel) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readWord(fromID id: Int64, _ completionHandler: @escaping(MDEntityResult<WordModel>)) {
        let operation = MDReadWordMemoryStorageOperation.init(wordStorage: self, id: id) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readWords(fetchLimit: Int, fetchOffset: Int, _ completionHandler: @escaping (MDEntitiesResult<WordModel>)) {
        completionHandler(.failure(MDEntityOperationError.cantFindEntity))
    }
    
    func readAllWords(_ completionHandler: @escaping (MDEntitiesResult<WordModel>)) {
        completionHandler(.success(self.arrayWords))
    }
    
    func updateWord(byID id: Int64, word: String, word_description: String, _ completionHandler: @escaping(MDEntityResult<WordModel>)) {
        let operation = MDUpdateWordMemoryStorageOperation.init(wordStorage: self, id: id, word: word, word_description: word_description) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func deleteWord(_ word: WordModel, _ completionHandler: @escaping(MDEntityResult<WordModel>)) {
        let operation = MDDeleteWordMemoryStorageOperation.init(wordStorage: self, word: word) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}
