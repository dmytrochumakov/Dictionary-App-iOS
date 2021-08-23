//
//  MDCourseMemoryStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDCourseMemoryStorageProtocol: MDCRUDCourseProtocol,
                                        MDEntitiesCountProtocol,
                                        MDEntitiesIsEmptyProtocol {
    
}

final class MDCourseMemoryStorage: MDCourseMemoryStorageProtocol {
    
    fileprivate let operationQueueService: OperationQueueServiceProtocol
    
    var array: [CourseEntity]
    
    init(operationQueueService: OperationQueueServiceProtocol,
         array: [CourseEntity]) {
        
        self.operationQueueService = operationQueueService
        self.array = array
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Entities
extension MDCourseMemoryStorage {
    
    func entitiesCount(_ completionHandler: @escaping (MDEntitiesCountResultWithCompletion)) {
        
    }
    
    func entitiesIsEmpty(_ completionHandler: @escaping (MDEntitiesIsEmptyResultWithCompletion)) {
        
    }
    
}

// MARK: - CRUD
extension MDCourseMemoryStorage {
    
    func createCourse(_ courseEntity: CourseEntity, _ completionHandler: @escaping (MDEntityResult<CourseEntity>)) {
        let operation: MDCreateCourseMemoryStorageOperation = .init(memoryStorage: self,
                                                                    courseEntity: courseEntity) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readCourse(fromCourseId courseId: Int64, _ completionHandler: @escaping (MDEntityResult<CourseEntity>)) {
        let operation: MDReadCourseMemoryStorageOperation = .init(memoryStorage: self,
                                                                  courseId: courseId) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readAllCourses(_ completionHandler: @escaping (MDEntityResult<[CourseEntity]>)) {
        
    }
    
    func deleteCourse(fromCourseId courseId: Int64, _ completionHandler: @escaping (MDEntityResult<CourseEntity>)) {
        
    }
    
    func deleteAllCourses(_ completionHandler: @escaping (MDEntityResult<Void>)) {
        
    }
    
}
