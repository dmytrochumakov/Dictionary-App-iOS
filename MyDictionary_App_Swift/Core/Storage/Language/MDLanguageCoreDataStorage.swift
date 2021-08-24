//
//  MDLanguageCoreDataStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation
import CoreData

protocol MDLanguageCoreDataStorageProtocol: MDCRUDLanguageProtocol,
                                            MDStorageInterface {
    
}

final class MDLanguageCoreDataStorage: MDLanguageCoreDataStorageProtocol {
    
    fileprivate let operationQueueService: OperationQueueServiceProtocol
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: CoreDataStack
    
    init(operationQueueService: OperationQueueServiceProtocol,
         managedObjectContext: NSManagedObjectContext,
         coreDataStack: CoreDataStack) {
        
        self.operationQueueService = operationQueueService
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Entities
extension MDLanguageCoreDataStorage {
    
    func entitiesCount(_ completionHandler: @escaping(MDEntitiesCountResultWithCompletion)) {
        self.readAllLanguages { result in
            switch result {
            case .success(let entities):
                completionHandler(.success(entities.count))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func entitiesIsEmpty(_ completionHandler: @escaping(MDEntitiesIsEmptyResultWithCompletion)) {
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
extension MDLanguageCoreDataStorage {
    
    func createLanguages(_ languageEntities: [LanguageEntity], _ completionHandler: @escaping(MDEntityResult<[LanguageEntity]>)) {
        let operation: MDCreateLanguagesCoreDataStorageOperation = .init(managedObjectContext: self.managedObjectContext,
                                                                         coreDataStorage: self,
                                                                         languageEntities: languageEntities) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readLanguage(fromLanguageID languageID: Int64, _ completionHandler: @escaping(MDEntityResult<LanguageEntity>)) {
        let operation: MDReadLanguageCoreDataStorageOperation = .init(managedObjectContext: self.managedObjectContext,
                                                                      coreDataStorage: self,
                                                                      languageId: languageID) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readAllLanguages(_ completionHandler: @escaping(MDEntityResult<[LanguageEntity]>)) {
        let operation: MDReadAllLanguagesCoreDataStorageOperation = .init(managedObjectContext: self.managedObjectContext,
                                                                          coreDataStorage: self) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func deleteAllLanguages(_ completionHandler: @escaping(MDEntityResult<Void>)) {
        let operation: MDDeleteAllLanguagesCoreDataStorageOperation = .init(managedObjectContext: self.managedObjectContext,
                                                                            coreDataStorage: self) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}

// MARK: - Save
extension MDLanguageCoreDataStorage {
    
    func savePerform(completionHandler: @escaping CDResultSaved) {
        coreDataStack.savePerform(completionHandler: completionHandler)
    }
    
    func savePerform(languageID: Int64, completionHandler: @escaping(MDEntityResult<LanguageEntity>)) {
        coreDataStack.savePerform() { [unowned self] (result) in
            switch result {
            case .success:
                self.readLanguage(fromLanguageID: languageID) { (result) in
                    switch result {
                    case .success(let languageEntity):
                        completionHandler(.success(languageEntity))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func save(languageID: Int64, completionHandler: @escaping(MDEntityResult<LanguageEntity>)) {
        coreDataStack.savePerformAndWait() { [unowned self] (result) in
            switch result {
            case .success:
                self.readLanguage(fromLanguageID: languageID) { (result) in
                    switch result {
                    case .success(let languageEntity):
                        completionHandler(.success(languageEntity))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
