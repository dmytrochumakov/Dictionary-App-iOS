//
//  MDCourseCoreDataStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation
import CoreData

protocol MDCourseCoreDataStorageProtocol: MDCRUDCourseProtocol,
                                          MDStorageInterface {
    
}

final class MDCourseCoreDataStorage: MDCourseCoreDataStorageProtocol {
    
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
extension MDCourseCoreDataStorage {
    
    func entitiesCount(_ completionHandler: @escaping(MDEntitiesCountResultWithCompletion)) {
        self.readEntitiesCount() { result in
            switch result {
            case .success(let entitiesCount):
                completionHandler(.success(entitiesCount))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func entitiesIsEmpty(_ completionHandler: @escaping(MDEntitiesIsEmptyResultWithCompletion)) {
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
extension MDCourseCoreDataStorage {
    
    func createCourse(uuid: UUID,
                      languageId: Int16,
                      createdAt: Date,
                      _ completionHandler: @escaping (MDOperationResultWithCompletion<CDCourseEntity>)) {
        
        let operation: BlockOperation = .init {
            
            // Create New Entity
            let newCourseEntity: CDCourseEntity = .init(context: self.managedObjectContext)
            
            newCourseEntity.uuid = uuid
            newCourseEntity.languageId = languageId
            newCourseEntity.createdAt = createdAt
            //
            
            // Save
            self.coreDataStack.save(managedObjectContext: self.managedObjectContext) { result in
                
                switch result {
                    
                case .success:
                    
                    //
                    completionHandler(.success((newCourseEntity)))
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
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}

// MARK: - Read
extension MDCourseCoreDataStorage {
    
    func readCourse(byCourseUUID uuid: UUID,
                    _ completionHandler: @escaping (MDOperationResultWithCompletion<CDCourseEntity>)) {
        
        let operation: BlockOperation = .init {
            
            //
            let fetchRequest = NSFetchRequest<CDCourseEntity>(entityName: MDCoreDataEntityName.CDCourseEntity)
            fetchRequest.predicate = NSPredicate(format: "\(CDCourseEntityAttributeName.uuid) == %@", uuid.uuidString)
            //
            
            //
            let asyncFetchRequest = NSAsynchronousFetchRequest.init(fetchRequest: fetchRequest) { asynchronousFetchResult in
                
                guard let finalResult = asynchronousFetchResult.finalResult?.first else {
                    
                    //
                    completionHandler(.failure(MDEntityOperationError.cantFindEntity))
                    //
                    
                    //
                    return
                    //
                    
                }
                
                //
                completionHandler(.success(finalResult))
                //
                
                //
                return
                //
                
            }
            //
            
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
    
    func readCourses(fetchLimit: Int,
                     fetchOffset: Int,
                     ascending: Bool,
                     _ completionHandler: @escaping (MDOperationsResultWithCompletion<CDCourseEntity>)) {
        
        let operation: BlockOperation = .init {
            
            //
            let fetchRequest = NSFetchRequest<CDCourseEntity>(entityName: MDCoreDataEntityName.CDCourseEntity)
            fetchRequest.fetchLimit = fetchLimit
            fetchRequest.fetchOffset = fetchOffset
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(CDCourseEntity.createdAt),
                                                             ascending: ascending)]
            //
            
            //
            let asyncFetchRequest = NSAsynchronousFetchRequest.init(fetchRequest: fetchRequest) { asynchronousFetchResult in
                
                guard let finalResult = asynchronousFetchResult.finalResult else {
                    
                    //
                    completionHandler(.failure(MDEntityOperationError.cantFindEntity))
                    //
                    
                    //
                    return
                    //
                    
                }
                
                //
                completionHandler(.success(finalResult))
                //
                
                //
                return
                //
                
            }
            //
            
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
    
    func readAllCourses(ascending: Bool, _ completionHandler: @escaping (MDOperationsResultWithCompletion<CDCourseEntity>)) {
        readCourses(fetchLimit: .zero, fetchOffset: .zero, ascending: ascending, completionHandler)
    }
    
    func readEntitiesCount(_ completionHandler: @escaping(MDEntitiesCountResultWithCompletion)) {
        
        let operation: BlockOperation = .init {
            
            //
            let fetchRequest = NSFetchRequest<CDCourseEntity>(entityName: MDCoreDataEntityName.CDCourseEntity)
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

// MARK: - Delete
extension MDCourseCoreDataStorage {
    
    func deleteCourse(byCourseUUID uuid: UUID,
                      _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: MDCoreDataEntityName.CDCourseEntity)
            fetchRequest.predicate = NSPredicate(format: "\(CDCourseEntityAttributeName.uuid) == %@", uuid.uuidString)
            
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
    
    func deleteAllCourses(_ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: MDCoreDataEntityName.CDCourseEntity)
            
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
