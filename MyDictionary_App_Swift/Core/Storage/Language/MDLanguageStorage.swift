//
//  MDLanguageStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDLanguageStorageProtocol {
    
    func entitiesIsEmpty(storageType: MDStorageType,
                         _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDEntitiesIsEmptyResultWithoutCompletion>))
    
    func entitiesCount(storageType: MDStorageType,
                       _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDEntitiesCountResultWithoutCompletion>))
    
    func createLanguages(storageType: MDStorageType,
                         languageEntities: [LanguageEntity],
                         _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDLanguageResultsWithoutCompletion>))
    
    func readAllLanguages(storageType: MDStorageType,
                          _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDLanguageResultsWithoutCompletion>))
    
    func deleteAllLanguages(storageType: MDStorageType,
                            _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDDeleteAllLanguagesResultsWithoutCompletion>))
    
}

typealias MDLanguageResultWithoutCompletion = (Result<LanguageEntity, Error>)
typealias MDLanguageResultsWithoutCompletion = (Result<[LanguageEntity], Error>)
typealias MDDeleteAllLanguagesResultsWithoutCompletion = (Result<Void, Error>)

final class MDLanguageStorage: MDLanguageStorageProtocol {
    
    fileprivate let memoryStorage: MDLanguageMemoryStorageProtocol
    fileprivate let coreDataStorage: MDLanguageCoreDataStorageProtocol
    
    init(memoryStorage: MDLanguageMemoryStorageProtocol,
         coreDataStorage: MDLanguageCoreDataStorageProtocol) {
        
        self.memoryStorage = memoryStorage
        self.coreDataStorage = coreDataStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Entities
extension MDLanguageStorage {
    
    func entitiesIsEmpty(storageType: MDStorageType,
                         _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDEntitiesIsEmptyResultWithoutCompletion>)) {
        
    }
    
    func entitiesCount(storageType: MDStorageType,
                       _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDEntitiesCountResultWithoutCompletion>)) {
        
    }
    
}

// MARK: - CRUD
extension MDLanguageStorage {       
    
    func createLanguages(storageType: MDStorageType,
                         languageEntities: [LanguageEntity],
                         _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDLanguageResultsWithoutCompletion>)) {
        
    }
    
    func readAllLanguages(storageType: MDStorageType,
                          _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDLanguageResultsWithoutCompletion>)) {
        
    }
    
    func deleteAllLanguages(storageType: MDStorageType, _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDDeleteAllLanguagesResultsWithoutCompletion>)) {
        
    }
    
}
