//
//  MDLanguageMemoryStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDLanguageMemoryStorageProtocol: MDCRUDLanguageProtocol,
                                          MDEntitiesCountProtocol,
                                          MDEntitiesIsEmptyProtocol {
    
}

final class MDLanguageMemoryStorage: MDLanguageMemoryStorageProtocol {
    
    fileprivate let operationQueueService: OperationQueueServiceProtocol
    
    var array: [LanguageEntity]
    
    init(operationQueueService: OperationQueueServiceProtocol,
         array: [LanguageEntity]) {
        
        self.operationQueueService = operationQueueService
        self.array = array
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Entities
extension MDLanguageMemoryStorage {
    
    func entitiesCount(_ completionHandler: @escaping (MDEntitiesCountResultWithCompletion)) {
        
    }
    
    func entitiesIsEmpty(_ completionHandler: @escaping (MDEntitiesIsEmptyResultWithCompletion)) {
        
    }
    
}

// MARK: - CRUD
extension MDLanguageMemoryStorage {
    
    func createLanguages(_ languageEntities: [LanguageEntity], _ completionHandler: @escaping (MDEntityResult<[LanguageEntity]>)) {
        let operation: MDCreateLanguagesMemoryStorageOperation = .init(memoryStorage: self,
                                                                       languageEntities: languageEntities) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readAllLanguages(_ completionHandler: @escaping (MDEntityResult<[LanguageEntity]>)) {
        let operation: MDReadAllLanguagesMemoryStorageOperation = .init(memoryStorage: self) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func deleteAllLanguages(_ completionHandler: @escaping (MDEntityResult<Void>)) {
        
    }
    
}
