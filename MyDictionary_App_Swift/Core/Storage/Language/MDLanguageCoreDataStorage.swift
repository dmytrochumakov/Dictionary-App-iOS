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

// MARK: - Create
extension MDLanguageCoreDataStorage {
    
    func createLanguages(_ languageEntities: [LanguageResponse],
                         _ completionHandler: @escaping(MDOperationResultWithCompletion<[LanguageResponse]>)) {
        
        let operation: BlockOperation = .init {
            
            if (languageEntities.isEmpty) {
                
                completionHandler(.success(languageEntities))
                return
                
            } else {
                
                var resultCount: Int = .zero
                
                languageEntities.forEach { languageEntity in
                    
                    let _ = CDLanguageResponseEntity.init(languageResponse: languageEntity,
                                                          insertIntoManagedObjectContext: self.managedObjectContext)
                    
                    self.coreDataStack.save(managedObjectContext: self.managedObjectContext) { result in
                        
                        switch result {
                            
                        case .success:
                            
                            //
                            resultCount += 1
                            //
                            
                            if (resultCount == languageEntities.count) {
                                completionHandler(.success(languageEntities))
                            }
                            
                            //
                            break
                            //
                            
                        case .failure(let error):
                            
                            //
                            completionHandler(.failure(error))
                            //
                            
                            //
                            break
                            //
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}

// MARK: - Read
extension MDLanguageCoreDataStorage {
    
    func readLanguage(fromLanguageID languageID: Int64,
                      _ completionHandler: @escaping(MDOperationResultWithCompletion<LanguageResponse>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<CDLanguageResponseEntity>(entityName: CoreDataEntityName.CDLanguageResponseEntity)
            fetchRequest.predicate = NSPredicate(format: "\(CDLanguageResponseEntityAttributeName.languageId) == %i", languageID)
            
            do {
                if let result = try self.managedObjectContext.fetch(fetchRequest).map({ $0.languageResponse }).first {
                    completionHandler(.success(result))
                    return
                } else {
                    completionHandler(.failure(MDEntityOperationError.cantFindEntity))
                    return
                }
            } catch {
                completionHandler(.failure(error))
                return
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func readAllLanguages(_ completionHandler: @escaping(MDOperationResultWithCompletion<[LanguageResponse]>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<CDLanguageResponseEntity>(entityName: CoreDataEntityName.CDLanguageResponseEntity)
            
            do {
                completionHandler(.success(try self.managedObjectContext.fetch(fetchRequest).map({ $0.languageResponse })))
                return
            } catch {
                completionHandler(.failure(error))
                return
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}

// MARK: - Delete
extension MDLanguageCoreDataStorage {
    
    func deleteAllLanguages(_ completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.CDLanguageResponseEntity)
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                
                try self.managedObjectContext.execute(batchDeleteRequest)
                
                self.coreDataStack.save(managedObjectContext: self.managedObjectContext) { result in
                    
                    switch result {
                        
                    case .success:
                        
                        //
                        completionHandler(.success(()))
                        //
                        
                        //
                        break
                        //
                        
                    case .failure(let error):
                        
                        //
                        completionHandler(.failure(error))
                        //
                        
                        //
                        break
                        //
                        
                    }
                    
                }
                
            } catch {
                completionHandler(.failure(error))
                return
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}
