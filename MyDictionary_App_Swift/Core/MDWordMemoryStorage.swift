//
//  MDMemoryStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.05.2021.
//

import Foundation

protocol MDWordMemoryStorageProtocol: MDWordStorageProtocol {
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
        
    }
    
    func updateWord(_ word: WordModel, _ completionHandler: @escaping(MDUpdateWordResult)) {
        
    }
    
    func deleteWord(_ word: WordModel, _ completionHandler: @escaping(MDDeleteWordResult)) {
        
    }
    
}
