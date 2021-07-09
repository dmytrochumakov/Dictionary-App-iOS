//
//  MDMemoryStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.05.2021.
//

import Foundation

protocol MDWordMemoryStorageProtocol: MDCRUDWordProtocol {
    
    var arrayWordsCount: Int { get }
    
}

final class MDWordMemoryStorage: MDWordMemoryStorageProtocol {
    
    fileprivate let operationQueueService: OperationQueueServiceProtocol
    
    var arrayWords: [WordModel]
    var arrayWordsCount: Int {
        return arrayWords.count
    }
    
    init(operationQueueService: OperationQueueServiceProtocol,
         arrayWords: [WordModel]) {
        
        self.operationQueueService = operationQueueService
        self.arrayWords = arrayWords
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - CRUD
extension MDWordMemoryStorage {
    
    func createWord(_ wordModel: WordModel, _ completionHandler: @escaping(MDCreateWordResult)) {
        let operation = MDCreateWordMemoryStorageOperation.init(wordStorage: self,
                                                                word: wordModel) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readWord(fromUUID uuid: UUID, _ completionHandler: @escaping(MDReadWordResult)) {
        let operation = MDReadWordMemoryStorageOperation.init(wordStorage: self, uuid: uuid) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readWords(fetchLimit: Int, fetchOffset: Int, _ completionHandler: @escaping (MDReadWordsResult)) {
        completionHandler(.success([]))
    }
    
    func updateWord(byUUID uuid: UUID, word: String, wordDescription: String, _ completionHandler: @escaping(MDUpdateWordResult)) {
        let operation = MDUpdateWordMemoryStorageOperation.init(wordStorage: self, uuid: uuid, word: word, wordDescription: wordDescription) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func deleteWord(_ word: WordModel, _ completionHandler: @escaping(MDDeleteWordResult)) {
        let operation = MDDeleteWordMemoryStorageOperation.init(wordStorage: self, word: word) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}
