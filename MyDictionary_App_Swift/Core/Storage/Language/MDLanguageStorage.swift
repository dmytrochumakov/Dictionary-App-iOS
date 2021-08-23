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
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.entitiesIsEmpty { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.entitiesIsEmpty { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        default:
            
            break
            
        }
        
    }
    
    func entitiesCount(storageType: MDStorageType,
                       _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDEntitiesCountResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.entitiesCount { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.entitiesCount { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        default:
            
            break
            
        }
        
    }
    
}

// MARK: - CRUD
extension MDLanguageStorage {       
    
    func createLanguages(storageType: MDStorageType,
                         languageEntities: [LanguageEntity],
                         _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDLanguageResultsWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.createLanguages(languageEntities) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.createLanguages(languageEntities) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        default:
            
            break
            
        }
        
    }
    
    func readAllLanguages(storageType: MDStorageType,
                          _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDLanguageResultsWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.readAllLanguages { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
            
        case .coreData:
            
            coreDataStorage.readAllLanguages { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        default:
            
            break
            
        }
        
    }
    
    func deleteAllLanguages(storageType: MDStorageType,
                            _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDDeleteAllLanguagesResultsWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.deleteAllLanguages { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.deleteAllLanguages { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        default:
            
            break
            
        }
        
    }
    
}
