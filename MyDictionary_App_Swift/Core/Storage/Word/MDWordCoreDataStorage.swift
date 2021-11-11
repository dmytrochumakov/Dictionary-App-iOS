//
//  MDWordCoreDataStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation
import CoreData

protocol MDExistsWordByCourseUUIDProtocol {
    
    func exists(byCourseUUID courseUUID: UUID,
                _ completionHandler: @escaping (MDOperationResultWithCompletion<Bool>))
    
}

protocol MDExistsWordByCourseUUIDAndWordTextProtocol {
    
    func exists(byCourseUUID courseUUID: UUID,
                andWordText wordText: String,
                _ completionHandler: @escaping (MDOperationResultWithCompletion<Bool>))
    
}

protocol MDExistsWordProtocol: MDExistsWordByCourseUUIDProtocol,
                               MDExistsWordByCourseUUIDAndWordTextProtocol {
    
    
    
}

protocol MDWordCoreDataStorageProtocol: MDCRUDWordProtocol,
                                        MDStorageInterface,
                                        MDExistsWordProtocol {
    
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

// MARK: - Exists
extension MDWordCoreDataStorage {
    
    func exists(byCourseUUID courseUUID: UUID,
                _ completionHandler: @escaping (MDOperationResultWithCompletion<Bool>)) {
        
        let operation: BlockOperation = .init {
            
            //
            let fetchRequest = NSFetchRequest<CDWordEntity>(entityName: MDCoreDataEntityName.CDWordEntity)
            fetchRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.courseUUID) == %@", courseUUID.uuidString)
            //
            
            do {
                
                //
                completionHandler(.success(try self.managedObjectContext.count(for: fetchRequest) > .zero))
                //
                
                //
                return
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
    
    func exists(byCourseUUID courseUUID: UUID,
                andWordText wordText: String,
                _ completionHandler: @escaping (MDOperationResultWithCompletion<Bool>)) {
        
        let operation: BlockOperation = .init {
            
            //
            let fetchRequest = NSFetchRequest<CDWordEntity>(entityName: MDCoreDataEntityName.CDWordEntity)
            fetchRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.courseUUID) == %@ AND \(CDWordEntityAttributeName.wordText) == %@",
                                                 argumentArray: [courseUUID, wordText])
            //
            
            do {
                
                //
                completionHandler(.success(try self.managedObjectContext.count(for: fetchRequest) > .zero))
                //
                
                //
                return
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
    
}

// MARK: - Entities
extension MDWordCoreDataStorage {
    
    func entitiesCount(_ completionHandler: @escaping (MDEntitiesCountResultWithCompletion)) {
        self.readEntitiesCount() { result in
            switch result {
            case .success(let entitiesCount):
                completionHandler(.success(entitiesCount))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func entitiesIsEmpty(_ completionHandler: @escaping (MDEntitiesIsEmptyResultWithCompletion)) {
        self.readEntitiesCount() { result in
            switch result {
            case .success(let entitiesCount):
                completionHandler(.success(entitiesCount == .zero))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}

// MARK: - Create
extension MDWordCoreDataStorage {
    
    func createWord(courseUUID: UUID,
                    uuid: UUID,
                    wordText: String,
                    wordDescription: String,
                    createdAt: Date,
                    _ completionHandler: @escaping (MDOperationResultWithCompletion<CDWordEntity>)) {
        
        let operation: BlockOperation = .init {
            
            // Create New Entity
            let newWordEntity: CDWordEntity = .init(context: self.managedObjectContext)
            
            newWordEntity.courseUUID = courseUUID
            newWordEntity.uuid = uuid
            newWordEntity.wordText = wordText
            newWordEntity.wordDescription = wordDescription
            newWordEntity.createdAt = createdAt
            //
            
            // Save
            self.coreDataStack.save(managedObjectContext: self.managedObjectContext) { result in
                
                switch result {
                    
                case .success:
                    
                    //
                    completionHandler(.success((newWordEntity)))
                    
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
    
    func readWord(byCourseUUID courseUUID: UUID,
                  andWordText wordText: String,
                  _ completionHandler: @escaping (MDOperationResultWithCompletion<CDWordEntity>)) {
        
        let operation: BlockOperation = .init {
            
            //
            let fetchRequest = NSFetchRequest<CDWordEntity>(entityName: MDCoreDataEntityName.CDWordEntity)
            fetchRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.courseUUID) == %@ AND \(CDWordEntityAttributeName.wordText) == %@",
                                                 argumentArray: [courseUUID, wordText])
            //
            
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
                   ascending: Bool,
                   _ completionHandler: @escaping (MDOperationsResultWithCompletion<CDWordEntity>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<CDWordEntity>(entityName: MDCoreDataEntityName.CDWordEntity)
            
            fetchRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.courseUUID) == %@", uuid.uuidString)
            fetchRequest.fetchLimit = fetchLimit
            fetchRequest.fetchOffset = fetchOffset
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(CDWordEntity.createdAt),
                                                             ascending: ascending)]
            
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
                   ascending: Bool,
                   _ completionHandler: @escaping (MDOperationsResultWithCompletion<CDWordEntity>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<CDWordEntity>(entityName: MDCoreDataEntityName.CDWordEntity)
            
            fetchRequest.fetchLimit = fetchLimit
            fetchRequest.fetchOffset = fetchOffset
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(CDWordEntity.createdAt),
                                                             ascending: ascending)]
            
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
    
    func readAllWords(ascending: Bool,
                      _ completionHandler: @escaping (MDOperationsResultWithCompletion<CDWordEntity>)) {
        
        readWords(fetchLimit: .zero, fetchOffset: .zero, ascending: ascending, completionHandler)
        
    }
    
    func readAllWords(byCourseUUID uuid: UUID,
                      ascending: Bool,
                      _ completionHandler: @escaping (MDOperationsResultWithCompletion<CDWordEntity>)) {
        
        readWords(byCourseUUID: uuid, fetchLimit: .zero, fetchOffset: .zero, ascending: ascending, completionHandler)
        
    }
    
    func readEntitiesCount(_ completionHandler: @escaping(MDEntitiesCountResultWithCompletion)) {
        
        let operation: BlockOperation = .init {
            
            //
            let fetchRequest = NSFetchRequest<CDWordEntity>(entityName: MDCoreDataEntityName.CDWordEntity)
            //
            
            do {
                
                //
                completionHandler(.success(try self.managedObjectContext.count(for: fetchRequest)))
                //
                
                //
                return
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
    
}

// MARK: - Update
extension MDWordCoreDataStorage {
    
    func updateWordTextAndWordDescription(byCourseUUID courseUUID: UUID,
                                          andWordUUID wordUUID: UUID,
                                          newWordText: String,
                                          newWordDescription: String,
                                          _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            let batchUpdateRequest = NSBatchUpdateRequest(entityName: MDCoreDataEntityName.CDWordEntity)
            
            batchUpdateRequest.propertiesToUpdate = [CDWordEntityAttributeName.wordText : newWordText,
                                                     CDWordEntityAttributeName.wordDescription : newWordDescription
            ]
            
            batchUpdateRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.courseUUID) == %@ AND \(CDWordEntityAttributeName.uuid) == %@",
                                                       argumentArray: [courseUUID, wordUUID])
            //
            
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
    
    func updateWordDescription(byCourseUUID courseUUID: UUID,
                               andWordUUID wordUUID: UUID,
                               newWordDescription: String,
                               _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            let batchUpdateRequest = NSBatchUpdateRequest(entityName: MDCoreDataEntityName.CDWordEntity)
            
            batchUpdateRequest.propertiesToUpdate = [CDWordEntityAttributeName.wordDescription : newWordDescription]
            
            batchUpdateRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.courseUUID) == %@ AND \(CDWordEntityAttributeName.uuid) == %@",
                                                       argumentArray: [courseUUID, wordUUID])
            //
            
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
            
            fetchRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.uuid) == %@", uuid.uuidString)
            
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
            
            fetchRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.courseUUID) == %@", uuid.uuidString)
            
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
