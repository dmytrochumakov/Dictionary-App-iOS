//
//  MDWordCoreDataStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation
import CoreData

protocol MDWordCoreDataStorageProtocol: MDCRUDWordProtocol,
                                        MDStorageInterface {
    
}

final class MDWordCoreDataStorage: NSObject,
                                   MDWordCoreDataStorageProtocol {
    
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
extension MDWordCoreDataStorage {
    
    func entitiesCount(_ completionHandler: @escaping (MDEntitiesCountResultWithCompletion)) {
        self.readAllWords() { result in
            switch result {
            case .success(let words):
                completionHandler(.success(words.count))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func entitiesIsEmpty(_ completionHandler: @escaping (MDEntitiesIsEmptyResultWithCompletion)) {
        self.readAllWords() { result in
            switch result {
            case .success(let words):
                completionHandler(.success(words.isEmpty))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}

// MARK: - Create
extension MDWordCoreDataStorage {
    
    func createWord(wordText: String,
                    wordDescription: String,
                    course: CDCourseEntity,
                    _ completionHandler: @escaping (MDOperationResultWithCompletion<CDWordEntity>)) {
        
        let operation: BlockOperation = .init {
            
            let newWord = CDWordEntity.cdWordEntity(context: self.managedObjectContext,
                                                    uuid: .init(),
                                                    wordText: wordText,
                                                    wordDescription: wordDescription,
                                                    createdAt: .init(),
                                                    updatedAt: .init(),
                                                    course: course)
            
            self.coreDataStack.save(managedObjectContext: self.managedObjectContext) { result in
                
                switch result {
                    
                case .success:
                    
                    //
                    completionHandler(.success((newWord)))
                    
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
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}

// MARK: - Read
extension MDWordCoreDataStorage {
    
    func readWord(byWordUUID uuid: UUID,
                  _ completionHandler: @escaping (MDOperationResultWithCompletion<CDWordEntity>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<CDWordEntity>(entityName: MDCoreDataEntityName.CDWordEntity)
            fetchRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.uuid) == %@", uuid.uuidString)
            
            let asyncFetchRequest = NSAsynchronousFetchRequest.init(fetchRequest: fetchRequest) { asynchronousFetchResult in
                
                guard let result = asynchronousFetchResult.finalResult?.first else {
                    
                    //
                    completionHandler(.failure(MDEntityOperationError.cantFindEntity))
                    //
                    
                    //
                    return
                    //
                    
                }
                
                //
                completionHandler(.success(result))
                //
                
                //
                return
                //
                
            }
            
            do {
                
                try self.managedObjectContext.execute(asyncFetchRequest)
                
            } catch {
                
                //
                completionHandler(.failure(error))
                //
                
                //
                return
                //
                
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func readWords(byCourseUUID uuid: UUID,
                   fetchLimit: Int,
                   fetchOffset: Int,
                   _ completionHandler: @escaping (MDOperationsResultWithCompletion<CDWordEntity>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<CDWordEntity>(entityName: MDCoreDataEntityName.CDWordEntity)
            
            fetchRequest.predicate = NSPredicate(format: "\(CDCourseEntityAttributeName.uuid) == %@", uuid.uuidString)
            fetchRequest.fetchLimit = fetchLimit
            fetchRequest.fetchOffset = fetchOffset
            
            let asyncFetchRequest = NSAsynchronousFetchRequest.init(fetchRequest: fetchRequest) { asynchronousFetchResult in
                
                guard let result = asynchronousFetchResult.finalResult else {
                    
                    //
                    completionHandler(.failure(MDEntityOperationError.cantFindEntity))
                    //
                    
                    //
                    return
                    //
                    
                }
                
                //
                completionHandler(.success(result))
                //
                
                //
                return
                //
                
            }
            
            do {
                
                //
                try self.managedObjectContext.execute(asyncFetchRequest)
                //
                
            } catch {
                
                //
                completionHandler(.failure(error))
                //
                
                //
                return
                //
                
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func readWords(fetchLimit: Int,
                   fetchOffset: Int,
                   _ completionHandler: @escaping (MDOperationsResultWithCompletion<CDWordEntity>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<CDWordEntity>(entityName: MDCoreDataEntityName.CDWordEntity)
            
            fetchRequest.fetchLimit = fetchLimit
            fetchRequest.fetchOffset = fetchOffset
            
            let asyncFetchRequest = NSAsynchronousFetchRequest.init(fetchRequest: fetchRequest) { asynchronousFetchResult in
                
                guard let result = asynchronousFetchResult.finalResult else {
                    
                    //
                    completionHandler(.failure(MDEntityOperationError.cantFindEntity))
                    //
                    
                    //
                    return
                    //
                    
                }
                
                //
                completionHandler(.success(result))
                //
                
                //
                return
                //
                
            }
            
            do {
                
                //
                try self.managedObjectContext.execute(asyncFetchRequest)
                //
                
            } catch {
                
                //
                completionHandler(.failure(error))
                //
                
                //
                return
                //
                
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func readAllWords(_ completionHandler: @escaping (MDOperationsResultWithCompletion<CDWordEntity>)) {
        readWords(fetchLimit: .zero, fetchOffset: .zero, completionHandler)
    }
    
    func readAllWords(byCourseUUID uuid: UUID,
                      _ completionHandler: @escaping (MDOperationsResultWithCompletion<CDWordEntity>)) {
        
        readWords(byCourseUUID: uuid, fetchLimit: .zero, fetchOffset: .zero, completionHandler)
        
    }
    
}

// MARK: - Update
extension MDWordCoreDataStorage {
    
    func updateWord(byWordUUID uuid: UUID,
                    newWordText: String,
                    newWordDescription: String,
                    _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            let batchUpdateRequest = NSBatchUpdateRequest(entityName: MDCoreDataEntityName.CDWordEntity)
            
            batchUpdateRequest.propertiesToUpdate = [CDWordEntityAttributeName.wordText : newWordText,
                                                     CDWordEntityAttributeName.wordDescription : newWordDescription
            ]
            
            batchUpdateRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.uuid) == %i", uuid.uuidString)
            
            do {
                
                try self.managedObjectContext.execute(batchUpdateRequest)
                
                self.coreDataStack.save(managedObjectContext: self.managedObjectContext) { result in
                    
                    //
                    completionHandler(result)
                    //
                    
                    //
                    return
                    //
                    
                }
                
            } catch {
                
                //
                completionHandler(.failure(error))
                //
                
                //
                return
                //
                
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}

// MARK: - Delete
extension MDWordCoreDataStorage {
    
    func deleteWord(byWordUUID uuid: UUID,
                    _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: MDCoreDataEntityName.CDWordEntity)
            
            fetchRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.uuid) == %i", uuid.uuidString)
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                
                try self.managedObjectContext.execute(batchDeleteRequest)
                
                self.coreDataStack.save(managedObjectContext: self.managedObjectContext) { result in
                    
                    //
                    completionHandler(result)
                    //
                    
                    //
                    return
                    //
                    
                }
                
            } catch {
                
                //
                completionHandler(.failure(error))
                //
                
                //
                return
                //
                
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func deleteAllWords(byCourseUUID uuid: UUID,
                        _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: MDCoreDataEntityName.CDWordEntity)
            
            fetchRequest.predicate = NSPredicate(format: "\(CDCourseEntityAttributeName.uuid) == %i", uuid.uuidString)
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                
                try self.managedObjectContext.execute(batchDeleteRequest)
                
                self.coreDataStack.save(managedObjectContext: self.managedObjectContext) { result in
                    
                    //
                    completionHandler(result)
                    //
                    
                    //
                    return
                    //
                    
                }
                
            } catch {
                
                //
                completionHandler(.failure(error))
                //
                
                //
                return
                //
                
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func deleteAllWords(_ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: MDCoreDataEntityName.CDWordEntity)
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                
                try self.managedObjectContext.execute(batchDeleteRequest)
                
                self.coreDataStack.save(managedObjectContext: self.managedObjectContext) { result in
                    
                    //
                    completionHandler(result)
                    //
                    
                    //
                    return
                    //
                    
                }
                
            } catch {
                
                //
                completionHandler(.failure(error))
                //
                
                //
                return
                //
                
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}
