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
    
    fileprivate let operationQueue: OperationQueue
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: MDCoreDataStack
    
    init(operationQueue: OperationQueue,
         managedObjectContext: NSManagedObjectContext,
         coreDataStack: MDCoreDataStack) {
        
        self.operationQueue = operationQueue
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
    
    func createLanguages(_ languageEntities: [LanguageResponse], _ completionHandler: @escaping(MDOperationResultWithCompletion<[LanguageResponse]>)) {
        let operation: MDCreateLanguagesCoreDataStorageOperation = .init(managedObjectContext: self.managedObjectContext,
                                                                         coreDataStack: self.coreDataStack,
                                                                         coreDataStorage: self,
                                                                         languageEntities: languageEntities) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
    func readLanguage(fromLanguageID languageID: Int64, _ completionHandler: @escaping(MDOperationResultWithCompletion<LanguageResponse>)) {
        let operation: MDReadLanguageCoreDataStorageOperation = .init(managedObjectContext: self.managedObjectContext,
                                                                      coreDataStorage: self,
                                                                      languageId: languageID) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
    func readAllLanguages(_ completionHandler: @escaping(MDOperationResultWithCompletion<[LanguageResponse]>)) {
        let operation: MDReadAllLanguagesCoreDataStorageOperation = .init(managedObjectContext: self.managedObjectContext,
                                                                          coreDataStorage: self) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
    func deleteAllLanguages(_ completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        let operation: MDDeleteAllLanguagesCoreDataStorageOperation = .init(managedObjectContext: self.managedObjectContext,
                                                                            coreDataStack: self.coreDataStack,
                                                                            coreDataStorage: self) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
}
