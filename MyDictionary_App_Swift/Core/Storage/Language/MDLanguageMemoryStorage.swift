//
//  MDLanguageMemoryStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDLanguageMemoryStorageProtocol: MDCRUDLanguageProtocol,
                                          MDStorageInterface {
    
}

final class MDLanguageMemoryStorage: MDLanguageMemoryStorageProtocol {
    
    fileprivate let operationQueue: OperationQueue
    
    var array: [LanguageResponse]
    
    init(operationQueue: OperationQueue,
         array: [LanguageResponse]) {
        
        self.operationQueue = operationQueue
        self.array = array
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Entities
extension MDLanguageMemoryStorage {
    
    func entitiesCount(_ completionHandler: @escaping (MDEntitiesCountResultWithCompletion)) {
        self.readAllLanguages { result in
            switch result {
            case .success(let entities):
                completionHandler(.success(entities.count))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func entitiesIsEmpty(_ completionHandler: @escaping (MDEntitiesIsEmptyResultWithCompletion)) {
        self.readAllLanguages { result in
            switch result {
            case .success(let entities):
                completionHandler(.success(entities.isEmpty))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}

// MARK: - CRUD
extension MDLanguageMemoryStorage {
    
    func createLanguages(_ languageEntities: [LanguageResponse], _ completionHandler: @escaping (MDOperationResultWithCompletion<[LanguageResponse]>)) {
        let operation: MDCreateLanguagesMemoryStorageOperation = .init(memoryStorage: self,
                                                                       languageEntities: languageEntities) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
    func readAllLanguages(_ completionHandler: @escaping (MDOperationResultWithCompletion<[LanguageResponse]>)) {
        let operation: MDReadAllLanguagesMemoryStorageOperation = .init(memoryStorage: self) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
    func deleteAllLanguages(_ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        let operation: MDDeleteAllLanguagesMemoryStorageOperation = .init(memoryStorage: self) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
}
