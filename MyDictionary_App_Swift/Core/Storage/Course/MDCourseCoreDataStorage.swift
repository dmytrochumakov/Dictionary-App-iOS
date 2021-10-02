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
    
    fileprivate let operationQueueService: MDOperationQueueServiceProtocol
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: MDCoreDataStack
    
    init(operationQueueService: MDOperationQueueServiceProtocol,
         managedObjectContext: NSManagedObjectContext,
         coreDataStack: MDCoreDataStack) {
        
        self.operationQueueService = operationQueueService
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

// MARK: - CRUD
extension MDCourseCoreDataStorage {
    
    func createCourse(_ courseEntity: CourseResponse, _ completionHandler: @escaping (MDOperationResultWithCompletion<CourseResponse>)) {
        let operation: MDCreateCourseCoreDataStorageOperation = .init(managedObjectContext: self.managedObjectContext,
                                                                      coreDataStack: self.coreDataStack,
                                                                      coreDataStorage: self,
                                                                      courseEntity: courseEntity) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func createCourses(_ courseEntities: [CourseResponse], _ completionHandler: @escaping (MDOperationsResultWithCompletion<CourseResponse>)) {
        let operation: MDCreateCoursesCoreDataStorageOperation = .init(managedObjectContext: self.managedObjectContext,
                                                                       coreDataStack: self.coreDataStack,
                                                                       coreDataStorage: self,
                                                                       courseEntities: courseEntities) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readCourse(fromCourseId courseId: Int64, _ completionHandler: @escaping (MDOperationResultWithCompletion<CourseResponse>)) {
        let operation: MDReadCourseCoreDataStorageOperation = .init(managedObjectContext: self.managedObjectContext,
                                                                    coreDataStorage: self,
                                                                    courseId: courseId) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readAllCourses(_ completionHandler: @escaping (MDOperationResultWithCompletion<[CourseResponse]>)) {
        let operation: MDReadAllCoursesCoreDataStorageOperation = .init(managedObjectContext: self.managedObjectContext,
                                                                        coreDataStorage: self) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func deleteCourse(fromCourseId courseId: Int64, _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        let operation: MDDeleteCourseCoreDataStorageOperation = .init(managedObjectContext: self.managedObjectContext,
                                                                      coreDataStack: self.coreDataStack,
                                                                      coreDataStorage: self,
                                                                      courseId: courseId) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func deleteAllCourses(_ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        let operation: MDDeleteAllCoursesCoreDataStorageOperation = .init(managedObjectContext: self.managedObjectContext,
                                                                          coreDataStack: self.coreDataStack,
                                                                          coreDataStorage: self) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}
