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
    
    func createWord(_ wordModel: CDWordEntity,
                    _ completionHandler: @escaping (MDOperationResultWithCompletion<CDWordEntity>)) {
        
        let operation: BlockOperation = .init {
            
            let newWord = wordModel.cdWordEntity(context: self.managedObjectContext)
            
            self.coreDataStack.save(managedObjectContext: self.managedObjectContext) { result in
                
                switch result {
                    
                case .success:
                    
                    //
                    completionHandler(.success((newWord.wordResponse)))
                    
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
    
    func createWords(_ wordModels: [CDWordEntity],
                     _ completionHandler: @escaping (MDOperationsResultWithCompletion<CDWordEntity>)) {
        
        let operation: BlockOperation = .init {
            
            if (wordModels.isEmpty) {
                
                //
                completionHandler(.success(wordModels))
                //
                
                //
                return
                //
                
            } else {
                
                var resultCount: Int = .zero
                
                wordModels.forEach { word in
                    
                    let _ = word.cdWordEntity(context: self.managedObjectContext)
                    
                    self.coreDataStack.save(managedObjectContext: self.managedObjectContext) { result in
                        
                        switch result {
                            
                        case .success:
                            
                            //
                            resultCount += 1
                            //
                            
                            if (resultCount == wordModels.count) {
                                
                                //
                                completionHandler(.success(wordModels))
                                //
                                
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
extension MDWordCoreDataStorage {
    
    func readWord(fromWordID wordId: Int64,
                  _ completionHandler: @escaping (MDOperationResultWithCompletion<CDWordEntity>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<CDWordResponseEntity>(entityName: CoreDataEntityName.CDWordResponseEntity)
            fetchRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.wordId) == %i", wordId)
            
            do {
                if let result = try self.managedObjectContext.fetch(fetchRequest).map({ $0.wordResponse }).first {
                    
                    //
                    completionHandler(.success(result))
                    //
                    
                    //
                    return
                    //
                    
                } else {
                    
                    //
                    completionHandler(.failure(MDEntityOperationError.cantFindEntity))
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
    
    func readWords(fetchLimit: Int,
                   fetchOffset: Int,
                   _ completionHandler: @escaping (MDOperationsResultWithCompletion<CDWordEntity>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<CDWordResponseEntity>(entityName: CoreDataEntityName.CDWordResponseEntity)
            
            fetchRequest.fetchLimit = fetchLimit
            fetchRequest.fetchOffset = fetchOffset
            
            do {
                
                //
                completionHandler(.success(try self.managedObjectContext.fetch(fetchRequest).map({ $0.wordResponse })))
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
    
    func readAllWords(_ completionHandler: @escaping (MDOperationsResultWithCompletion<CDWordEntity>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<CDWordResponseEntity>(entityName: CoreDataEntityName.CDWordResponseEntity)
            
            fetchRequest.fetchLimit = .zero
            fetchRequest.fetchOffset = .zero
            
            do {
                
                //
                completionHandler(.success(try self.managedObjectContext.fetch(fetchRequest).map({ $0.wordResponse })))
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
    
    func readAllWords(byCourseID courseID: Int64,
                      _ completionHandler: @escaping (MDOperationsResultWithCompletion<CDWordEntity>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<CDWordResponseEntity>(entityName: CoreDataEntityName.CDWordResponseEntity)
            fetchRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.courseId) == %i", courseID)
            
            do {
                
                //
                completionHandler(.success(try self.managedObjectContext.fetch(fetchRequest).map({ $0.wordResponse })))
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
    
    func updateWord(byWordID wordId: Int64,
                    newWordText: String,
                    newWordDescription: String,
                    _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            let batchUpdateRequest = NSBatchUpdateRequest(entityName: CoreDataEntityName.CDWordResponseEntity)
            
            batchUpdateRequest.propertiesToUpdate = [CDWordEntityAttributeName.wordText : newWordText,
                                                     CDWordEntityAttributeName.wordDescription : newWordDescription
            ]
            
            batchUpdateRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.wordId) == %i", wordId)
            
            do {
                
                try self.managedObjectContext.execute(batchUpdateRequest)
                
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
    
    func deleteWord(byWordId wordId: Int64,
                    _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.CDWordResponseEntity)
            
            fetchRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.wordId) == %i", wordId)
            
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
    
    func deleteAllWords(byCourseId courseId: Int64,
                        _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.CDWordResponseEntity)
            
            fetchRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.courseId) == %i", courseId)
            
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
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.CDWordResponseEntity)
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                
                try self.managedObjectContext.execute(batchDeleteRequest)
                
                self.coreDataStack.save(managedObjectContext: self.managedObjectContext) { result in
                    
                    switch result {
                        
                    case .success:
                        
                        //
                        completionHandler(.success(()))
                        
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
