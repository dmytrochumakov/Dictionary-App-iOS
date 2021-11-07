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
        self.readAllCourses { result in
            switch result {
            case .success(let entities):
                completionHandler(.success(entities.count))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func entitiesIsEmpty(_ completionHandler: @escaping(MDEntitiesIsEmptyResultWithCompletion)) {
        self.readAllCourses { result in
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
extension MDCourseCoreDataStorage {
    
    func createCourse(_ courseEntity: CDCourseEntity,
                      _ completionHandler: @escaping (MDOperationResultWithCompletion<CDCourseEntity>)) {
        
        let operation: BlockOperation = .init {
            
            let newCourseEntity = courseEntity.cdCourseResponseEntity(context: self.managedObjectContext)
            
            self.coreDataStack.save(managedObjectContext: self.managedObjectContext) { result in
                
                switch result {
                    
                case .success:
                    
                    //
                    completionHandler(.success((newCourseEntity.courseResponse)))
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
    
    func createCourses(_ courseEntities: [CDCourseEntity],
                       _ completionHandler: @escaping (MDOperationsResultWithCompletion<CDCourseEntity>)) {
        
        let operation: BlockOperation = .init {
            
            if (courseEntities.isEmpty) {
                
                //
                completionHandler(.success(courseEntities))
                //
                
                //
                return
                //
                
            } else {
                
                var resultCount: Int = .zero
                
                courseEntities.forEach { courseEntity in
                    
                    let _ = courseEntity.cdCourseResponseEntity(context: self.managedObjectContext)                    
                    
                    self.coreDataStack.save(managedObjectContext: self.managedObjectContext) { result in
                        
                        switch result {
                            
                        case .success:
                            
                            //
                            resultCount += 1
                            //
                            
                            if (resultCount == courseEntities.count) {
                                
                                //
                                completionHandler(.success(courseEntities))
                                //
                                
                            }
                            
                            //
                            break
                            //
                            
                        case .failure(let error):
                            
                            //
                            completionHandler(.failure(error))
                            
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
extension MDCourseCoreDataStorage {
    
    func readCourse(fromCourseId courseId: Int64,
                    _ completionHandler: @escaping (MDOperationResultWithCompletion<CDCourseEntity>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<CDCourseResponseEntity>(entityName: CoreDataEntityName.CDCourseResponseEntity)
            fetchRequest.predicate = NSPredicate(format: "\(CDCourseEntityAttributeName.courseId) == %i", courseId)
            
            do {
                if let courseEntity = try self.managedObjectContext.fetch(fetchRequest).map({ $0.courseResponse }).first {
                    
                    //
                    completionHandler(.success(courseEntity))
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
    
    func readAllCourses(_ completionHandler: @escaping (MDOperationResultWithCompletion<[CDCourseEntity]>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<CDCourseResponseEntity>(entityName: CoreDataEntityName.CDCourseResponseEntity)
            
            do {
                
                //
                completionHandler(.success(try self.managedObjectContext.fetch(fetchRequest).map({ $0.courseResponse })))
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
    
    func deleteCourse(fromCourseId courseId: Int64,
                      _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.CDCourseResponseEntity)
            fetchRequest.predicate = NSPredicate(format: "\(CDCourseEntityAttributeName.courseId) == %i", courseId)
            
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
    
    func deleteAllCourses(_ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.CDCourseResponseEntity)
            
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
    
}
